class PdfReport < Prawn::Document
  
  
  TABLE_ROW_COLORS = ["FFFFFF","DDDDDD"]
  TABLE_FONT_SIZE = 9
  TABLE_BORDER_STYLE = :grid

  def initialize(default_prawn_options={:bottom_margin => [100]})
    super(default_prawn_options)
    font_size 10
  end

  def header(title=nil)
    image "#{Rails.root}/public/assets/ndrmc.png", height: 30
    text "National Disaster Risk Management Comission", size: 15, style: :bold, align: :center
    stroke_horizontal_rule 
    if title
    move_down 10
      text title, size: 14, style: :bold_italic, align: :center
    end
    move_down 20
  end
  
  def footer(title=nil)
    repeat :all do
    
      bounding_box [bounds.left, bounds.bottom + 35], width: bounds.width do
         stroke_horizontal_rule 
         move_down 5
         image "#{Rails.root}/public/assets/CATS_Blue.png", height: 20
         text title, size: 8, align: :center
         number_pages "Page <page> of <total>", 
                                       {:start_count_at => 1,
                                        :at => [bounds.right - 60, 0],
                                        :align => :right,
                                        :size => 8}
      end
    end

    

  end

end

