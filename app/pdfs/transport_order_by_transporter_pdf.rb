require 'prawn/table'
require 'to_words'
class TransportOrderByTransporterPdf < PdfReport
    def initialize(transport_order_items, transport_order)
        super(top_margin: 50)
        @transport_order_items = transport_order_items
        @transport_order = transport_order
        header "Warehouse Requisition - Transport Dispatch Order"
        move_down 2
         text "Bid Ref No:" +  Bid.find_by(id: @transport_order&.bid_id)&.bid_number.to_s
        text "LTCDRefNo:" 
         text "Region:" +   Location.find_by(id: @transport_order&.location_id)&.name.to_s
        move_down 2
        transport_orders
         footer "Commodity Allocation and Tracking System"
    end

    def transport_orders
         bounding_box([bounds.left, bounds.top - 120 ], :width => bounds.width, :height => bounds.height - 200) do
         transport_order_items
       
     end
   end
    

    def transport_order_items
       
        
        @i=0
        @sum_total=0
        @tariff_total = 0
        @total = 0
        @grand_total = 0
        @grand_total_tariff = 0
        if @transport_order_items.present?
                 t = [["No","Requisition_no","Warehouse","Zone","Woreda","FDP","Commodity","Qty"]]
                
                table(t, :column_widths => 60, :cell_style => {:border_width => 1}) 

                @transport_order_items.each_pair do |transporter, detail|
                @sum_total=0
                move_down 3
               
                text "<b><font size='10'>" +  transporter + "</b></font>", :inline_format => true   
                
                
                 
                detail.map do |to_detail|
                    @i = @i + 1
                    
                    
                            @requisition_id = Requisition.find_by(requisition_no: to_detail.requisition_no).id
                           
                            @hub_id = WarehouseAllocationItem.find_by(requisition_id: @requisition_id)&.hub_id
                           
                            @hub = Hub.find_by(id: @hub_id)&.name
                           
                            @qtl = UnitOfMeasure.find_by(name: 'Quintal')
                            unit_to_be_changed = UnitOfMeasure.find_by(id: to_detail.unit_of_measure_id).name
                            @qty_in_qtl =  @qtl.convert_to(unit_to_be_changed,   to_detail&.quantity)
                            @sum_total= @sum_total + @qty_in_qtl
                             @tariff_total = @tariff_total + to_detail.tariff
                            @total = @total + (@qty_in_qtl * to_detail.tariff)
                             t = [[@i,to_detail.requisition_no,@hub,Fdp.find(to_detail.fdp_id)&.location&.parent&.name,Fdp.find(to_detail.fdp_id)&.location&.name,Fdp.find(to_detail.fdp_id)&.name,Commodity.find_by(id: to_detail&.commodity_id)&.name,ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision(@qty_in_qtl))]]
                            
                            if @i.odd?
                            table(t, :column_widths => 60,:cell_style => {:border_width => 1},:row_colors => ["DDDDDD", "FFFFFF"]) 
                        else
                             table(t, :column_widths => 60,:cell_style => {:border_width => 1})
                            end
                            
                        end
                       move_down 4
                       text "Summary for  " + transporter + "     sub total quanity: " + ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision(@sum_total.to_s,precision: 2))
                       
                       @grand_total = @grand_total + @sum_total
                       @grand_total_tariff = @grand_total_tariff + @total
        
                end
                move_down 10
                 text_box "Quintals: " + ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision(@grand_total.to_s,precision: 2)) , :at => [390,cursor]
                 move_down 2
                        text_box "Grand total: " + ActionController::Base.helpers.number_with_delimiter(ActionController::Base.helpers.number_with_precision(@grand_total_tariff.to_s,precision: 2)) , :at => [375,cursor - 10]
                        move_down 5
            else
                text "---------------No data found----------------------"
        end    
    end

end