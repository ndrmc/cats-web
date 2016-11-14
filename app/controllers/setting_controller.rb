class SettingController < ApplicationController
  def index
    render :layout => 'admin'
  end
  def commodity_types  
    render 'commodity_type'
  end
end
