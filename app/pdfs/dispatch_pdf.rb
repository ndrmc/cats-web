require 'prawn/table'
class DispatchPdf < PdfReport
    def initialize(dispatch_lines,date_min,date_max,hub)
       super(top_margin: 50, :page_layout => :landscape)
       @dispatch_lines = dispatch_lines
       @hub = hub
       header "#{@hub} hub dispatches from " + date_min.to_s + " to " + date_max.to_s
       dispatches
       footer "Commodity Allocation and Tracking System"
    end


def dispatches
    bounding_box([bounds.left, bounds.top - 100 ], :width => bounds.width, :height => bounds.height - 160) do
    table dispatches_items do
      row(0).font_style = :bold
      columns(1..3).align = :right
      column(1..11).width = 60
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
            @dispatch_lines.map do |r|
                [r&.project&.project_code,r&.dispatch&.gin_no,r&.dispatch&.fdp&.location&.parent&.parent&.name,r&.dispatch&.fdp&.location&.parent&.name,r&.dispatch&.fdp&.location&.name,r&.dispatch&.fdp&.name,r&.commodity&.name,r&.unit_of_measure&.name,r&.quantity,r&.organization&.name,
                r&.dispatch&.transporter&.name ]
            end 
        
        
    
    end
        
end
