class PaymentRequestLetterPdf  < PdfReport
    def initialize(payment_requested, dispatched, received,freight_charge,transporter, current_user, 
        loss_quantity, freight_charge_in_words, commodity_string, loss_charge_in_words, loss_charge)
        super(top_margin: 50)
        @payment_requested = payment_requested
        @dispatched = dispatched
        @received = received
        @freight_charge = freight_charge
        @transporter = transporter
        @user =  current_user
        @loss_quantity = loss_quantity
         @freight_charge_in_words =  freight_charge_in_words
         @commodity_string = commodity_string
         @loss_charge_in_words = loss_charge_in_words
         @loss_charge = loss_charge
        header ""
        font Rails.root.join("app/assets/fonts/gfzemenu.ttf")
        move_down 15
        text "ቀን ..................... ዓ.ም.", :size => 14, :align => :right
        text "<u>የውስጥ መፃፃፊያ</u>", :inline_format => true, :size => 22, :align => :center
        move_down 20
        text "ለ:- በጀት እና ፋይናንስ ዳይሬክቶሬት", :inline_format => true, :size => 14
        move_down 15
        text "ከ:- ሎጅስቲክስ ዳይሬክቶሬት ስለ ሎጅስቲክስ ዳይሬክቶሬት", :inline_format => true, :size => 14
        move_down 20
     
        text "<u>ጉዳዩ:- የማጓጓዣ ሂሳብ ክፍያ ይመለከታል</u>", :inline_format => true, :size => 18
               
        payment_request_letter        
        
        footer "Commodity Allocation and Tracking System"
    end

     def payment_request_letter
        bounding_box([bounds.left, bounds.top - 175 ], :width => bounds.width, :height => bounds.height - 173) do
        
        move_down 80
        text "#{@transporter} የኮሚሽኑን #{@received} ኩንታል የዕርዳታ እህል #{@commodity_string.to_s} ወደ ተለያዩ ዕደላ ጣቢያዎች ያጓጓዘበት ሂሳብ እንዲከፈለው  #{@payment_requested.count} ሰነድ(ኦችን) አቅርቧል:: ስለሆነም የቀረቡትን የማጓጓዣ ኪራይ መጠየቅያ ሰነዶችን በሠንጠረዥ መዝግበን የላክንላችሁ ሲሆን፤ ላጎደለው #{@loss_quantity} ኩንታል የዕርዳታ እህል #{@commodity_string.to_s} ብር #{@loss_charge}(#{@loss_charge_in_words}) ተቀንሶ የተጣራ ብር #{@freight_charge}(#{@freight_charge_in_words}) መሆኑን አረጋግጣችሁ በውሉ መሠረት ክፍያውን እንድትፈፅሙ #{@payment_requested.count} ሰነድ(ኦችን) በዚህ ሸኚ ማስታወሻ መላካችንን እንገልፃለን፡፡", :size => 13, :leading => 15
        move_down 20
        text "ከሰላምታ ጋር!", :size => 14, :align => :right
      
    end
end

end

