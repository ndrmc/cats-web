class StoreLocationsController < ApplicationController
  before_action :set_store_location, only: [:show, :edit, :update, :destroy]

  # GET /store_locations
  # GET /store_locations.json
  def index
    @store_locations = StoreLocation.all
  end

  # GET /store_locations/1
  # GET /store_locations/1.json
  def show
  end

  # GET /store_locations/new
  def new
    @store_location = StoreLocation.new
    @store_location.hub_id=params[:hub_id]
  end

  # GET /store_locations/1/edit
  def edit
  end

  # POST /store_locations
  # POST /store_locations.json
  def create
    @hub=params[:hub_id]
    @store_location = StoreLocation.new(store_location_params)
    @store_location.hub_id=params[:hub_id]
    respond_to do |format|
      if @store_location.save
        format.html { redirect_to hub_path(@hub), notice: 'Store location was successfully created.' }
        format.json { render :show, status: :created, location: @store_location }
      else
        format.html { render :new }
        format.json { render json: @store_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /store_locations/1
  # PATCH/PUT /store_locations/1.json
  def update
    @hub=Hub.find(@store_location.hub_id)
    respond_to do |format|
      if @store_location.update(store_location_params)
        format.html { redirect_to hub_path(@hub), notice: 'Store location was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_location }
      else
        format.html { render :edit }
        format.json { render json: @store_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_locations/1
  # DELETE /store_locations/1.json
  def destroy
    @hub=Hub.find(@store_location.hub_id)
    @store_location.destroy
    respond_to do |format|
      format.html { redirect_to hub_path(@hub), notice: 'Store location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_location
      @store_location = StoreLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_location_params
      params.require(:store_location).permit(:name, :description, :location_id)
    end
end
