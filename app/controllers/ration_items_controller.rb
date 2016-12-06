class RationItemsController < ApplicationController
  before_action :set_ration_item, only: [:show, :edit, :update, :destroy]

  # GET /ration_items
  # GET /ration_items.json
  def index
    @ration = Ration.find params[:ration_id]
    @ration_items = RationItem.where ration: @ration
  end

  # GET /ration_items/1
  # GET /ration_items/1.json
  def show
  end

  # GET /ration_items/new
  def new
    @ration = Ration.find params[:ration_id]
    @ration_item = RationItem.new

    @ration_item.ration = @ration

    fetch_lookups
  end

  # GET /ration_items/1/edit
  def edit
    fetch_lookups
  end

  def unitOfMeasureSelectForCommodity
    commodity = Commodity.find params[:commodity_id]

    @relevant_uoms = commodity.unit_of_measure.uom_category.unit_of_measures

    render partial: 'ration_items/unitOfMeasureSelectForCommodity', relevant_uoms: @relevant_uoms
  end

  # POST /ration_items
  # POST /ration_items.json
  def create
    @ration_item = RationItem.new(ration_item_params)
    @ration = Ration.find params[:ration_id]

    fetch_lookups

    respond_to do |format|
      if @ration_item.save
        format.html { redirect_to ration_ration_items_path(@ration), notice: 'Ration item was successfully created.' }
        format.json { render :show, status: :created, location: @ration_item }
      else
        format.html { render :new }
        format.json { render json: @ration_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ration_items/1
  # PATCH/PUT /ration_items/1.json
  def update
    respond_to do |format|
      if @ration_item.update(ration_item_params)
        format.html { redirect_to ration_ration_items_path(@ration_item.ration), notice: 'Ration item was successfully updated.' }
        format.json { render :show, status: :ok, location: @ration_item }
      else
        format.html { render :edit }
        format.json { render json: @ration_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ration_items/1
  # DELETE /ration_items/1.json
  def destroy

    ration = @ration_item.ration

    @ration_item.destroy
    respond_to do |format|
      format.html { redirect_to ration_ration_items_url(ration), notice: 'Ration item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ration_item
      @ration_item = RationItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ration_item_params
      params.require(:ration_item).permit(:amount, :ration_id, :unit_of_measure_id, :commodity_id)
    end

    def fetch_lookups
      @all_commodities = Commodity.all
      @unit_of_measures = UnitOfMeasure.all
    end
end
