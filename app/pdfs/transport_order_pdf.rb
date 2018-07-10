require 'prawn/table'
require 'to_words'
class TransportOrderPdf < PdfReport
    def initialize(transport_order, transport_order_items, zones, region, requisitions, references, contract_no)
        super(top_margin: 50)
        @transport_order = transport_order
        @transport_order_items = transport_order_items
        @zones = zones
        @region = region
        @requisitions = requisitions
        @references = references
        @contract_no = contract_no
        donor = []
        @A4_SIZE = 100.freeze
        @operation = Operation.find_by(id: @transport_order.operation_id)&.name
         @transport_order_items.map do |item|
            requisition_id = Requisition.find_by(requisition_no: item.requisition_no)&.id
             project_id = ProjectCodeAllocation.where(requisition_id: requisition_id).limit(1).pluck(:project_id)
             if project_id.present? 
                organization_id =  Project.find(project_id[0].to_i).organization_id
                org = Organization.find(organization_id).name
                if !donor.include? org
                     donor << org 
                end
             end
        end
         header "Transport Order"
         move_down 10
        bounding_box([bounds.left, bounds.top -  100 ], :width => bounds.width, :height => bounds.height - 210) do
       
        text "<b>Order No.</b> <u> #{@transport_order.order_no}</u>", :align => :center, :inline_format => true
        text "\n\n<b>I. <u>TRANSACTION DETAILS</u></b>", :inline_format => true
        text "Contract Number: #{@contract_no}" , :align => :right
        text "Transpot Order Date: #{@transport_order&.order_date}", :align => :right
       
        t = [
             
                 ["Transporter:","#{@transport_order&.transporter&.name}"],
                 ["Region:", "#{@region}" , " " * 2, "Requisition Dispatch Date:","__________________"],
                 ["Zone:","#{@zones.to_s}", "  " * 2 ,"Transport Expiry Date:","#{@transport_order&.end_date    }"],
                 ["Bid Document No:","#{@transport_order&.bid&.bid_number}"],
                 ["Donor:", "#{donor.to_s}", "  " * 2 ,"Performance Bond Receipt #","#{@transport_order&.performance_bond_receipt}"],
                 ["RequisitionNo:","#{@requisitions.to_s}", "  " * 2 ,"Transport Expiry Date:","__________________"],
                 ["Operation:","#{ @operation }"],
                 ["Reference:","#{ @references.to_s}"]
        ]
        table(t, :column_widths => (@A4_SIZE), :cell_style => {:border_width => 0})   
         

        text "\n<b>II. <u>COMMODITY DETAILS</u></b>", :inline_format => true
        transport_orders
         
            text "\n\n\n<b>III. <u>APPROVING CERTIFICATE</u></b>", :inline_format => true
            text "\n<b>For Consigner                                                                           For Transporting Agency</b>", :inline_format => true
            text "Name: __________________________                                    Name: ________________________", :inline_format => true
            text "Signature: _____________________                                        Signature: ___________________", :inline_format => true
            text "Date: __________________________                                      Date: ________________________", :inline_format => true
    end

        footer "Commodity Allocation and Tracking System\nCopy Distribution\nOriginal:- Consignee; 1st Copy:- Carrier; 2nd Copy:- Finance Services; 3rd Copy:- Legal Services; 4th Copy:- Retained as Copy"
        
    end

    def transport_orders
        
        table transport_order_items do
        row(0).font_style = :bold
        column(0).width = 40
        column(3).width = 90
        column(4).width = 60
        column(7).width = 60
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
    
end

   end 

    def transport_order_items
        dynamic_data = []
        dynamic_data = ["No","Woreda","Destination","Origin warehouse","Commodity", "Quantity Qtl", "Tariff / Qtl", "Total Amount in Birr"]
        @count = 0
       
        @amount_total = 0
        @birr_total = 0
       result = [dynamic_data] +
        @transport_order_items.map do |item|
            requisition_id = Requisition.find_by(requisition_no: item.requisition_no)&.id
             project_id = ProjectCodeAllocation.where(requisition_id: requisition_id).limit(1).pluck(:project_id)
              warehouse_id = WarehouseAllocationItem.where(requisition_id: requisition_id,fdp_id: item.fdp_id).limit(1).pluck(:warehouse_id)
              if warehouse_id.present?
                     @warehouse = Warehouse.find_by(id: warehouse_id[0].to_i)&.name
                end
            @count += 1
            target_unit = UnitOfMeasure.find_by(name: "Quintal")
            current_unit = UnitOfMeasure.find(item.unit_of_measure_id)
            amount_in_qtl = target_unit.convert_to(current_unit.name, item.quantity)
            @amount_total = @amount_total + (amount_in_qtl)
            @birr_total = @birr_total + (amount_in_qtl*item.tariff)
            [@count, item.fdp.location.name,item.fdp.name,  @warehouse ,item.commodity.name, ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision(amount_in_qtl.round(2))), item.tariff, ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision((amount_in_qtl*item.tariff).round(2)))]       
        end
        result = result + [["Total", "-", "-",  "-", "", ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision(@amount_total.round(2))), "-",ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision(@birr_total.round(2)))]]
        result = result + [[{:content => "Amount in words: " + @birr_total.humanize, :colspan => 8}]]
    end    
end