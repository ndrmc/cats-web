require 'prawn/table'
class RegionalRequestPdf < PdfReport
    def initialize(request_item_obj)
        super(top_margin: 50)
        @request_item_objs = request_item_obj
        @request = @request_item_objs.first.request
        header "#{@request.operation.program.name} Program \t\t-\t\t Allocation for #{@request.operation.name}"
        regional_requests
        text "\n \n \n Prepared by: ...................................................    Certified by: ..................................................."
        footer "Commodity Allocation and Tracking System"
    end

    def regional_requests
        table regional_request_item do
        row(0).font_style = :bold
        columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
        end
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