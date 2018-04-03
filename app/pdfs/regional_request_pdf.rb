require 'prawn/table'
class RegionalRequestPdf < PdfReport
    def initialize(request_item_obj, request,  total_beneficiary_no)
        super(top_margin: 50)
        @request_item_objs = request_item_obj
        @request = request
        @total_beneficiary_no = total_beneficiary_no
        header "#{@request&.location&.name} Region \t\t-\t\t Request for #{@request&.operation&.name}"
         bounding_box([bounds.left, bounds.top - 120], :width  => bounds.width, :height => bounds.height - 200) do
        regional_requests
        end
        text "\n\n\n\n\n\n\n Prepared by: ...................................................    Certified by: ..................................................."
        footer "Commodity Allocation and Tracking System"
    end

    def regional_requests
        table regional_request_item do
        row(0).font_style = :bold
        columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
    end
     move_down  10
       text "Total Beneficiaries: " + ActiveSupport::NumberHelper.number_to_currency(@total_beneficiary_no.to_s.to_s,precision: 2, :unit=> '')
       
    end

    def regional_request_item
        dynamic_data = []
        dynamic_data = ["Zone","Woreda","FDP","Beneficiaries"]
        [dynamic_data] +
        @request_item_objs.map do |item|
            [item.fdp.location.parent.name,item.fdp.location.name, item.fdp.name, item.number_of_beneficiaries]       
        end
       
    end    
end