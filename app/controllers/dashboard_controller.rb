class DashboardController < ApplicationController
  def index
    @stock_status = Reports.new.stock_status_reports(params[:hub], params[:warehouse], params[:program], params[:commodity])
  	
  end
end
