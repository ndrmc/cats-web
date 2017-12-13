class WarehouseAllocationsController < ApplicationController
  before_action :set_warehouse_allocation, only: [:show, :edit, :update, :destroy]

  # GET /warehouse_allocations
  # GET /warehouse_allocations.json
  def index
    @warehouse_allocations 
    @warehouse_allocations = WarehouseAllocation.all
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
