class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  # GET /warehouses
  # GET /warehouses.json
  def index
    @warehouses = Warehouse.all
  end

  # GET /warehouses/1
  # GET /warehouses/1.json
  def show
  end

  # GET /warehouses/new
  def new
    @warehouse = Warehouse.new
    @warehouse.hub_id=params[:hub_id]
  end

  # GET /warehouses/1/edit
  def edit
  end

  # POST /warehouses
  # POST /warehouses.json
  def create
    @hub=params[:hub_id]
    @warehouse = Warehouse.new(warehouse_params)
    @warehouse.hub_id=params[:hub_id]
    respond_to do |format|
      if @warehouse.save
        format.html { redirect_to hub_path(@hub), notice: 'Store location was successfully created.' }
        format.json { render :show, status: :created, location: @warehouse }
      else
        format.html { render :new }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warehouses/1
  # PATCH/PUT /warehouses/1.json
  def update
    @hub=Hub.find(@warehouse.hub_id)
    respond_to do |format|
      if @warehouse.update(warehouse_params)
        format.html { redirect_to hub_path(@hub), notice: 'Store location was successfully updated.' }
        format.json { render :show, status: :ok, location: @warehouse }
      else
        format.html { render :edit }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouses/1
  # DELETE /warehouses/1.json
  def destroy
    @hub=Hub.find(@warehouse.hub_id)
    @warehouse.destroy
    respond_to do |format|
      format.html { redirect_to hub_path(@hub), notice: 'Store location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse
      @warehouse = Warehouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_params
      params.require(:warehouse).permit(:name, :description, :location_id, :organization_id, :lat, :lon)
    end
end
