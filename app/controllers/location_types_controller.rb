class LocationTypesController < ApplicationController
  layout 'admin'
  before_action :set_location_type, only: [:show, :edit, :update, :destroy]

  # GET /location_types
  # GET /location_types.json
  def index
    @location_types = LocationType.all
  end

  # GET /location_types/1
  # GET /location_types/1.json
  def show
  end

  # GET /location_types/new
  def new
    @location_type = LocationType.new
  end

  # GET /location_types/1/edit
  def edit
  end

  # POST /location_types
  # POST /location_types.json
  def create
    @location_type = LocationType.new(location_type_params)

    respond_to do |format|
      if @location_type.save
        format.html { redirect_to location_types_url, notice: 'Location type was successfully created.' }
        format.json { render :show, status: :created, location: @location_type }
      else
        format.html { render :new }
        format.json { render json: @location_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /location_types/1
  # PATCH/PUT /location_types/1.json
  def update
    respond_to do |format|
      if @location_type.update(location_type_params)
        format.html { redirect_to @location_type, notice: 'Location type was successfully updated.' }
        format.json { render :show, status: :ok, location: @location_type }
      else
        format.html { render :edit }
        format.json { render json: @location_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /location_types/1
  # DELETE /location_types/1.json
  def destroy
    @location_type.destroy
    respond_to do |format|
      format.html { redirect_to location_types_url, notice: 'Location type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_type
      @location_type = LocationType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_type_params
      params.require(:location_type).permit(:name, :description)
    end
end
