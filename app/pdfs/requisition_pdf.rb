require 'prawn/table'
class RequisitionPdf < PdfReport
    def initialize(requisition_item_obj, total_beneficiary_no, total_amount, references)
        super(top_margin: 50)
        @requisition_item_objs = requisition_item_obj
        @requisition = @requisition_item_objs.first.requisition
        @total_beneficiary_no = total_beneficiary_no
        @total_amount = total_amount
        @references = references
        header "Allocation for #{Operation.find(@requisition.operation_id).name} "
       
        requisitions
        
        footer "Commodity Allocation and Tracking System"
    end

    def requisitions
        bounding_box([bounds.left, bounds.top - 75 ], :width => bounds.width, :height => bounds.height - 173) do
        table requisition_item do
        row(0).font_style = :bold
        columns(1..3).align = :right
        # self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
        end
        move_down  10
        text "Total Beneficiaries: " + ActiveSupport::NumberHelper.number_to_currency(@total_beneficiary_no.to_s,precision: 2, :unit=> '')  
        move_down 1
        text "Total Amount: " + ActiveSupport::NumberHelper.number_to_currency(@total_amount.to_s,precision: 2, :unit=> '') + UnitOfMeasure.find(@uom_id).name
        text "Reference No " +  @references.to_s
        text "\n"
        text "\n"
        text "\n"
        text "Prepared by: ...................................................    Certified by: ..................................................."
        end
    end

    def requisition_item
        dynamic_data = []
        dynamic_data = ["Item","Req.No","Beneficiary No","Amount", "Unit","Region","Zone","Woreda","Destination"]
        @uom_id = @requisition.ration.ration_items.where(commodity_id: @requisition.commodity_id).first.unit_of_measure_id
        [dynamic_data] +
        @requisition_item_objs.map do |item|
            # target_unit = UnitOfMeasure.find_by(name: "Quintal")
            # current_unit = UnitOfMeasure.find(@uom_id)
            # amount_in_qtl = target_unit.convert_to(current_unit.name, item.amount)
            [item.requisition.commodity.name,item.requisition.requisition_no, item.beneficiary_no, item.amount, UnitOfMeasure.find(@uom_id).name, item.fdp.location.parent.parent.name, item.fdp.location.parent.name, item.fdp.location.name, item.fdp.name]       
        end
    end    
end
