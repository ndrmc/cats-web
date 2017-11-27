require 'prawn/table'
class HRDPdf < PdfReport
    def initialize(hrd,hrd_by_region,location)
        super(top_margin: 50)
        @hrd = hrd
        @hrd_by_region = hrd_by_region
        @location = location
        header "HRD for #{@hrd.season.name} - #{@hrd.year_gc}"
        hrds
        footer "Commodity Allocation and Tracking System"
    end


def hrds
    table hrd_item do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
end



    def hrd_item
        dynamic_data = []
        dynamic_data = ["Region","Beneficiary Number"]
        @hrd.ration.ration_items.each do |item|
        dynamic_data << item.commodity.name
        end
            [dynamic_data] +
            @hrd_by_region.map do |item_by_region|
            commmodities = []
            @hrd.ration.ration_items.each do |item|
                commmodities << item.amount * item_by_region.total_beneficiaries
            end
        
             [@location.find(item_by_region.region_id).name,item_by_region.total_beneficiaries] + commmodities    
        
    end
    end
        
end
