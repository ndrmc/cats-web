require 'prawn/table'
class ReceiptPdf < PdfReport
    def initialize(receipts,date_min,date_max,hub)
        super(top_margin: 50)
       @receipts = receipts
       @hub = hub
        header "#{@hub} hub receipt from " + date_min.to_s + " to " + date_max.to_s
        receipt
        footer "Commodity Allocation and Tracking System"
    end


def receipt
    bounding_box([bounds.left, bounds.top - 100 ], :width => bounds.width, :height => bounds.height - 150) do
    table receipt_items do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
end

end

    def receipt_items
        record_number = 1
        dynamic_data = []
        dynamic_data = ["Project C.","GRN","Commodity","Unit", "Quantity","Donor","Plate No","Waybill"]
      
        [dynamic_data] +
            @receipts.map do |r|
                [r.project_code,r.grn_no,r.commodity,r.unit,r.quantity,r.donor,r.plate_no, r.waybill_no]
            end 
        
        
    
    end
        
end
