class PaymentRequestPdf  < PdfReport
        def initialize(payment_requested, dispatched, received,freight_charge,transporter, current_user)
        super(top_margin: 50)
        @payment_requested = payment_requested
        @dispatched = dispatched
        @received = received
        @freight_charge = freight_charge
        @transporter = transporter
        @user =  current_user
        header "Payment Request for transporter: " + "#{@transporter}"
        
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
        text "Total dispatched: " + @dispatched.to_s
        move_down 1
        text "Total delivered: " + @received.to_s
        move_down 1
        text "Total Loss: " 
        move_down 1
        text "Total Freight Charge: " + @freight_charge.to_s
        text "\n"
        text "\n"
        text "\n"
        text "Prepared by: " + "#{@user}" 
        text "Certified by: ..................................................."
        end
    end
    
    def payment_request_items
        @count = 0
        dynamic_data = []
        dynamic_data = ["Item","Reference No","Req.No","G.R.N","Commodity", "Source","Destination","Received Qty","Tariff","Loss","Freight Chanrge"]
        [dynamic_data] +
       @payment_requested.map do |detail|
             @count =+1
                     [@count,detail&.payment_request&.reference_no, detail&.requisition_no,detail&.grn_no,detail&.commodity&.name,detail&.hub&.name, detail&.fdp&.name, detail&.received,detail&.tariff, "",detail&.freightCharge ]
        end
       
    end   
end

