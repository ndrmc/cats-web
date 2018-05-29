require 'prawn/table'
class TransportRequisitionPdf < PdfReport
    def initialize(tr_id, reason_for_idps, cc_letter_to,  reference_numbers, project)
        super top_margin: 50, :page_size => "A4", :position => :center, :page_layout => :portrait
        @transport_requisition = TransportRequisition.find(tr_id)
        @list_of_tris = TransportRequisition.joins(transport_requisition_items: [:commodity, :requisition, fdp: :location]).find(tr_id).transport_requisition_items
        @operation = Operation.includes(:program).find(@transport_requisition.operation_id)
        @reason_for_idps = reason_for_idps
        @tri_struct = []
        @total_amount = 0
        @list_of_tris.find_each do |tri|
            #project code id must be retrived with requition_id and fdp_id
         project_id = ProjectCodeAllocation.where(requisition_id: tri.requisition_id).limit(1).pluck(:project_id)
         warehouse_id = WarehouseAllocationItem.where(requisition_id: tri.requisition_id,fdp_id: tri.fdp_id).limit(1).pluck(:warehouse_id)
         tri_full = OpenStruct.new
          tri_full.tri_id = tri.id
          tri_full.commodity_id = tri.commodity_id
          tri_full.commodity_name = tri.commodity.name
          tri_full.requisition_id = tri.requisition_id
          tri_full.requisition_no = tri.requisition.requisition_no
          tri_full.quantity = tri.quantity
          if warehouse_id.present? 
              if warehouse_id[0].to_i > 0
                 tri_full.warehouse = Warehouse.find(warehouse_id[0].to_i).name
              end
          end

          if project_id.present? 
             organization_id =  Project.find(project_id[0].to_i).organization_id
             tri_full.donor = Organization.find(organization_id).name
          end
            
          tri_full.fdp_id = tri.fdp_id
          tri_full.fdp_name = tri.fdp.name
          tri_full.woreda_id = tri.fdp.location_id
          tri_full.woreda_name = tri.fdp.location.name
          tri_full.zone_id = tri.fdp.location.parent.id
          tri_full.zone_name = tri.fdp.location.parent.name
          tri_full.region_id = tri.fdp.location.parent.parent.id
          tri_full.region_name = tri.fdp.location.parent.parent.name
          @tri_struct << tri_full.to_h
        end    
        tri_full_list = @tri_struct

        @aggr_tri = tri_full_list.group_by { |h| h[:requisition_id] }.map do |a,b| 
            {:requisition_id => a.to_s, :quantity => b.map {|h1| h1[:quantity]}.inject(:+)} 
        end

        @cc_letter_to = cc_letter_to
        @reference_numbers  =  reference_numbers
        @project = project
        header "Transport Requisition Form"
        text "Date " + Time.now.strftime("%d-%b-%Y"), :align => :right
        text "No " + @transport_requisition.reference_number, :align => :right
        text "Reference No " + @reference_numbers.to_s, :align => :right
       
          bounding_box([bounds.left, bounds.top - 130 ], :width => bounds.width, :height => bounds.height - 200) do
        transport_requisitions
        text "\n"
        text "\n"
        remark_section
        text "\n"
        text "\n"
        signature_section
        end
        footer "Commodity Allocation and Tracking System"
    end

    def transport_requisitions
       
        table transport_requisition_items do
            row(0).font_style = :bold
            row(-1).font_style = :bold
            # columns(1..3).align = :right
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.header = true
            columns(2..8).width = 50
            columns(9).width = 70
            columns(7).width = 60
            columns(5).width = 70
        end     
     
    end

    def signature_section
        table_data = [
            [
                {
                    :content => "Requested by: ................................................",
                    :padding_left => 30
                },
                {
                    :content => "Certified by: ................................................",
                    :padding_left => 100
                }
            ]
        ]

        table(table_data, :width => 500, :cell_style => { :inline_format => true }) do |t|
            t.cells.border_width = 0
        end
    end

    

    def signature_section
        table_data = [
            [
                {
                    :content => "Requested by: ................................................",
                    :padding_left => 30
                },
                {
                    :content => "Certified by: ................................................",
                    :padding_left => 100
                }
            ]
        ]

        table(table_data, :width => 500, :cell_style => { :inline_format => true }) do |t|
            t.cells.border_width = 0
        end
    end

    def remark_section
        table_data = [
          
            [{:content => "<b><u>Remark:</u></b>", :colspan => 2, :align => :center}],
            [
                {
                    :content => "For Information\n" +
                                "Information Center /LCT/\n" +
                                "Addis Ababa\n\n\n" +
                                "CC\n" +
                                @cc_letter_to,
                                # "Mekele Central Ware House\n" +
                                # "<u>Mekele<u>",
                    :width => 100,
                    :padding_left => 30
                },
                {
                    :content => "Allocated for " + @operation.program.name + "\n" +
                                @reason_for_idps.to_s + "\n" +
                                "Date of req " + Time.now.strftime("%d-%b-%Y") + "\n" +
                                "Received Date " + Time.now.strftime("%d-%b-%Y") + "\n" +
                                
                                "For  " + @operation.name,
                    :width => 100,
                    :padding_left => 75
                }
            ]
        ]

        table(table_data, :width => 500, :cell_style => { :inline_format => true }) do |t|
            t.cells.border_width = 0
            # t.cells.padding = 0
        end
    end

    def transport_requisition_items
        dynamic_data = []
        dynamic_data = ["No","Items","Req.No","Donor","Amount(QTL)", "Warehouse","Region","Zone","Woreda","Destination"]
        total_allocation = 0.00
        row_no = 0
        $sum = 0
        @donor = ""
        if @operation.program.name == "Relief"
            @donor = "NDRMC"
        elsif @operation.program.name == "FSCD"
            @donor = "FSCD"
        elsif @operation.program.name == "IDPs"
            @donor = "NDRMC"
        end
        result = [dynamic_data] +
        @aggr_tri.map do |item|
            target_unit = UnitOfMeasure.where(:code => "QTL").first
            current_unit = UnitOfMeasure.where(:code => "MT").first
            amount_in_qtl = target_unit.convert_to(current_unit.name, item[:quantity])
            amount_in_qtl = amount_in_qtl.round(2)
            @total_amount = amount_in_qtl

            if @operation.program.name == "IDPs"
                amount_in_qtl = item[:quantity]
            end
            # ref = @tri_struct.where(:requsition_id => item[:requisition_id]).first
            # ref = @tri_struct.select {|tri| tri[:requsition_id] == item[:requisition_id] }
            ref = @tri_struct.find {|x| x[:requisition_id].to_s == item[:requisition_id].to_s}
            total_allocation = total_allocation + amount_in_qtl
            row_no = row_no + 1
            $sum = $sum + @total_amount
            [row_no, ref[:commodity_name],ref[:requisition_no],@donor,amount_in_qtl,ref[:warehouse],ref[:region_name],ref[:zone_name], "As per the attached list", "As per the attached list"]
        end 
        
        result = result + [["Total", "-", "-", "-", $sum.round(2), "-", "-", "-", "-", "-"]]
    end    
end