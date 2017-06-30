class StockStatusController < ApplicationController
  
  def index
	@stock_status = Reports.new.journal_reports(params[:hub], params[:program], params[:commodity], params[:operation])
  end

end
