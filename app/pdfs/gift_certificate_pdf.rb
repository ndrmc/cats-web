require 'prawn/table'
class GiftCertificatePdf < PdfReport
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
        header "Gift certificate from " + date_min.to_s + " to " + date_max.to_s
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
           text "Total Estimated Price in USD:" +  ActiveSupport::NumberHelper.number_to_currency(@toal_estimated_price_in_usd.to_s, precision: 2)
           text "Total Estimated price in Birr:" +  ActiveSupport::NumberHelper.number_to_currency(@toal_estimated_price_in_birr.to_s, precision: 2,:unit=> 'ETB ')
           text "Total Estimated Tax: " +  ActiveSupport::NumberHelper.number_to_currency(@total_estimated_tax.to_s, precision: 2,:unit=> 'ETB ')
        
end

end

    def gift
        record_number = 1
        dynamic_data = []
        dynamic_data = ["Donor","Gift Date","Commodity","Weight in MT","Price", "Curr.","Est. Tax(ETB)","Bill of Loading","Vessele","Declaration No."]
      
        [dynamic_data] +
            @gift.map do |r|
                [@organization.find(r.organization_id).name,
                r.gift_date.strftime("%d-%b-%Y"), @commodity.find(r.commodity_id).name, 
                r.amount,ActiveSupport::NumberHelper.number_to_currency(r.estimated_price, precision: 2) , @currency.find(r.currency_id).symbol ,ActiveSupport::NumberHelper.number_to_currency(r.estimated_tax, precision: 2,:unit=> 'ETB '),r.bill_of_loading,r.vessel, r.customs_declaration_no]
            end 
        
        
    
    end
        
end
