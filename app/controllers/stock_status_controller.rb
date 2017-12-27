class StockStatusController < ApplicationController
  
  def index
	  @stock_status = Reports.new.journal_reports(params[:hub], params[:warehouse])
  end

  def stock_status_by_commodity_type
    @stock_status = Reports.new.stock_status_by_commodity_type(params[:hub], params[:warehouse])
  end

end
