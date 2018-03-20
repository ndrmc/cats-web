class PaymentRequestLetterPdf  < PdfReport
    def initialize(payment_requested, dispatched, received,freight_charge,transporter, current_user, 
        loss_quantity, freight_charge_in_words)
        super(top_margin: 50)
        @payment_requested = payment_requested
        @dispatched = dispatched
        @received = received
        @freight_charge = freight_charge
        @transporter = transporter
        @user =  current_user
        @loss_quantity = loss_quantity
         @freight_charge_in_words =  freight_charge_in_words
        header ""
        font Rails.root.join("app/assets/fonts/gfzemenu.ttf")
        move_down 15
        text "ለ ፋይናንስ ዕቃና አገልግሎት ግዥ ኬዝ ቲም"
        text "ከ አደጋ ምላሽ የሎጅስቲክ አስተዳደር ኬዝ ቲም"
        
        move_down 20
     
        text "ጉዳዩ:- የማጓጓዣ ሂሳብ ክፍያ ይመለከታል"
        move_down 5
       
        payment_request_letter
        
        footer "Commodity Allocation and Tracking System"
    end

     def payment_request_letter
        bounding_box([bounds.left, bounds.top - 175 ], :width => bounds.width, :height => bounds.height - 173) do
       
        
        text "#{@transporter} የዘርፉን #{@received} ኩንታል የዕርዳታ እህል ወደ ተለያዩ ዕደላ ጣቢያዎች ያጓጓዘበት ሂሳብ እንዲከፈለው  #{@payment_requested.count} ሠነዶችን አቅርቧል::"
        text     "ስለሆነም ሠነዶቹን አጣርተን ባዘጋጀነው የሂሳብ ማሳያ ሠንጠረዥ መሠረት ላጎደለው #{@loss_quantity} ኩንታል የዕርዳታ እህል ብር ________ ()"
        text     "ተቀንሶ የተጣራ ብር #{@freight_charge}(#{@freight_charge_in_words}) እንዲከፈለው እያሳሰብን የበኩላችሁን አጣርታችሁ ክፍያውን እንድትፈፅሙ #{@payment_requested.count} ሠነዶችን በዚህ ሽኚ ማስታወሻ የላክን መሆኑን እንገልጻለን::" 
       
        text "\n"
        text "\n"
        text "\n"
      
        text "\n"
        text_box "<u>ያረጋገጠው/Certified By/</u>", :at => [10, 230],:inline_format => true
        move_down 25
        text_box "ስም_________\nName", :at => [10,220]
        text_box "ማዕረግ_________\nTitle", :at => [10,200]
        text_box "ፊርማ________\nSig.", :at => [90,220]
        text_box "ቀን________\nDate", :at => [90,200]

        text_box "<u>የፈቀደው/Authorized by/</u>" , :at => [250, 230],:inline_format => true
        move_down 10
        text_box "ስም_________\nName", :at => [250,220]
        text_box "ማዕረግ_________\nTitle", :at => [250,200]
        text_box "ፊርማ________\nSig.", :at => [330,220]
        text_box "ቀን________\nDate", :at => [330,200]
        move_down 20
      
    end
end

end

