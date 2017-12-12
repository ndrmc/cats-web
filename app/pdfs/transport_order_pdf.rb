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
        text "<b>Transport Order No.</b> <u>#{@transport_order.order_no}</u>", :inline_format => true
        text "\n\n<b>I. <u>TRANSACTION DETAILS</u></b>", :inline_format => true
        text "\n<b>Transporter:</b> #{@transport_order&.transporter&.name}", :inline_format => true
        text "\n<b>Contract Number:</b> #{@transport_order&.contract&.contract_no}", :inline_format => true
        text "\n<b>Transport Order Date:</b> #{@transport_order&.order_date}", :inline_format => true
        text "\n<b>Zone:</b> #{@zones.to_s}", :inline_format => true
        text "\n<b>Commodities:</b> #{@commodities.to_s}", :inline_format => true
        text "\n<b>Requisitions:</b> #{@requisitions.to_s}", :inline_format => true
        text "\n<b>Transport Order Start Date:</b> #{@transport_order&.start_date}", :inline_format => true
        text "\n<b>Transport Order End Date:</b> #{@transport_order&.end_date}", :inline_format => true
        text "\n<b>Bid Document No:</b> #{@transport_order&.bid&.bid_number}", :inline_format => true
        text "\n<b>Performance Bond Receipt No:</b> ______________________________", :inline_format => true
        text "\n\n\n<b>II. <u>COMMODITY DETAILS</u></b>", :inline_format => true
        transport_orders
        text "\n\n\n<b>III. <u>APPROVING CERTIFICATE</u></b>", :inline_format => true
        text "\n<b>For Consigner                                                                           For Transporting Agency</b>", :inline_format => true
        text "Name: __________________________                                    Name: ________________________", :inline_format => true
        text "Signature: _____________________                                        Signature: ___________________", :inline_format => true
        text "Date: __________________________                                      Date: ________________________", :inline_format => true
        text "\n\n\n<font size='8'>Copy Distribution:</font>", :inline_format => true
        text "\n<font size='8'>Original:- Consignee; 1st Copy:- Carrier; 2nd Copy:- Finance Services; 3rd Copy:- Legal Services; 4th Copy:- Retained as Copy</font>", :inline_format => true
        footer "Commodity Allocation and Tracking System"
    end

    def transport_orders
        table transport_order_items do
        row(0).font_style = :bold
        columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
        end
    end

    def transport_order_items
        dynamic_data = []
        dynamic_data = ["No","Woreda","Destination","Commodity", "Quantity Qtl", "Tariff / Qtl", "Total Amount in Birr"]
        @count = 0
        [dynamic_data] +
        @transport_order_items.map do |item|
            @count += 1
            target_unit = UnitOfMeasure.find_by(name: "Quintal")
            current_unit = UnitOfMeasure.find(item.unit_of_measure_id)
            amount_in_qtl = target_unit.convert_to(current_unit.name, item.quantity)
            [@count, item.fdp.location.name,item.fdp.name, item.commodity.name, amount_in_qtl.round(2), item.tariff, (amount_in_qtl*item.tariff).round(2)]       
        end
    end    
end