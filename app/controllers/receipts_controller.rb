class ReceiptsController < ApplicationController

    def index 
        @receipts = Receipt.all 
    end


    def new 
        @receipt = Receipt.new
    end


    def create 
        byebug
        recept_lines_hash = receipt_params[:receipt_lines][0...-1]
        receipt_lines = recept_lines_hash.collect { |h| ReceiptLine.new( h)}

        receipt_map = receipt_params.except(:receipt_lines)

        receipt_map[:receipt_lines] = receipt_lines

        @receipt = Receipt.new( receipt_map )

        respond_to do |format|
            if @receipt.save
                format.html { redirect_to receipts_path, success: 'Receipt was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end


    private 

        def receipt_params
            params.require(:receipt).permit(:id, :grn_no, :store_id, :received_date, :storekeeper_name, :waybill_no, 
                :weight_bridge_ticket_no, :transporter_id, :weight_before_unloading, :plate_no, :trailer_plate_no, :drivers_name, :remark,
                :receipt_lines => [:commodity_category_id, :commodity_id, :quantity, :project_id]
            )
           
        end
end
