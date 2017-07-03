class StockStatusController < ApplicationController
  
  def index2
	@stock_status = Reports.new.journal_reports(params[:hub], params[:program], params[:commodity], params[:operation])
  end

  def index
	@stock_status = Reports.new.stock_status_reports(params[:hub], params[:program], params[:commodity])
  end

end
