class Setting::CommodityTypesController < ApplicationController
  def index
    @commodity_type=CommodityCategory.new
    @commodity_types=CommodityCategory.all
  end
  def create
    @commodity_type=CommodityCategory.new(params.require(:commodity_type).permit(:name,:code,:code_am,:description))
    if @commodity_type.save
      redirect_to setting_commodity_types_path
    else
      redirect_to :back
    end
  end
  def edit
    @commodity_type=CommodityCategory.find (params[:id])
  end
  def update
    @commodity_type=CommodityCategory.find (params[:id])
    if(@commodity_type.update(commodity_type_params))
    redirect_to setting_commodity_types_path
    else
    redirect_to :back
    end
  end
  def destroy
    @commodity_type= CommodityCategory.find (params[:id])
    @commodity_type.destroy
    redirect_to setting_commodity_types_path
  end

  private
  def commodity_type_params
    params.require(:commodity_category).permit(:name,:code,:code_am,:description)
  end

end
