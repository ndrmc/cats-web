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
    @framework_tender = FrameworkTender.find_by_id(params[:id])
    @ft_name = @framework_tender&.year.to_s + '/' + @framework_tender&.half_year.to_s
    @total_destinations = WarehouseSelection.where(:framework_tender_id => params[:id]).count
    @total_amount = WarehouseSelection.where(:framework_tender_id => params[:id]).sum(:estimated_qty)
    @user = User.find_by_id(@framework_tender&.certified_by)
    @warehouse_selections = []
    @param_id = 0
    if (params[:region].to_s == '' || params[:region].to_s == nil)
      @param_id = Location.where({location_type: 'region'}).first.id
    else
      @param_id = params[:region]
    end
     WarehouseSelection.joins(:location, warehouse: :hub).where(:framework_tender_id => params[:id]).select(:id, 'warehouses.name AS warehouse_name', :'warehouse_selections.location_id', 'locations.name AS woreda_name', 'hubs.name AS hub_name', :estimated_qty)
      .find_each do |warehouse_selection|
        @region_id = Location.find(warehouse_selection.location_id).parent.parent_node_id
        if(@region_id.to_s == @param_id.to_s)
          @warehouse_selections << warehouse_selection
        end        
      end

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
    @warehouse_selection.created_by = current_user.id
    @warehouse_selection.modified_by = current_user.id
    @existing_ws = WarehouseSelection.where(:warehouse_id => @warehouse_selection.warehouse_id, :location_id => @warehouse_selection.location_id).count
    respond_to do |format|
      if @existing_ws == 0
        if @warehouse_selection.save
          format.html { redirect_to @warehouse_selection, notice: 'Warehouse selection was successfully created.' }
          format.json { render :show, status: :created, location: @warehouse_selection }
        else
          format.html { render :new }
          format.json { render json: @warehouse_selection.errors, status: :unprocessable_entity }
        end
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
    @woreda = Location.find_by_id(@warehouse_selection.location_id)
    respond_to do |format|
      if (@woreda.present?)
        format.html { redirect_to '/en/warehouse_selections/' + @warehouse_selection&.framework_tender_id&.to_s + '?region=' + @woreda.parent.parent.id.to_s , notice: 'Warehouse selection was successfully destroyed.' }
      else
        format.html { redirect_to '/en/warehouse_selections/' + @warehouse_selection&.framework_tender_id&.to_s, notice: 'Warehouse selection was successfully destroyed.' }
      end
      format.json { head :no_content }
    end
  end

  def get_by_region
    # @warehouse_selections = WarehouseSelectionsHelper.filter_by_region(params[:region])
    @results = []
    @warehouse_selections = WarehouseSelection.joins(:location, warehouse: :hub).select(:id, 'warehouses.name AS warehouse_name', :'warehouse_selections.location_id', 'locations.name AS woreda_name', 'hubs.name AS hub_name', :estimated_qty)
      .find_each do |warehouse_selection|
        @region_id = Location.find(warehouse_selection.location_id).parent.parent_node_id
        if(@region_id.to_s == params[:region].to_s)
          @results << warehouse_selection
        end        
      end
    render json: @results
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse_selection
      @warehouse_selection = WarehouseSelection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_selection_params
      params.require(:warehouse_selection).permit(:ft_id, :framework_tender_id, :location_id, :warehouse_id, :estimated_qty, :created_by, :modified_by, :deleted, :deleted_at, :region)
    end
end