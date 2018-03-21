require 'prawn/table'
class TransportRequisitionPdf < PdfReport
    def initialize(tr_id, reason_for_idps, cc_letter_to)
        super top_margin: 50, :page_size => "A4", :page_layout => :portrait
        @transport_requisition = TransportRequisition.find(tr_id)
        @list_of_tris = TransportRequisition.joins(transport_requisition_items: [:commodity, :requisition, fdp: :location]).find(tr_id).transport_requisition_items
        @operation = Operation.includes(:program).find(@transport_requisition.operation_id)
        @tri_struct = []
        @list_of_tris.find_each do |tri|
         tri_full = OpenStruct.new
          tri_full.tri_id = tri.id
          tri_full.commodity_id = tri.commodity_id
          tri_full.commodity_name = tri.commodity.name
          tri_full.requisition_id = tri.requisition_id
          tri_full.requisition_no = tri.requisition.requisition_no
          tri_full.quantity = tri.quantity
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

        header "Transport Requisition Form"
        text "Date " + Time.now.strftime("%d-%b-%Y"), :align => :right
        text "No " + @transport_requisition.reference_number, :align => :right
        text "\n"
        transport_requisitions
        text "\n"
        text "\n"
        text "Remark:- Allocated for " + @operation.program.name
        text reason_for_idps
        text "Date of req " + Time.now.strftime("%d-%b-%Y")
        text "Received Date " + Time.now.strftime("%d-%b-%Y")
        text "For the Month of " + @operation.round.to_s + " round " + Date::MONTHNAMES[@operation.month] + " " + @operation.year
        text "\n"
        text "\n"
        text cc_letter_to
        text "\n\n"
        text "Requested by: ...................................................    Certified by: ..................................................."
        footer "Commodity Allocation and Tracking System"
    end

    def transport_requisitions
        table transport_requisition_items do
        row(0).font_style = :bold
        # columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
        end
    end

    def transport_requisition_items
        dynamic_data = []
        dynamic_data = ["No","Items","Req.No","Donor","Amount(QTL)", "Warehouse","Region","Zone","Woreda","Destination"]
        total_allocation = 0.00
        row_no = 0
        [dynamic_data] +
        @aggr_tri.map do |item|
            target_unit = UnitOfMeasure.where(:code => "QTL").first
            current_unit = UnitOfMeasure.where(:code => "MT").first
            amount_in_qtl = target_unit.convert_to(current_unit.name, item[:quantity])
            # ref = @tri_struct.where(:requsition_id => item[:requisition_id]).first
            # ref = @tri_struct.select {|tri| tri[:requsition_id] == item[:requisition_id] }
            ref = @tri_struct.find {|x| x[:requisition_id].to_s == item[:requisition_id].to_s}
            total_allocation = total_allocation + amount_in_qtl
            row_no = row_no + 1
            [row_no, ref[:commodity_name],ref[:requisition_no],"-",amount_in_qtl,"-",ref[:region_name],ref[:zone_name], "As per the attached list", "As per the attached list"]
        end
    end    
end