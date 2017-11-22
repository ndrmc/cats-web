require 'prawn/table'
class RequisitionPdf < PdfReport
    def initialize(requisition_item_obj)
        super(top_margin: 50)
        @requisition_item_objs = requisition_item_obj
        @requisition = @requisition_item_objs.first.requisition
        header "#{@requisition.operation.program.name} Program \t\t-\t\t Allocation for #{@requisition.operation.name}"
        requisitions
        footer "Commodity Allocation and Tracking System"
    end

    def requisitions
        table requisition_item do
        row(0).font_style = :bold
        columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
        end
    end

    def requisition_item
        dynamic_data = []
        dynamic_data = ["Item","Req.No","Beneficiary No","Amount(QTL)","Region","Zone","Woreda","Destination"]
        @uom_id = @requisition.ration.ration_items.where(commodity_id: @requisition.commodity_id).first.unit_of_measure_id
        [dynamic_data] +
        @requisition_item_objs.map do |item|
            target_unit = UnitOfMeasure.find_by(name: "Quintal")
            current_unit = UnitOfMeasure.find(@uom_id)
            amount_in_qtl = target_unit.convert_to(current_unit.name, item.amount)
            [item.requisition.commodity.name,item.requisition.requisition_no, item.beneficiary_no, item.amount, item.fdp.location.parent.parent.name, item.fdp.location.parent.name, item.fdp.location.name, item.fdp.name]       
        end
    end    
end
