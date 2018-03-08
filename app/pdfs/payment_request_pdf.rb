class PaymentRequestPdf  < PdfReport
        def initialize(payment_requested)
        super(top_margin: 50)
        @payment_requested = payment_requested
       
        header "# Program \t\t-\t\t Allocation for #{}"
        payment_request
        
        footer "Commodity Allocation and Tracking System"
    end

    def payment_request
        bounding_box([bounds.left, bounds.top - 75 ], :width => bounds.width, :height => bounds.height - 173) do
        table payment_request_items do
        row(0).font_style = :bold
        columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
        end
        move_down  10
        text "Total allocated: " 
        move_down 1
        text "Total dispatched: "
        move_down 1
        text "Total delivered: " 
        move_down 1
        text "Total Freight Charge: " 
        text "\n"
        text "\n"
        text "\n"
        text "Prepared by: ...................................................    Certified by: ..................................................."
        end
    end

    def payment_request_items
        dynamic_data = []
        dynamic_data = ["Item","Reference No","Req.No","G.R.N","Commodity", "Source","Destination","Received Qty","Tariff","Freight Chanrge"]
        [dynamic_data] +
       @payment_requested.map do |detail|
                     ["",detail&.payment_request&.reference_no, detail&.requisition_no,detail&.grn_no,detail&.commodity&.name,detail&.hub&.name, detail&.fdp&.name, detail&.received,detail&.tariff, detail&.freightCharge ]     
              

             
        end
    end   
end

