class StockMovementsController < ApplicationController
  protect_from_forgery prepend:true
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
    @dispatch_items = DispatchItem.includes(:unit_of_measure, dispatch: :transporter).where(:'dispatches.dispatch_type' => :transfer, :'dispatches.dispatch_type_id' => @stock_movement.id)
    stock_account = Account.find_by({'code': :stock})
    dispatched_account = Account.find_by({'code': :dispatched})
    stock_movement_journal = Journal.find_by({'code': :internal_movement})

    @receipts = ReceiptLine.includes(:receipt).where('receipts.receipt_type' => :transfer, :'receipts.receipt_type_id' => @stock_movement.id)
    @uom_category_id = Commodity.find(@stock_movement.commodity_id).uom_category_id
    @dispached_stock, @dispatch_stock_progress = get_dispatched_amount_for_project_code(@stock_movement)
    @received_stock, @received_stock_progress = get_received_amount_for_project_code(@stock_movement)
    @received_progress_against_in_transit = (@dispached_stock.to_i == 0) ? 0 : (@received_stock/@dispached_stock) * 100
    @total_dispatched_quantity = get_total_dispatched_amount_for_project_code(@stock_movement.project_id, @stock_movement.source_hub_id)
    @dispached_stock = @dispached_stock -  @received_stock
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

      stock_account = Account.find_by({'code': :stock})
      @available_stock = PostingItem.where(account_id: stock_account.id, hub_id: @stock_movement.source_hub_id, warehouse_id: @stock_movement.source_warehouse_id, project_id: @stock_movement.project_id).sum(:quantity)
      @amount_in_ref = UnitOfMeasure.find(stock_movement_params["unit_of_measure"].to_i).to_ref(stock_movement_params["amount"].to_f)

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
      @dispatch.dispatch_type = :transfer

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
    
    if @existing_ws > 0
      @data = []
      @data << 'exists'        
      render json: @data
    elsif @available_stock < @amount_in_ref
      @data = []
      @data << 'notenough'     
      @data << 'Not enough stock available. Only ' + @available_stock.to_s + 'MT is avalable.'      
      render json: @data
    elsif @dispatch.save
      @data = []
      @data << 'success'     
      @data << 'Dispatch was successfully created.'      
      render json: @data
    else
      @data = []
      @data << 'failed'        
      render json: @data
    end
  end

  def stock_movement_dispatch_edit    
    @stock_movement = StockMovement.includes(:unit_of_measure,:source_hub,:destination_hub,:source_warehouse,:destination_warehouse,:project,commodity: :commodity_category).find(stock_movement_params["stock_movement_id"])
    
    stock_account = Account.find_by({'code': :stock})
    @available_stock = PostingItem.where(account_id: stock_account.id, hub_id: @stock_movement.source_hub_id, warehouse_id: @stock_movement.source_warehouse_id, project_id: @stock_movement.project_id).sum(:quantity)
    @amount_in_ref = UnitOfMeasure.find(stock_movement_params["unit_of_measure"]).to_ref(stock_movement_params["amount"])

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
    @old_amount_in_ref = UnitOfMeasure.find(@dispatch_item.unit_of_measure_id).to_ref(@dispatch_item.quantity)
    @available_stock = @available_stock + @old_amount_in_ref
    @dispatch_item.quantity = stock_movement_params["amount"]
    @dispatch_item.unit_of_measure_id = stock_movement_params["unit_of_measure"]
    @dispatch_item.project_id = @stock_movement.project_id
    @dispatch_item.organization_id = @stock_movement.project.organization_id
    @dispatch_item.save
    @dispatch_items_array = []
    @dispatch_items_array << @dispatch_item
    @dispatch_hash["dispatch_items"] = @dispatch_items_array
    
    if @available_stock < @amount_in_ref
      @data = []
      @data << 'notenough'     
      @data << 'Not enough stock available. Only ' + @available_stock.to_s + 'MT is avalable.'      
      render json: @data
    elsif @dispatch.save
      @data = []
      @data << 'success'     
      @data << 'Dispatch was successfully updated.'      
      render json: @data
    else
      @data = []
      @data << 'failed'        
      render json: @data
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

if (params[:edit_mode]=='true')#update

       @goods_dispatched = get_dispatched_amount_for_project_code(@stock_movement)
       @goods_received = get_received_amount_for_project_code(@stock_movement)
       @goods_in_transit = @goods_dispatched[0].to_f - @goods_received[0].to_f
       
         if (@goods_in_transit >= params[:quantity].to_f)

                receipt = Receipt.find(params[:receipt_id])
                receipt_line = receipt.receipt_lines.first
                
                receipt.grn_no = params[:grn_no]
                receipt.received_date = params[:received_date]
                receipt.transporter_id = params[:transporter_id]
                receipt.plate_no = params[:plate_no]
                receipt.trailer_plate_no = params[:trailer_plate_no]
                receipt.storekeeper_name = params[:store_keeper]
                receipt.store_id = params[:store]

              
                receipt_line.quantity = params[:quantity]
                receipt_line.unit_of_measure_id = params[:unit]
    


                respond_to do |format|
                                  if receipt.update_attributes!(receipt_lines_attributes: [receipt_line.attributes])
                                            format.html { redirect_to stock_movement_path(@stock_movement.id), notice: 'Stock movement was successfully updated.' }
                                            format.json { render :show, status: :ok, location: @stock_movement }
                                  else
                                            format.html { redirect_to stock_movement_path(@stock_movement.id)}
                                            flash[:error] = "Received not updated. Check the data and try again"
                                            format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
                                  end
                          end
          else
               respond_to do |format|
                    
                        format.html { redirect_to stock_movement_path(@stock_movement.id)}
                        flash[:error] = "Received not saved. Received amount is more than dispatched amount"
                        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
                   
                  end
          end
          
else#add new receipt
          
          @goods_dispatched = get_dispatched_amount_for_project_code(@stock_movement)
          @goods_received = get_received_amount_for_project_code(@stock_movement)
          @goods_in_transit = @goods_dispatched[0].to_f - @goods_received[0].to_f
          if (@goods_in_transit >= params[:quantity].to_f)
              @organization_id = Project.find(@stock_movement.project_id)&.organization_id
              @commodity_category_id = Commodity.find(@stock_movement.commodity_id).commodity_category_id

              receipt = Receipt.new(:grn_no => params[:grn_no])
              receipt.received_date = params[:received_date]
              receipt.hub_id = @stock_movement&.destination_hub_id
              receipt.warehouse_id = @stock_movement&.destination_warehouse_id
             
              receipt.transporter_id = params[:transporter_id]
              receipt.plate_no = params[:plate_no]
              receipt.trailer_plate_no = params[:trailer_plate_no]
              receipt.donor_id = @organization_id
              receipt.storekeeper_name = params[:store_keeper]
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
                    if (receipt.save)
                      format.html { redirect_to stock_movement_path(@stock_movement.id), notice: 'Stock movement was successfully created.' }
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
                        flash[:error] = "Received not saved. Received amount is more than dispatched amount"
                        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
                   
                  end
    end

end  

    

end

def stock_movement_edit
  @receipts = ReceiptLine.includes(:receipt).where('receipt_id' => params[:id]).first
      respond_to do |format| 
         format.html
         format.json{
         render :json => {
        :receipt_id =>  @receipts&.receipt.id,
        :grn_no => @receipts&.receipt&.grn_no,
        :receipt_date => @receipts&.receipt&.received_date&.strftime('%d/%m/%Y'),
        :plate_no => @receipts&.receipt&.plate_no,
        :trailer_plate_no => @receipts&.receipt&.trailer_plate_no,
        :transporter_id => @receipts&.receipt&.transporter_id,
        :store => @receipts&.receipt&.store_id,
        :unit => @receipts&.unit_of_measure_id,
        :quantity => @receipts&.quantity,
        :store_keeper => @receipts&.receipt&.storekeeper_name
      }
    }
    end
 
  
end

def stock_movement_destroy_receive
   @receipt = Receipt.find params[:id]
        respond_to do |format|
            if  @receipt.destroy
                format.html { redirect_to request.referrer, notice: 'Receipt item was successfully deleted.' }
            else
                format.html { 
                    flash[:error] = "Delete failed! Please try again shortly."
                    redirect_to request.referrer 
                }
            end
        end
end
def get_total_dispatched_amount_for_project_code(project_id, source_hub_id)
    dispatched_account = Account.find_by({'code': :dispatched})
    stock_movement_journal = Journal.find_by({'code': :internal_movement})

    @dispatched_stock = PostingItem.where(journal_id: stock_movement_journal.id, account_id: dispatched_account.id, hub_id: source_hub_id, project_id: project_id).where('quantity > 0').sum(:quantity)
    return @dispatched_stock
end

def get_dispatched_amount_for_project_code(stock_movement)

              @dispatched_stock = 0
              DispatchItem.includes(:dispatch).where(:'dispatches.dispatch_type_id' => stock_movement.id).each do |dispatch_item|
              dispatched_to_ref = UnitOfMeasure.find(dispatch_item.unit_of_measure_id.to_i).to_ref(dispatch_item.quantity.to_f)
              @dispatched_stock = @dispatched_stock + dispatched_to_ref
              end
      total_to_be_dispatched_in_ref = UnitOfMeasure.find(stock_movement.unit_of_measure_id.to_i).to_ref(stock_movement.quantity.to_f)

    @stock_momvement_dispatch_progress = (@dispatched_stock / total_to_be_dispatched_in_ref) * 100
    return @dispatched_stock, @stock_momvement_dispatch_progress
end

def get_received_amount_for_project_code(stock_movement)
      
              @received_stock = 0
              ReceiptLine.includes(:receipt).where(:'receipts.receipt_type_id' => stock_movement.id).each do |receipt_item|
              received_to_ref = UnitOfMeasure.find(receipt_item.unit_of_measure_id.to_i).to_ref(receipt_item.quantity.to_f)
              @received_stock = @received_stock + received_to_ref
             end

    total_to_be_received_in_ref = UnitOfMeasure.find(stock_movement.unit_of_measure_id.to_i).to_ref(stock_movement.quantity.to_f)
    @stock_movement_reveived_progress = (@received_stock/total_to_be_received_in_ref) * 100
    return @received_stock, @stock_movement_reveived_progress
end

def validate_quantity    
         
        @stock_movement = StockMovement.find(stock_movement_params['stock_movement_id'])
        @source_hub_id = stock_movement_params["source_hub_id"]
        @destination_hub_id = stock_movement_params["destination_hub_id"]
        @project_id = stock_movement_params["proj_id"]
        @quantity = stock_movement_params["quantity"]
        @unit = stock_movement_params["unit_of_measure_id"]
        @total_qty =  stock_movement_params["total_qty"]
        
        @stock_dispatched = get_total_dispatched_amount_for_project_code( @project_id, @source_hub_id)
        @received_amount  =  get_received_amount_for_project_code(@stock_movement)

        quantity_in_ref = UnitOfMeasure.find(@unit.to_i).to_ref(@quantity.to_f)
        @flag = false
      
        balance = @stock_dispatched - @received_amount[0]
        if(quantity_in_ref <= balance)
            @flag = true
        end
        respond_to do |format|
            format.html
            format.json { render :json => @flag.to_json }
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
