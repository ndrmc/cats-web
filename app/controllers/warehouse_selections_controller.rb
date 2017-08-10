class WarehouseSelectionsController < ApplicationController
  before_action :set_warehouse_selection, only: [:edit, :update, :destroy]

  # GET /warehouse_selections
  # GET /warehouse_selections.json
  def index
    @warehouse_selections = WarehouseSelection.all
  end

  # GET /warehouse_selections/1
  # GET /warehouse_selections/1.json
  def show
    # @framework_tender = FrameworkTender.find(params[:id])
    # @ft_name = @framework_tender.year + '/' + @framework_tender.year_half
    @warehouse_selections = WarehouseSelection.joins(:location, warehouse: :hub).select(:id, 'warehouses.name AS warehouse_name', :'warehouse_selections.location_id', 'locations.name AS woreda_name', 'hubs.name AS hub_name', :estimated_qty).where(:framework_tender_id => params[:id])
  end

  # GET /warehouse_selections/new
  def new
    @warehouse_selection = WarehouseSelection.new
  end

  # GET /warehouse_selections/1/edit
  def edit
  end

  # POST /warehouse_selections
  # POST /warehouse_selections.json
  def create
    @warehouse_selection = WarehouseSelection.new(warehouse_selection_params)

    respond_to do |format|
      if @warehouse_selection.save
        format.html { redirect_to @warehouse_selection, notice: 'Warehouse selection was successfully created.' }
        format.json { render :show, status: :created, location: @warehouse_selection }
      else
        format.html { render :new }
        format.json { render json: @warehouse_selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /warehouse_selections/1
  # PATCH/PUT /warehouse_selections/1.json
  def update
    respond_to do |format|
      if @warehouse_selection.update(warehouse_selection_params)
        format.html { redirect_to @warehouse_selection, notice: 'Warehouse selection was successfully updated.' }
        format.json { render :show, status: :ok, location: @warehouse_selection }
      else
        format.html { render :edit }
        format.json { render json: @warehouse_selection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /warehouse_selections/1
  # DELETE /warehouse_selections/1.json
  def destroy
    @warehouse_selection.destroy
    respond_to do |format|
      format.html { redirect_to warehouse_selections_url, notice: 'Warehouse selection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse_selection
      @warehouse_selection = WarehouseSelection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_selection_params
      params.require(:warehouse_selection).permit(:ft_id, :framework_tender_id, :woreda_id, :warehouse_id, :estimated_qty, :created_by, :modified_by, :deleted, :deleted_at)
    end
end
