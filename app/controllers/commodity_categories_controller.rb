class CommodityCategoriesController < ApplicationController
  layout 'admin'
  before_action :set_commodity_category, only: [:show, :edit, :update, :destroy]
  include Administrated
  # GET /commodity_categories
  # GET /commodity_categories.json
  def index
    @commodity_categories = CommodityCategory.all
  end

  # GET /commodity_categories/1
  # GET /commodity_categories/1.json
  def show
  end

  # GET /commodity_categories/new
  def new
    @commodity_category = CommodityCategory.new
  end

  # GET /commodity_categories/1/edit
  def edit
  end

  # POST /commodity_categories
  # POST /commodity_categories.json
  def create
    @commodity_category = CommodityCategory.new(commodity_category_params)

    respond_to do |format|
      if @commodity_category.save
        format.html { redirect_to commodity_categories_path, notice: 'Commodity category was successfully created.' }
        format.json { render :show, status: :created, location: @commodity_category }
      else
        format.html { render :new }
        format.json { render json: @commodity_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commodity_categories/1
  # PATCH/PUT /commodity_categories/1.json
  def update
    respond_to do |format|
      if @commodity_category.update(commodity_category_params)
        format.html { redirect_to commodity_categories_path, notice: 'Commodity category was successfully updated.' }
        format.json { render :show, status: :ok, location: @commodity_category }
      else
        format.html { render :edit }
        format.json { render json: @commodity_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commodity_categories/1
  # DELETE /commodity_categories/1.json
  def destroy
    @commodity_category.destroy
    respond_to do |format|
      format.html { redirect_to commodity_categories_url, notice: 'Commodity category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commodity_category
      @commodity_category = CommodityCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commodity_category_params
      params.require(:commodity_category).permit(:name, :code, :code_am, :uom_category_id, :description)
    end
end
