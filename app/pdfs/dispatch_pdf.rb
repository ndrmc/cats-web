require 'prawn/table'
class DispatchPdf < PdfReport
    def initialize(dispatch,date_min,date_max,hub)
        super(top_margin: 50)
       @dispatch = dispatch
       @hub = hub
        header "#{@hub} hub dispatches from " + date_min.to_s + " to " + date_max.to_s
        dispatches
        footer "Commodity Allocation and Tracking System"
    end


def dispatches
    bounding_box([bounds.left, bounds.top - 100 ], :width => bounds.width, :height => bounds.height - 150) do
    table dispatches_items do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
end

end

    def dispatches_items
        record_number = 1
        dynamic_data = []
        dynamic_data = ["Project C.","GIN","Region","Zone","Woreda","FDP","Commodity","Unit", "Quantity","Donor","Transporter"]
      
        [dynamic_data] +
            @dispatch.map do |r|
                [r.project_code,r.gin_no,r.region,r.zone,r.woreda,r.fdp_name,r.commodity,r.unit,r.quantity,r.donor,r.transporter_name]
            end 
        
        
    
    end
        
end
