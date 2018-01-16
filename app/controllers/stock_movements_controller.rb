class StockMovementsController < ApplicationController
  before_action :set_stock_movement, only: [:show, :edit, :update, :destroy, :createReceive]

  # GET /stock_movements
  # GET /stock_movements.json
  def index
    @stock_movements = StockMovement.all
  end

  # GET /stock_movements/1
  # GET /stock_movements/1.json
  def show
  end

  # GET /stock_movements/new
  def new
    @stock_movement = StockMovement.new
  end

  # GET /stock_movements/1/edit
  def edit
  end

  # POST /stock_movements
  # POST /stock_movements.json
  def create
    @stock_movement = StockMovement.new(stock_movement_params)

    respond_to do |format|
      if @stock_movement.save
        format.html { redirect_to stock_movements_path, notice: 'Stock movement was successfully created.' }
        format.json { render :show, status: :created, location: @stock_movement }
      else
        format.html { render :new }
        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stock_movements/1
  # PATCH/PUT /stock_movements/1.json
  def update
    respond_to do |format|
      if @stock_movement.update(stock_movement_params)
        format.html { redirect_to stock_movements_path, notice: 'Stock movement was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_movement }
      else
        format.html { render :edit }
        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_movements/1
  # DELETE /stock_movements/1.json
  def destroy
    @stock_movement.destroy
    respond_to do |format|
      format.html { redirect_to stock_movements_url, notice: 'Stock movement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
   
  def getCommodity
    commodity_id = Project.find(params[:id]).commodity_id
    commmodity = Commodity.find(commodity_id)
     respond_to do |format| 
         format.json{
         render :json => {
        :id => commmodity.id,
        :name => commmodity.name
      }
    }
  end
end

def createReceive
@receipt_lines = ReceiptLine.includes(:receipt).where(project_id: 1411, :'receipts.hub_id' =>  11)
@receipt_line = @receipt_lines.first


receipt = Receipt.new
receipt.grn_no = params[:grn]
receipt.received_date = params[:receive_date]
receipt.hub_id = @stock_movement.destination_hub_id
receipt.warehouse_id = @stock_movement.destination_warehouse_id
receipt.delivered_by = @receipt_line.receipt.delivered_by
receipt.supplier_id = @receipt_line.receipt.supplier_id
receipt.transporter_id = params[:transporter]
receipt.plate_no = params[:plate_no]
receipt.trailer_plate_no = params[:plate_no_trailer]
receipt.donor_id = 1 # @receipt_line.receipt.donor_id
receipt.weight_bridge_ticket_no = @receipt_line.receipt.weight_bridge_ticket_no
receipt.weight_before_unloading = @receipt_line.receipt.weight_before_unloading
receipt.weight_after_unloading = @receipt_line.receipt.weight_after_unloading
receipt.storekeeper_name = params[:store_kepeer]
receipt.waybill_no = @receipt_line.receipt.waybill_no
receipt.purchase_request_no =  @receipt_line.receipt.purchase_request_no
receipt.purchase_order_no = @receipt_line.receipt.purchase_order_no
receipt.invoice_no = @receipt_line.receipt.invoice_no
receipt.commodity_source_id = @receipt_line.receipt.commodity_source_id
receipt.program_id = @receipt_line.receipt.program_id
receipt.store_id = params[:store]
receipt.drivers_name= @receipt_line.receipt.drivers_name
receipt.created_at = Time.now
receipt.updated_at = Time.now
receipt.receiveid = 'N/A'
receipt.receipt_type = :transfer
receipt.receipt_type_id = @stock_movement.id                   
 
receipt_line = ReceiptLine.new
receipt_line.receipt = receipt
receipt_line.commodity_id = @stock_movement.commodity_id
receipt_line.project_id = @stock_movement.project_id
receipt_line.quantity = params[:quantity]
receipt_line.unit_of_measure_id = params[:unit]
receipt_line.receive_id = 'N/A'
receipt_line.receive_item_id = 'N/A'

   respond_to do |format|
      if (receipt_line.save!)
        format.html { redirect_to stock_movement_path(@stock_movement.id), notice: 'Stock movement was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_movement }
      else
           format.html { redirect_to stock_movement_path(@stock_movement.id), notice: 'Error saving Stock movement ' }
           format.json { render :show, status: :ok, location: @stock_movement }
      end
    end
    

end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_movement
      @stock_movement = StockMovement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_movement_params
      params.require(:stock_movement).permit(:movement_date, :source_hub_id, :source_warehouse_id, :source_store_id, :destination_hub_id, :destination_warehouse_id, :destination_store_id, :project_id, :commodity_id, :unit_of_measures_id, :quantity, :description)
    end
end
