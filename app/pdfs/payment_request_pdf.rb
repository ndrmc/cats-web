class PaymentRequestPdf  < PdfReport
        def initialize(payment_requested, dispatched, received,freight_charge,transporter, current_user, loss_quantity, loss_charge)
        super top_margin: 50, :page_size => "A4", :page_layout => :landscape
        @payment_requested = payment_requested
        @dispatched = dispatched
        @received = received
        @freight_charge = freight_charge
        @transporter = transporter
        @user =  current_user
        @loss_quantity = loss_quantity
        @loss_charge = loss_charge
        header "Payment Request for transporter: " + "#{@transporter}"
        
        payment_request
                
        footer "Commodity Allocation and Tracking System"
    end

    def payment_request
        bounding_box([bounds.left, bounds.top - 75 ], :width => bounds.width, :height => bounds.height - 173) do
        table payment_request_items do
        row(0).font_style = :bold
        columns(1..3).align = :right
        # self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
        end
        move_down  10
        # text "Total allocated: " 
        move_down 1
        text "Total dispatched: " + @dispatched.to_s + " QTL"
        move_down 1
        text "Total delivered: " + @received.to_s + " QTL"
        move_down 1
        text "Total Loss: " + @loss_quantity.to_s + " QTL"
        move_down 1
        text "Total Loss Charge: " + @loss_charge.to_s + " ETB"
        move_down 1
        text "Total Freight Charge: " + @freight_charge.to_s + " ETB"
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
        dynamic_data = ["Item no","Req.No","Reference No","Issue No.","G.R.N No.","LTCD","Commodity", "Source","Destination","Received Qty","Tariff","Shortage Qtl.", "Shortage Birr","Freight Charge"]
        [dynamic_data] +
       @payment_requested.map do |detail|
            @count += 1
            [@count, detail[:requisition_no], detail[:reference_no], detail[:gin_no], detail[:grn_no], detail[:ltcd], detail[:commodity], detail[:source], detail[:destination], detail[:received_qty], detail[:tariff], detail[:shortage_qty], detail[:shortage_birr],detail[:freight_charge] ]
        end
       
    end   
end

