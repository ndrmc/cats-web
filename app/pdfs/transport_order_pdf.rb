require 'prawn/table'
class TransportOrderPdf < PdfReport
    def initialize(transport_order, transport_order_items, zones, commodities, requisitions)
        super(top_margin: 50)
        @transport_order = transport_order
        @transport_order_items = transport_order_items
        @zones = zones
        @commodities = commodities
        @requisitions = requisitions
        header "Transport Order"
        text "<b>Order No.</b> <u> #{@transport_order.order_no}</u>", :align => :center, :inline_format => true
        text "\n\n<b>I. <u>TRANSACTION DETAILS</u></b>", :inline_format => true
        text "Contract Number: #{@transport_order&.contract&.contract_no}" , :align => :right
        text "Transpot Order Date: #{@transport_order&.order_date}", :align => :right
        
        t = [
             
                 ["Transporter:","#{@transport_order&.transporter&.name}"],
                 ["Region:","Sample Region Name","   " * 2, "Requisition Dispatch Date:","#{@transport_order&.start_date}"],
                 ["Zone:","#{@zones.to_s}", "  " * 2 ,"Transport Expiry Date:","#{@transport_order&.end_date    }"],
                 ["Commodity:","#{@commodities.to_s}", "  " * 3 ,"Bid Document No:","#{@transport_order&.bid&.bid_number}"],
                 ["Donor:","", "  " * 2 ,"Performance Bond Receipt #",""],
                 ["RequisitionNo:","#{@requisitions.to_s}", "  " * 2 ,"Transport Expiry Date:","#{@transport_order&.end_date}"]
        ]
        table(t, :cell_style => {:border_width => 0})   
         

        text "\n\n\n<b>II. <u>COMMODITY DETAILS</u></b>", :inline_format => true
        transport_orders
        text "\n\n\n<b>III. <u>APPROVING CERTIFICATE</u></b>", :inline_format => true
        text "\n<b>For Consigner                                                                           For Transporting Agency</b>", :inline_format => true
        text "Name: __________________________                                    Name: ________________________", :inline_format => true
        text "Signature: _____________________                                        Signature: ___________________", :inline_format => true
        text "Date: __________________________                                      Date: ________________________", :inline_format => true
        footer "Commodity Allocation and Tracking System\nCopy Distribution\nOriginal:- Consignee; 1st Copy:- Carrier; 2nd Copy:- Finance Services; 3rd Copy:- Legal Services; 4th Copy:- Retained as Copy"
        
    end

    def transport_orders
         bounding_box([bounds.left, bounds.top - 320 ], :width => bounds.width, :height => bounds.height - 200) do
        table transport_order_items do
        row(0).font_style = :bold
        columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
    end
    
    end
    end

    def transport_order_items
        dynamic_data = []
        dynamic_data = ["No","Woreda","Destination","Origin warehouse","Commodity", "Quantity Qtl", "Tariff / Qtl", "Total Amount in Birr"]
        @count = 0
        [dynamic_data] +
        @transport_order_items.map do |item|
            @count += 1
            target_unit = UnitOfMeasure.find_by(name: "Quintal")
            current_unit = UnitOfMeasure.find(item.unit_of_measure_id)
            amount_in_qtl = target_unit.convert_to(current_unit.name, item.quantity)
            [@count, item.fdp.location.name,item.fdp.name,  Warehouse.find_by(id: item&.warehouse_id)&.name ,item.commodity.name, amount_in_qtl.round(2), item.tariff, (amount_in_qtl*item.tariff).round(2)]       
        end
    end    
end