require 'prawn/table'
class RequisitionInvoicePdf < PdfReport
    def initialize(requisition_item_obj,current_user)
       

        super(top_margin: 10)

        width = 110
        height = 100
        x =  200
        y = cursor - 30

        @requisition_item_objs = requisition_item_obj
        @requisition = Requisition.find(@requisition_item_objs.first.requisition_id)
        @region =  Location.find(@requisition.region_id).name
        @program =@requisition.operation.program.name
        @operation = @requisition.operation.name
        font Rails.root.join("app/assets/fonts/gfzemenu.ttf")
  i=0
        repeat :all, dynamic: true do
          
          
        if (page_number == 1)
            create_stamp("watermark" + i.to_s) do
                rotate(30, :origin => [-5, -5]) do
                stroke_color "FF3333"
                stroke_ellipse [20, 0], 50, 15
                stroke_color "000000"
                fill_color "993333"
                font("Times-Roman") do
                    draw_text  "procurment", :at => [-26, -1]
                end
                fill_color "000000"
            end
        end
 stamp_at "watermark" + i.to_s, [400, 500] 
    elsif (page_number == 2)
        create_stamp("watermark" + i.to_s) do
                rotate(30, :origin => [-5, -5]) do
                stroke_color "ADD8E6"
                stroke_ellipse [20, 0], 50, 15
                stroke_color "000000"
                fill_color "ADD8E6"
                font("Times-Roman") do
                    draw_text  "store", :at => [-26, -1]
                end
                fill_color "ADD8E6"
            end
        end
 stamp_at "watermark" + i.to_s, [400, 500] 
            
    elsif(page_number == 3)
        create_stamp("watermark" + i.to_s) do
                rotate(30, :origin => [-5, -5]) do
                stroke_color "c6e6ad"
                stroke_ellipse [20, 0], 50, 15
                stroke_color "000000"
                fill_color "c6e6ad"
                font("Times-Roman") do
                    draw_text  "Requesting Office", :at => [-26, -1]
                end
                fill_color "c6e6ad"
            end
        end
         stamp_at "watermark" + i.to_s, [400, 500] 
        else    
    end

       
        i = i + 1
       
        image "#{Rails.root}/public/assets/ndrmc.png", height: 30,:at=> [180,700],:size => 20
        stroke_rectangle [0,y], width, height
        text_box("ዋናው ዕቃ ግዥ ክፍል
                 white: procurment
                    ውሃ ሰማያዊ ለዕቃ ግመጃ ቤት
                    Light blue: store
                    አረንጓዴው ለጠያቂው ክፍል
                    Green: Requesting Office", :at => [1,y], :width => width, :height => height, :size => 10)

        text_box "በኢትዮጵያ ፌደራላዊ ዴሞክራሲያዊ ሪፐብሊክ\nበግብርናና ገጠር ልማት ሚኒስቴር\nየአደጋ መከላከልና ዝግጁነት እና ምግብ ዋስትና ዘርፍ", :at => [120,670], :width => 200, :height => height

        text_box "Federal Democratic Republic of Ethiopia
                    Ministry of Agriculture & Rural Development
                    Disaster Management and Food Security Sector", :at => [120,630], :width => 250, :height => height
        text_box "<u>የእርዳታ ሥርጭት መጠየቂያ</u>" ,:inline_format => true, :at => [120,580], :width => 200, :height => height
        text_box "<u>Relief Requisition for Distribution</u>" ,:inline_format => true, :at => [120,570], :width => 200, :height => height
        text_box "የሂሣብ ቁጥር: _____________\n Account No: ", :at => [350,630], :width => 200, :height => height
        text_box "ቀን:<u>  " + Time.now.strftime("%d/%m/%Y %H:%M") + "\n Date: ", :at => [350,610], :width => 200, :height => height,:inline_format => true
        text_box "LCT No:<u>" + @requisition.requisition_no + "</u>",:inline_format => true, :at => [350,570], :styles => [:underline]
        text_box "ጠያቂው ክፍል: <u> Disaster Response and Rebailitation</u>\nRequested by section:", :at => [10,550],:inline_format => true
        text_box "የተጠየቀለት ክልል<u>   " + @region + "      </u> \nAllocated for Region", :at => [10,525] ,:inline_format => true
        text_box "  " +  @program + "\nAllocated for:", :at => [10, 500]
        text_box "ዕርዳታው የተመደበበት ወር<u>   " +  @operation + "   </u>\nAllocation for the month of:", :at => [10,475],:inline_format => true
        move_down 300
        requisitions

        text "የጠያቂው ስም  " + current_user + "\nRequest by"
        text "ማዕረግ_________\nTitle"
        text_box "ፊርማ________\nSig.", :at => [120,380]
        text_box "ያረጋገጠው ስም________\nCertified by:" ,:at=> [190,380]
        text_box "ማዕረግ_________\nTitle", :at => [190,360]
        text_box "ፊርማ________\nSig.", :at => [300,380]
        text_box "ፈቀደው ስም______________\nApproved by Dep.head", :at =>[370,380]
        text_box "ማዕረግ_________\nTitle", :at => [370,360]
        text_box "ፊርማ_____\nSig.", :at => [490,380]
        text_box "<u>የተጠየቀው ዕርዳታ ከመጋዘን እንዲወጣ የተሰጠ ትዕዛዝ/Stock Release Authorization</u>" , :at => [100,330] , :size => 10, :inline_format => true
        move_down 30
        text "ለ____________________________________________________ማዕ/መጋዘን / መጋዘን\nTo:"
        text "ከተራ ቁጥር………………እስከ………………..የተጠየቀው ዕርዳታ ከእስቶክ…………ወይም……………ከተባለው ፕሮጀክት/በጎ አድራጊ ወጭ ተደርጎ ይሰጥ፤"
        text "Please Issue the goods requested/Item No._______To________From the stock_____________or____________Projct/Donor"

        text "\n"
        text_box "<u>ያረጋገጠው/Certified By/</u>", :at => [80, 230],:inline_format => true
        move_down 25
        text "ስም_________\nName"
        text "ማዕረግ_________\nTitle"
        text_box "ፊርማ________\nSig.", :at => [90,220]
        text_box "ቀን________\nDate", :at => [90,200]

        text_box "<u>የፈቀደው/Authorized by/</u>" , :at => [250, 230],:inline_format => true
        move_down 10
        text_box "ስም_________\nName", :at => [250,220]
        text_box "ማዕረግ_________\nTitle", :at => [250,200]
        text_box "ፊርማ________\nSig.", :at => [330,220]
        text_box "ቀን________\nDate", :at => [330,200]
        move_down 20
        text "መግለጫ፡- 1. በሠንጠረዥ ቁጥር 1 ፤ 2 ፤ 3 ፤ 4 ፤ 5 ፤ 6 ፤ 7.1 ፤ 7.2 እና 8 የተጠቀሰው በተጠያቂ ክፍል ይሞላል፡\nቀሪው በሎጅስቲክስ ይሞላል፡፡"
        move_down 20
       
       bounding_box [bounds.left, bounds.bottom + 72], width: bounds.width do
         stroke_horizontal_rule 
         move_down 5
         image "#{Rails.root}/public/assets/CATS_Blue.png", height: 20
         text "Commodity Allocation and Tracking System", size: 8, align: :center
         number_pages "Page <page> of <total>", 
                                       {:start_count_at => 1,
                                        :at => [bounds.right - 60, 0],
                                        :align => :right,
                                        :size => 8}
        
           end


      end


        2.times { start_new_page }
    end

    def requisitions
        table requisition_item do
        
        columns(1..3).align = :right
        self.row_colors = ["DDDDDD", "FFFFFF"]
        self.header = true
        end
    end

    def requisition_item
        num=0
        dynamic_data = []
        dynamic_data = ["ተ.ቁ.\nItem No","የዕርዳታው ዓይነት\nDescription","ዞን\nZone","ወረዳ\nWoreda", "ማራገፊያ ጣቢያ\nPlace of Des.","መለኪያ\nUnit","የተጠየቀ ብዛት\nAmount","የበጎ አድራጊ ወይም ፕሮጀከት ቁጥር\nProject Number"]
        @uom_id = @requisition.ration.ration_items.where(commodity_id: @requisition.commodity_id).first.unit_of_measure_id
        [dynamic_data] +
        @requisition_item_objs.map do |item|
            target_unit = UnitOfMeasure.find_by(name: "Quintal")
            current_unit = UnitOfMeasure.find(@uom_id)
            amount_in_qtl = target_unit.convert_to(current_unit.name, item.total_allocated)
            num = num + 1
            [num, item.commodity.name, Location.find(item.zone_id).name,"","","Quintal",amount_in_qtl,""]       
        end
    end 

       
end