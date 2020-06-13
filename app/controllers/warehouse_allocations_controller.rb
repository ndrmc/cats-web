class WarehouseAllocationsController < ApplicationController
  before_action :set_warehouse_allocation, only: [:edit, :update, :destroy]
  before_action :authorize_warehouse_allocation
  # GET /warehouse_allocations
  # GET /warehouse_allocations.json
  def authorize_warehouse_allocation
    authorize WarehouseAllocation
  end


  def index
    if(params['operation'].present?)
      @warehouse_allocations = WarehouseAllocation.get_regions(params['operation'])
      
    else
      @warehouse_allocations = []
    end
   
  end
  def is_tr_created_for_this_warehouse_allocatoin
   
       @result = WarehouseAllocation.check_warehouse_allocation_in_TR(warehouse_allocation_params[:operation_id],warehouse_allocation_params[:region_id])
       render json: @result
  end
  def generate
    respond_to do |format|
      if WarehouseAllocation.generate(params[:operation], params[:region])
        format.html { redirect_to '/warehouse_allocations?operation=' + params['operation'].to_s, notice: 'Warehouse allocation was successfully created.' }
        format.json { render :show, status: :created, location: @warehouse_allocation }
      else
        format.html { render :new }
        format.json { render json: @warehouse_allocation.errors, status: :unprocessable_entity }
      end
    end
  end
  def reverse_allocation
       if( params[:warehouse_allocation_id].present? )
            @old_warehouse_allocation = WarehouseAllocation.find(params[:warehouse_allocation_id])
             respond_to do |format|
                if WarehouseAllocation.reverse_allocation(@old_warehouse_allocation.id)
                    format.html { redirect_to request.referrer,  notice: 'Warehouse allocation was successfully reversed.' }
                else
                  format.html { redirect_to request.referrer,  alert: 'Warehouse allocation was successfully not reversed.' }
                end
            end
       else
         respond_to do |format|
               format.html { redirect_to request.referrer,  alert: 'Warehouse allocation was successfully not reversed.' }
          end
       end

  end
  
  def reset_allocation
    if( params[:warehouse_allocation_id].present? )
      @old_warehouse_allocation = WarehouseAllocation.find(params[:warehouse_allocation_id])
    end
    respond_to do |format|
      if( @old_warehouse_allocation.present? )
        @operation_id = @old_warehouse_allocation.operation_id
        @region_id = @old_warehouse_allocation.region_id

        if WarehouseAllocation.reset_allocation(@old_warehouse_allocation.id)
          @warehouse_allocation = WarehouseAllocation.where(:operation_id => @operation_id, :region => @region_id).first
          format.html { redirect_to '/warehouse_allocations?operation=' + @warehouse_allocation.operation_id.to_s, notice: 'Warehouse allocation was successfully resetted.' }
          format.json { render :show, status: :created, location: @warehouse_allocation }
        else
          format.html { render :new }
          format.json { render json: @warehouse_allocation.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @warehouse_allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  def close_allocation
    if( params[:warehouse_allocation_id].present? )
      @warehouse_allocation = WarehouseAllocation.find(params[:warehouse_allocation_id])
    end
    respond_to do |format|
      @warehouse_allocation.status = :closed
      if @warehouse_allocation.save
        format.html { redirect_to '/warehouse_allocations?operation=' + @warehouse_allocation.operation_id.to_s, notice: 'Warehouse allocation was successfully resetted.' }
        format.json { render :show, status: :created, location: @warehouse_allocation }
      else
        format.html { render :new }
        format.json { render json: @warehouse_allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /warehouse_allocations/1
  # GET /warehouse_allocations/1.json
  def show
    region_id = params[:id]
    operation_id = params[:operation]

    @requisition_items = RequisitionItem.joins(requisition: :commodity, fdp: :location)
    .where('requisitions.operation_id' => operation_id, 'requisitions.region_id' => region_id)
    .where("beneficiary_no > 0")
    @warehouse_allocations = []
    @requisition_items.each do |requisition_detail|
      @requisition = Requisition.includes(ration: :ration_items).find(requisition_detail.requisition_id)
      @uom_id = @requisition.ration.ration_items.where(commodity_id: @requisition.commodity_id).first.unit_of_measure_id
      target_unit = UnitOfMeasure.find_by(name: "Quintal")
      current_unit = UnitOfMeasure.find(@uom_id)
      quantity_in_ref = target_unit.convert_to(current_unit.name, requisition_detail.amount.to_f)

        @wai = WarehouseAllocationItem.includes(:fdp, :requisition, :warehouse, :hub).where(:fdp_id => requisition_detail.fdp_id, :requisition_id => requisition_detail.requisition.id).first 
        
        @warehouse_allocations << { region: requisition_detail.fdp.location.parent.parent.name, warehouse: @wai.warehouse.name, zone: requisition_detail.fdp.location.parent.name, woreda: requisition_detail.fdp.location.name, fdp: requisition_detail.fdp.name, requisition_no: requisition_detail.requisition.requisition_no, commodity: requisition_detail.requisition.commodity.name, allocated: quantity_in_ref }
      end 
  end

  # GET /warehouse_allocations/new
  def new
    @warehouse_allocation = WarehouseAllocation.new
  end

  # GET /warehouse_allocations/1/edit
  def edit
  end

  # POST /warehouse_allocations
  # POST /warehouse_allocations.json
  def create
    @warehouse_allocation = WarehouseAllocation.new(warehouse_allocation_params)
    
    respond_to do |format|
      if @warehouse_allocation.save
        format.html { redirect_to @warehouse_allocation, notice: 'Warehouse allocation was successfully closed.' }
        format.json { render :show, status: :created, location: @warehouse_allocation }
      else
        format.html { render :new }
        format.json { render json: @warehouse_allocation.errors, status: :unprocessable_entity }
      end
    end
  end


  def change_wai   
    @operation_id = warehouse_allocation_params["operation_id"]
    @requisition_id = warehouse_allocation_params["requi_id"]
    @fdp_id = warehouse_allocation_params["fdp_id"]
    @set_as_default = warehouse_allocation_params["set_as_default"]
    @fdp = Fdp.includes(location: [warehouse: :hub]).find(@fdp_id)    
    @wai_id = warehouse_allocation_params["wai_id"]
    @result = false
    if (@wai_id.present?)
      @existing_wai = WarehouseAllocationItem.includes(:warehouse_allocation, fdp: :location).find(@wai_id)
    end
    if (@existing_wai.present?)
      @existing_wai.hub_id = warehouse_allocation_params["hub_id"]
      @existing_wai.warehouse_id = warehouse_allocation_params["warehouse_id"]
      @existing_wai.status = :edited
      @result = @existing_wai.save
    else
      @requisition = Requisition.find(@requisition_id)      
      @region_id = @fdp&.location&.parent&.parent&.id
      @warehouse_allocation = WarehouseAllocation.where(operation_id: @operation_id, region_id: @region_id).first
      @warehouse_allocation_item = WarehouseAllocationItem.new
      print "************ ID: " + @warehouse_allocation.id.to_s
      @warehouse_allocation_item.warehouse_allocation_id = @warehouse_allocation.id      
      @warehouse_allocation_item.zone_id = @fdp&.location&.parent&.id
      @warehouse_allocation_item.woreda_id = @fdp&.location&.id
      @warehouse_allocation_item.fdp_id = @fdp.id
      @warehouse_allocation_item.hub_id = @fdp&.location&.warehouse&.hub&.id
      @warehouse_allocation_item.warehouse_id = @fdp&.location&.warehouse&.id
      @warehouse_allocation_item.requisition_id = @requisition.id
      @warehouse_allocation_item.status = :draft
      @result = @warehouse_allocation_item.save
    end

    @flag = true
    if(warehouse_allocation_params["set_as_default"])
      @flag = false
      location = @fdp.location
      location.warehouse_id = warehouse_allocation_params["warehouse_id"]
      location.save
      @flag = true
    end
    respond_to do |format|
      if (@result && @flag)
        format.json { head :no_content }
      else
        format.json { render json: @existing_wai.warehouse_allocation.errors, status: :unprocessable_entity }
      end
    end
  end


  def change_wa_woreda
    @hub_id = warehouse_allocation_params["hub_id"]
    @warehouse_id = warehouse_allocation_params["warehouse_id"]
    @set_as_default = warehouse_allocation_params["set_as_default"]
    @operation_id = warehouse_allocation_params["operation_id"]
    @woreda_id = warehouse_allocation_params["woreda_id"]
    @requisition_id = warehouse_allocation_params["requi_id"]

    @warehouse_allocation_items = WarehouseAllocationItem.includes(:warehouse_allocation, fdp: :location).where(:'warehouse_allocations.operation_id' => @operation_id, :woreda_id => @woreda_id, :requisition_id => @requisition_id)

    @warehouse_allocation_items.each do |warehouse_allocation_item|
      warehouse_allocation_item.hub_id = @hub_id
      warehouse_allocation_item.warehouse_id = @warehouse_id
      warehouse_allocation_item.status = :edited
      @flag = true
      if(@set_as_default)
        @flag = false
        location = warehouse_allocation_item.fdp.location
        location.warehouse_id = @warehouse_id
        location.save
        @flag = true
      end
      warehouse_allocation_item.save
    end
    respond_to do |format|
      if (@flag)
        format.json { head :no_content }
      else
        format.json { render json: @existing_wai.warehouse_allocation.errors, status: :unprocessable_entity }
      end
    end
  end



  # PATCH/PUT /warehouse_allocations/1
  # PATCH/PUT /warehouse_allocations/1.json
  def update
    respond_to do |format|
      if @warehouse_allocation.update(warehouse_allocation_params)
        format.html { redirect_to @warehouse_allocation, notice: 'Warehouse allocation was successfully updated.' }
        format.json { render :show, status: :ok, location: @warehouse_allocation }
      else
        format.html { render :edit }
        format.json { render json: @warehouse_allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouse_allocations/1
  # DELETE /warehouse_allocations/1.json
  def destroy
    @warehouse_allocation.destroy
    respond_to do |format|
      format.html { redirect_to warehouse_allocations_url, notice: 'Warehouse allocation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def warehouse_allocation_fdp_view
    operation_id = params[:operation]
    region_id = params[:region]
    requisition_id = params[:requisition_id]
    requisition = Requisition.includes(:region, :zone, :commodity).find(params[:requisition_id])
    @operation_name = Operation.find(params[:operation]).name
    @region_name = requisition.region.name
    @zone_name = requisition.zone.name
    @commodity_name = requisition.commodity.name
    requisition_list = Requisition.includes(:region, :zone, :commodity).where(operation_id: params[:operation], zone_id: requisition.zone_id)

    @requi_comm_list = []
    requisition_list.each do |requisition|
      requi_comm = requisition.requisition_no + " - " + requisition.commodity.name
      @requi_comm_list << { :id => requisition.id, :name => requi_comm}
    end
    @formatted_array_of_hashes = @requi_comm_list.each.map{ |h| { h[:name] => h[:id] }}
    @merged_hash = Hash[*@formatted_array_of_hashes.map(&:to_a).flatten]

    @requisition_items = RequisitionItem.joins(:requisition, :fdp)
    .where('requisitions.operation_id' => operation_id, 'requisitions.region_id' => region_id, 'requisition_id' => requisition_id)
    .where("beneficiary_no > 0")
    @requisition_items = @requisition_items.group_by {|item| item.fdp.location_id}
  end

  def warehouse_allocation_zonal_view
    operation_id = params[:operation]
    region_id = params[:region]   

    @requisition_items = RequisitionItem.joins(:requisition).select("sum(beneficiary_no) as beneficiary_no, sum(requisition_items.amount) as amount, requisition_id,requisitions.requisition_no")
    .group("requisition_id,requisitions.requisition_no")
    .where('requisitions.operation_id' => operation_id, 'requisitions.region_id' => region_id)
    .where("beneficiary_no > 0")
    @requisition_items = @requisition_items.group_by {|item| item.requisition.zone_id}
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse_allocation
      @warehouse_allocation = WarehouseAllocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_allocation_params
      params.require(:warehouse_allocation).permit(:wai_id, :fdp_id, :hub_id, :requi_id, :warehouse_id, :woreda_id, :requisition_id, :set_as_default, :operation_id, :region_id, :status, :created_by, :modified_by, :deleted_at)
    end
end
