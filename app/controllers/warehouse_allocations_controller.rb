class WarehouseAllocationsController < ApplicationController
  before_action :set_warehouse_allocation, only: [:show, :edit, :update, :destroy]

  # GET /warehouse_allocations
  # GET /warehouse_allocations.json
  def index
    if(params['operation'].present?)
      @warehouse_allocations = WarehouseAllocation.get_regions(params['operation'])
    else
      @warehouse_allocations = []
    end
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
        format.html { redirect_to @warehouse_allocation, notice: 'Warehouse allocation was successfully created.' }
        format.json { render :show, status: :created, location: @warehouse_allocation }
      else
        format.html { render :new }
        format.json { render json: @warehouse_allocation.errors, status: :unprocessable_entity }
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
    zone_id = params[:zone]

    @requisition_items = RequisitionItem.joins(:requisition, :fdp)
    .where('requisitions.operation_id' => operation_id, 'requisitions.region_id' => region_id, 'requisitions.zone_id' => zone_id)
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
      params.require(:warehouse_allocation).permit(:operation_id, :region_id, :status, :created_by, :modified_by, :deleted_at)
    end
end
