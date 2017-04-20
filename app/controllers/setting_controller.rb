class SettingController < ApplicationController
  layout 'admin'

  include Administrated
  
  def index
    
  end
  def commodity_types  
    render 'commodity_type'
  end
end
