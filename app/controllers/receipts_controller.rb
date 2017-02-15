class ReceiptsController < ApplicationController

    def index 
        @receipts = Receipt.all 
    end


    def new 
        @receipt = Receipt.new
    end


    def create 
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

    def edit 
        @receipt = Receipt.find(params[:id])
    end

    def update

        @receipt = Receipt.find(params[:id])

        receipt_line_ids = @receipt.receipt_lines.collect { |rl| rl.id }

        recept_lines_hash = receipt_params[:receipt_lines][0...-1]

        deleted_receipt_line_ids = receipt_line_ids -  recept_lines_hash.collect { |r| r[:id].to_i }

        ReceiptLine.where( :id => deleted_receipt_line_ids).destroy_all 

        receipt_lines = recept_lines_hash.collect do |h| 
                            if h[:id] != nil
                                ReceiptLine.find(h[:id])
                            else             
                                ReceiptLine.new( h)
                            end
                         end

        receipt_map = receipt_params.except(:receipt_lines)

        receipt_map[:receipt_lines] = receipt_lines

        if @receipt.update( receipt_map )
            respond_to do |format|
                format.html { redirect_to receipts_path, notice: 'Receipt was successfully updated.' }
            end
        else
            respond_to do |format|
                format.html { render :edit }
            end
        end
    end


    private 

        def receipt_params
            params.require(:receipt).permit( :grn_no, :store_id, :received_date, :storekeeper_name, :waybill_no, :hub_id, :warehouse_id,
                :weight_bridge_ticket_no, :transporter_id, :weight_before_unloading, :plate_no, :trailer_plate_no, :drivers_name, :remark,
                :receipt_lines => [:id, :commodity_category_id, :commodity_id, :unit_of_measure_id,  :quantity, :project_id]
            )
           
        end
end
