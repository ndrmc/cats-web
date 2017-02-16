class CommoditySourcesController < ApplicationController
  before_action :set_commodity_source, only: [:show, :edit, :update, :destroy]

  # GET /commodity_sources
  # GET /commodity_sources.json
  def index
    @commodity_sources = CommoditySource.all
  end

  # GET /commodity_sources/1
  # GET /commodity_sources/1.json
  def show
  end

  # GET /commodity_sources/new
  def new
    @commodity_source = CommoditySource.new
  end

  # GET /commodity_sources/1/edit
  def edit
  end

  # POST /commodity_sources
  # POST /commodity_sources.json
  def create
    @commodity_source = CommoditySource.new(commodity_source_params)

    respond_to do |format|
      if @commodity_source.save
        format.html { redirect_to commodity_sources_path, notice: 'Commodity source was successfully created.' }
        format.json { render :show, status: :created, location: @commodity_source }
      else
        format.html { render :new }
        format.json { render json: @commodity_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commodity_sources/1
  # PATCH/PUT /commodity_sources/1.json
  def update
    respond_to do |format|
      if @commodity_source.update(commodity_source_params)
        format.html { redirect_to commodity_sources_path, notice: 'Commodity source was successfully updated.' }
        format.json { render :show, status: :ok, location: @commodity_source }
      else
        format.html { render :edit }
        format.json { render json: @commodity_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commodity_sources/1
  # DELETE /commodity_sources/1.json
  def destroy
    @commodity_source.destroy
    respond_to do |format|
      format.html { redirect_to commodity_sources_url, notice: 'Commodity source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commodity_source
      @commodity_source = CommoditySource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commodity_source_params
      params.require(:commodity_source).permit(:name)
    end
end
