require 'prawn/table'
class TransportRequisitionWithoutWinnerPdf < PdfReport
    def initialize(transport_requisition_detail,operation,reference_numbers)
     super top_margin: 50, :page_size => "A4", :position => :center, :page_layout => :portrait
        @transport_requisition_detail = transport_requisition_detail
        @operation = operation
        @reference_numbers = reference_numbers
        header "Transport Requisition withou out transporters"
         bounding_box([bounds.left, bounds.top -  100 ], :width => bounds.width, :height => bounds.height - 210) do
        text "Date " + Time.now.strftime("%d-%b-%Y"), :align => :right
        text "Reference No " + @reference_numbers.to_s, :align => :right
      
        

        transport_requisitions
        end
        footer "Commodity Allocation and Tracking System"
    end

    def transport_requisitions
       
        table transport_requisition_items do
            row(0).font_style = :bold
            row(-1).font_style = :bold
            # columns(1..3).align = :right
            # self.row_colors = ["DDDDDD", "FFFFFF"]
            self.header = true
            columns(0).width = 30
            columns(1).width = 40
            columns(2..4).width = 50
            columns(5).width = 40
            columns(6..8).width = 50
        end    
    
        move_down 10
           text "Operation: " + @operation&.name
           text "Total sum in Quintal: " + ActiveSupport::NumberHelper.number_to_currency(@quintal_sum.to_s,precision: 2, :unit=> '')
           text "Total sum in PC:" +  ActiveSupport::NumberHelper.number_to_currency(@pc_sum.to_s, precision: 2, :unit=> '')
           text "Total sum in carton:" +  ActiveSupport::NumberHelper.number_to_currency(@carton_sum.to_s, precision: 2,:unit=> ' ')
           text "Other: " +  ActiveSupport::NumberHelper.number_to_currency(@other_sum.to_s, precision: 2,:unit=> ' ') 
    end

    def transport_requisition_items
        dynamic_data = []
        dynamic_data = ["No","Items","Req.No","Donor","Amount", "Unit", "W.House","Region","Zone","Woreda","Destination"]
        row_no = 0

         target_unit = UnitOfMeasure.where(:code => "QTL").first
         current_unit = UnitOfMeasure.where(:code => "MT").first
         carton_unit = UnitOfMeasure.where(:code => "CTN").first
         pc_unit = UnitOfMeasure.where(:code => "PCS").first
         @carton_sum = @pc_sum = @quintal_sum = @other_sum = 0

        result = [dynamic_data] +
        @transport_requisition_detail.map do |item|
            
            fdp = Fdp.find(item.fdp_id)
        @donor = ""
        if @operation.program.name == "Relief" || @operation.program.name == "IDPs"
            @donor = "NDRMC"
        elsif @operation.program.name == "FSCD"
            @donor = "FSCD"
        end

         amount_in_qtl = target_unit.convert_to(current_unit.name, item[:quantity])
            amount_in_qtl = amount_in_qtl.round(2)
            @total_amount = amount_in_qtl
            
           
            @uom_id = @operation.ration.ration_items.where(commodity_id: item.commodity_id).first&.unit_of_measure_id
            
            @uom_name = UnitOfMeasure.find_by(id: @uom_id)&.code
            

            if @operation.program.name == "IDPs" && @uom_name != target_unit&.code
                amount_in_qtl = item[:quantity].round
            end

            
            row_no = row_no + 1
            #$sum = $sum + @total_amount

            if @uom_name ==  pc_unit&.code
                @pc_sum = @pc_sum + amount_in_qtl
            elsif @uom_name ==  carton_unit&.code
                @carton_sum = @carton_sum + amount_in_qtl
            elsif @uom_name == target_unit&.code
                @quintal_sum = @quintal_sum + amount_in_qtl
            else
                @other_sum = @other_sum + amount_in_qtl
            end

            warehouse_id = WarehouseAllocationItem.where(requisition_id: item.requisition_id ,fdp_id: item.fdp_id).limit(1).pluck(:warehouse_id)
            if warehouse_id.present? 
             if warehouse_id[0].to_i > 0
                 @warehouse = Warehouse.find(warehouse_id[0].to_i).name
                end
              end
          

            [row_no,item&.commodity&.name,Requisition.find(item.requisition_id).requisition_no, @donor,amount_in_qtl, @uom_name, @warehouse,fdp.location.parent.parent.name,fdp.location.parent.name,fdp.location.name,fdp.name]
        end
    end
end

