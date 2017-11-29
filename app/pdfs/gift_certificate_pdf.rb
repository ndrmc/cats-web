require 'prawn/table'
class GiftCertificatePdf < PdfReport
    def initialize(gift,organization,commodity,currency,date_min,date_max)
        super top_margin: 50, :page_size => "A4", :page_layout => :landscape
       @gift = gift
       @organization = organization
       @commodity = commodity
       @currency = currency
        header "Gift certificate from " + date_min.to_s + " to " + date_max.to_s
        gift_certificate
        footer "Commodity Allocation and Tracking System"
    end


def gift_certificate
     bounding_box([bounds.left, bounds.top - 100 ], :width => bounds.width, :height => bounds.height - 150) do
    table gift do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
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
