class RationItemsController < ApplicationController
  before_action :set_ration_item, only: [:show, :edit, :update, :destroy]

  # GET /ration_items
  # GET /ration_items.json
  def index
    @ration_items = RationItem.all
  end

  # GET /ration_items/1
  # GET /ration_items/1.json
  def show
  end

  # GET /ration_items/new
  def new
    @ration = Ration.find(params[:ration_id])

    if @ration == nil
      format.html {render :new}
      format.json {render json: @ration.errors, status: :unprocessable_entity}
    end

    @ration_item = RationItem.new
    @ration_item.ration_id = @ration.id
  end

  def add_commodty
    @ration = Ration.find(params[:ration_id])
    @ration_item = RationItem.new
    @ration_item.ration_id = @ration.id
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /ration_items/1/edit
  def edit
  end

  # POST /ration_items
  # POST /ration_items.json
  def create
    @ration_item = RationItem.new(ration_item_params)

    respond_to do |format|
      if @ration_item.save
        format.html { redirect_to ration_path(Ration.find(@ration_item.ration_id)), notice: 'Ration item was successfully created.' }
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
        format.html { redirect_to ration_path(Ration.find(@ration_item.ration_id)), notice: 'Ration item was successfully updated.' }
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
    @ration_item.destroy
    respond_to do |format|
      format.html { redirect_to ration_path(Ration.find(@ration_item.ration_id)), notice: 'Ration item was successfully destroyed.' }
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
      params.require(:ration_item).permit(:ration_id, :amount, :commodity_id, :unit_of_measure_id)
    end
end
