require 'prawn/table'
class GiftCertificateFinancePdf < PdfReport
    def initialize(gift,organization,commodity,currency,date_min,date_max,toal_weight_in_MT,toal_estimated_price_in_usd,toal_estimated_price_in_birr,total_estimated_tax)
        super top_margin: 50, :page_size => "A4", :page_layout => :landscape
       @gift = gift
       @organization = organization
       @commodity = commodity
       @currency = currency
       @total_weight_in_MT = toal_weight_in_MT
       @toal_estimated_price_in_usd = toal_estimated_price_in_usd
       @toal_estimated_price_in_birr=toal_estimated_price_in_birr
       @total_estimated_tax =  total_estimated_tax
        header "Period  " + date_min.strftime("%b-%d-%Y") + " to " + date_max.strftime("%b-%d-%Y")
        gift_certificate
        footer "Commodity Allocation and Tracking System"
    end


def gift_certificate
     bounding_box([bounds.left, bounds.top - 100 ], :width => bounds.width, :height => bounds.height - 180) do
    table gift do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
     move_down 10
           text "Total Weight in MT: " + ActiveSupport::NumberHelper.number_to_currency(@total_weight_in_MT.to_s,precision: 2, :unit=> '')
          
           text "Total Estimated price in Birr:" +  ActiveSupport::NumberHelper.number_to_currency(@toal_estimated_price_in_birr.to_s, precision: 2,:unit=> 'ETB ')
         
        
end

end

    def gift
        record_number = 1
        dynamic_data = []
        
        dynamic_data = ["Donor","Commodity Parent","Commodity","Gift Date","Weight In MT", "Price","Currency","Est. Tax(ETB)"]
      
        [dynamic_data] +
            @gift.map do |r|
                [@organization.find(r.organization_id).name, 
                CommodityCategory.find(@commodity.find(r.commodity_id).commodity_category_id).name,
                @commodity.find(r.commodity_id).name,
                r.gift_date.strftime("%b-%d-%Y"), 
                r.amount,
                ActiveSupport::NumberHelper.number_to_currency(r.estimated_price, precision: 2, :unit=> '') , @currency.find(r.currency_id).symbol ,ActiveSupport::NumberHelper.number_to_currency(r.estimated_tax, precision: 2,:unit=> 'ETB ')]
            end 
        
        
    
    end
        
end
