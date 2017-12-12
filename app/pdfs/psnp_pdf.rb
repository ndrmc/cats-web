require 'prawn/table'
class PsnpPdf < PdfReport
    def initialize(psnp,psnp_by_region,location)
        super(top_margin: 50)
        @psnp = psnp
        @psnp_by_region = psnp_by_region
        @location = location
        header "PSNP annual plan for #{@psnp.year_ec} / #{@psnp.year_gc}"
        psnps
        footer "Commodity Allocation and Tracking System"
    end


def psnps
    table psnp_item do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
end



    def psnp_item
        dynamic_data = []
        dynamic_data = ["Region","Beneficiary Number"]
        @psnp.ration.ration_items.each do |item|
        dynamic_data << item.commodity.name + ' (QTL)'
        end
            [dynamic_data] +
            @psnp_by_region.map do |item_by_region|
            commmodities = []
            @psnp.ration.ration_items.each do |item|
                target_unit = UnitOfMeasure.find_by(name: "Quintal")
                current_unit = UnitOfMeasure.find(item.unit_of_measure_id)
                amount_in_qtl = target_unit.convert_to(current_unit.name, item.amount)
                commmodities << (amount_in_qtl * item_by_region.total_beneficiaries).round(2)
            end
        
             [@location.find(item_by_region.region_id).name,item_by_region.total_beneficiaries] + commmodities    
        
    end
    end
        
end
