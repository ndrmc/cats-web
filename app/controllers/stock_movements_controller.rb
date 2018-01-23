class StockMovementsController < ApplicationController

  before_action :set_stock_movement, only: [:show, :edit, :update, :destroy, :createReceive]


  # GET /stock_movements
  # GET /stock_movements.json
  def index
    @stock_movements = StockMovement.includes(:unit_of_measure,:source_hub,:destination_hub,:source_warehouse,:destination_warehouse,:project,:commodity).all
  end

  # GET /stock_movements/1
  # GET /stock_movements/1.json
  def show
    @commodity_category = Commodity.includes(:commodity_category).find(@stock_movement.commodity_id)
    @unit_of_measures = UnitOfMeasure.where(uom_category_id: @commodity_category.uom_category_id)
    @transporters = Transporter.order(:name)
    @dispatch_items = DispatchItem.includes(:unit_of_measure, dispatch: :transporter).where(:'dispatches.dispatch_type' => 1)

    @receipts = ReceiptLine.includes(:receipt).where('receipts.receipt_type' => :transfer)
    @uom_category_id = Commodity.find(@stock_movement.commodity_id).uom_category_id
  end

  # GET /stock_movements/new
  def new
    @stock_movement = StockMovement.new
    @projects = Project.where('archived = ? OR archived IS NULL',false)
    @commodities = Commodity.all
    @commodity_categories = CommodityCategory.all
    @uoms = UnitOfMeasure.all
    @hubs = Hub.order(:name)
    @warehouses = Warehouse.order(:name)
    @stores = Store.order(:name)
    @organizations = Organization.order(:name)
    @unit_of_measures = UnitOfMeasure.order(:name)
  end

  # GET /stock_movements/1/edit
  def edit
    @projects = Project.where('archived = ? OR archived IS NULL',false)
    @commodities = Commodity.all
    @commodity_categories = CommodityCategory.all
    @uoms = UnitOfMeasure.all
    @hubs = Hub.order(:name)
    @warehouses = Warehouse.order(:name)
    @stores = Store.order(:name)
    @organizations = Organization.order(:name)
    @unit_of_measures = UnitOfMeasure.order(:name)
    @donor_id = @stock_movement&.project&.organization&.id 
  end

  # POST /stock_movements
  # POST /stock_movements.json
  def create
    @stock_movement = StockMovement.new(stock_movement_params)
    @stock_movement.status = :open
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

  def check_stock    
    @hub_id = stock_movement_params["hub_id"]
    @warehouse_id = stock_movement_params["warehouse_id"]
    @project_id = stock_movement_params["proj_id"]
    stock_account = Account.find_by({'code': :stock})
    @stock = PostingItem.where(account_id: stock_account.id, hub_id: @hub_id, warehouse_id: @warehouse_id, project_id: @project_id).sum(:quantity)
    
    respond_to do |format|
        format.html
        format.json { render :json => @stock.to_json }
    end
  end

  def close
    @stock_movement.status = :closed
    respond_to do |format|
      if @stock_movement.save
        format.html { redirect_to stock_movements_url, notice: 'Stock movement was successfully closed.' }
        format.json { render :show, status: :ok, location: @stock_movement }
      else
        format.html { render :edit }
        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  def stock_movement_dispatch
    @existing_ws = Dispatch.where(:gin_no => stock_movement_params["gin"]).count
    if @existing_ws == 0 
      @stock_movement = StockMovement.includes(:unit_of_measure,:source_hub,:destination_hub,:source_warehouse,:destination_warehouse,:project,commodity: :commodity_category).find(stock_movement_params["stock_movement_id"])

      @dispatch = Dispatch.new
      @dispatch.gin_no = stock_movement_params["gin"]
      @dispatch.dispatch_date = stock_movement_params["dispatch_date"]
      @dispatch.transporter_id = stock_movement_params["transporter"]
      @dispatch.drivers_name = stock_movement_params["driver_name"]
      @dispatch.plate_number = stock_movement_params["plate_no"]
      @dispatch.trailer_plate_number = stock_movement_params["plate_no_trailer"]
      @dispatch.hub_id = @stock_movement.source_hub_id
      @dispatch.warehouse_id = @stock_movement.source_warehouse_id
      @dispatch.storekeeper_name = stock_movement_params["store_keeper"]
      @dispatch.dispatch_type_id = stock_movement_params["stock_movement_id"]
      @dispatch.dispatch_type = 1      

      @dispatch_item =  DispatchItem.new
      @dispatch_item.dispatch_id = @dispatch.id
      @dispatch_item.commodity_category_id = @stock_movement.commodity.commodity_category_id
      @dispatch_item.commodity_id = @stock_movement.commodity_id
      @dispatch_item.quantity = stock_movement_params["amount"]
      @dispatch_item.unit_of_measure_id = stock_movement_params["unit_of_measure"]
      @dispatch_item.project_id = @stock_movement.project_id
      @dispatch_item.organization_id = @stock_movement.project.organization_id

      @dispatch.dispatch_items << @dispatch_item
    end
    
    respond_to do |format|                        
      if @dispatch.save && @existing_ws == 0 
        format.html { redirect_to @dispatch, notice: 'Dispatch was successfully created.' }
        format.json { render :show, status: :created, location: @dispatch }
      else
        format.html { render :new }
        format.json { render json: @dispatch.errors, status: :unprocessable_entity }
      end
    end
  end

  def stock_movement_dispatch_edit    
    @stock_movement = StockMovement.includes(:unit_of_measure,:source_hub,:destination_hub,:source_warehouse,:destination_warehouse,:project,commodity: :commodity_category).find(stock_movement_params["stock_movement_id"])

    @dispatch = Dispatch.find(stock_movement_params["dispatch_id"])
    @dispatch_hash = Hash.new
    @dispatch_hash["id"] = @dispatch.id
    @dispatch_hash["gin_no"] = stock_movement_params["gin"]
    @dispatch_hash["dispatch_date"] = stock_movement_params["dispatch_date"]
    @dispatch_hash["transporter_id"] = stock_movement_params["transporter"]
    @dispatch_hash["drivers_name"] = stock_movement_params["driver_name"]
    @dispatch_hash["plate_number"] = stock_movement_params["plate_no"]
    @dispatch_hash["trailer_plate_number"] = stock_movement_params["plate_no_trailer"]
    @dispatch_hash["hub_id"] = @stock_movement.source_hub_id
    @dispatch_hash["warehouse_id"] = @stock_movement.source_warehouse_id
    @dispatch_hash["storekeeper_name"] = stock_movement_params["store_keeper"]
    @dispatch_hash["dispatch_type_id"] = stock_movement_params["stock_movement_id"]

    @dispatch_item =  DispatchItem.where(dispatch_id: stock_movement_params["dispatch_id"]).first
    @dispatch_item.commodity_category_id = @stock_movement.commodity.commodity_category_id
    @dispatch_item.commodity_id = @stock_movement.commodity_id
    @dispatch_item.quantity = stock_movement_params["amount"]
    @dispatch_item.unit_of_measure_id = stock_movement_params["unit_of_measure"]
    @dispatch_item.project_id = @stock_movement.project_id
    @dispatch_item.organization_id = @stock_movement.project.organization_id
    @dispatch_item.save
    @dispatch_items_array = []
    @dispatch_items_array << @dispatch_item
    @dispatch_hash["dispatch_items"] = @dispatch_items_array
    
    respond_to do |format|                        
      if @dispatch.update(@dispatch_hash)
        format.html { redirect_to @dispatch, notice: 'Dispatch was successfully updated.' }
        format.json { render :show, status: :created, location: @dispatch }
      else
        format.html { render :new }
        format.json { render json: @dispatch.errors, status: :unprocessable_entity }
      end
    end
  end
  def get_dispatch
    @dispatch_item = DispatchItem.includes(:unit_of_measure, dispatch: :transporter).where(dispatch_id: stock_movement_params["dispatch_id"]).first
    @data = []
    @data << @dispatch_item.dispatch.gin_no.to_s
    @data << @dispatch_item.dispatch.dispatch_date.to_s
    @data << @dispatch_item.quantity.to_s
    @data << @dispatch_item.dispatch.drivers_name    
    @data << @dispatch_item.dispatch.plate_number.to_s
    @data << @dispatch_item.dispatch.trailer_plate_number.to_s
    @data << @dispatch_item.dispatch.storekeeper_name    
    @data << @dispatch_item.unit_of_measure.name
    @data << @dispatch_item.unit_of_measure.id.to_s
    @data << @dispatch_item.dispatch.transporter.name
    @data << @dispatch_item.dispatch.transporter.id.to_s    

    render json: @data
  end

  def delete_dispatch
    @dispatch = Dispatch.find(params["id"])
    @dispatch.destroy
    respond_to do |format|
      format.html { redirect_to "/en/stock_movements/" + params["stock_movement_id"], notice: 'Dispatch was successfully destroyed.' }
      format.json { head :no_content }
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
@receipt_lines = ReceiptLine.includes(:receipt).where(project_id: @stock_movement&.project_id, 
                                      :'receipts.hub_id' =>  @stock_movement&.source_hub_id, 
                                      :'receipts.warehouse_id' =>  @stock_movement&.source_warehouse)
if (!@receipt_lines.empty?)
              @receipt_line = @receipt_lines.first
              @commodity_category_id = Commodity.find(@stock_movement.commodity_id).commodity_category_id

              receipt = Receipt.new(:grn_no => params[:grn])
              receipt.received_date = params[:receive_date]
              receipt.hub_id = @stock_movement&.destination_hub_id
              receipt.warehouse_id = @stock_movement&.destination_warehouse_id
              receipt.delivered_by = @receipt_line&.receipt&.delivered_by
              receipt.supplier_id = @receipt_line&.receipt&.supplier_id
              receipt.transporter_id = params[:transporter]
              receipt.plate_no = params[:plate_no]
              receipt.trailer_plate_no = params[:plate_no_trailer]
              if (@receipt_line&.receipt&.donor_id.nil?) 
                  receipt.donor_id = 1 #default donor_id
              else
                  receipt.donor_id = @receipt_line&.receipt&.donor_id
              end
              receipt.weight_bridge_ticket_no = @receipt_line&.receipt&.weight_bridge_ticket_no
              receipt.weight_before_unloading = @receipt_line&.receipt&.weight_before_unloading
              receipt.weight_after_unloading = @receipt_line&.receipt&.weight_after_unloading
              receipt.storekeeper_name = params[:store_keeper]
              receipt.waybill_no = @receipt_line&.receipt&.waybill_no
              receipt.purchase_request_no =  @receipt_line&.receipt&.purchase_request_no
              receipt.purchase_order_no = @receipt_line&.receipt&.purchase_order_no
              receipt.invoice_no = @receipt_line&.receipt&.invoice_no
              receipt.commodity_source_id = @receipt_line&.receipt&.commodity_source_id
              receipt.program_id = @receipt_line&.receipt&.program_id
              receipt.store_id = params[:store]
              receipt.drivers_name= @receipt_line&.receipt&.drivers_name
              receipt.created_at = Time.now
              receipt.updated_at = Time.now
              receipt.receiveid = 'N/A'
              receipt.receipt_type = :transfer
              receipt.receipt_type_id = @stock_movement&.id                   


              receipt.receipt_lines.build(:commodity_category_id => @commodity_category_id,
                                          :commodity_id => @stock_movement.commodity_id,
                                          :project_id =>  @stock_movement.project_id,
                                          :quantity => params[:quantity],
                                          :unit_of_measure_id => params[:unit],
                                          :created_by => current_user.id,
                                          :receive_id => 'N/A',
                                          :receive_item_id => 'N/A')
                respond_to do |format|
                    if (receipt.save!)
                      format.html { redirect_to stock_movement_path(@stock_movement.id), notice: 'Stock movement was successfully updated.' }
                      format.json { render :show, status: :ok, location: @stock_movement }
                    else
                        format.html { redirect_to stock_movement_path(@stock_movement.id)}
                        flash[:error] = "Received not saved. Check the data and try again"
                        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
                    end
                  end
    else
                respond_to do |format|
                    
                        format.html { redirect_to stock_movement_path(@stock_movement.id)}
                        flash[:error] = "Received not saved. Check the stock and try again"
                        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
                   
                  end
    end
    

end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_movement
      @stock_movement = StockMovement.includes(:unit_of_measure,:source_hub,:destination_hub,:source_warehouse,:destination_warehouse,:project,:commodity).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_movement_params
      params.require(:stock_movement).permit(:movement_date, :source_hub_id, :source_warehouse_id, :source_store_id, :destination_hub_id, :destination_warehouse_id, :destination_store_id, :project_id, :commodity_id, :unit_of_measure_id, :quantity, :description, :hub_id, :warehouse_id, :proj_id, :stock_movement_id, :gin, :dispatch_date, :amount, :unit_of_measure, :transporter, :driver_name, :plate_no, :plate_no_trailer, :store_keeper, :dispatch_id)
    end
end
