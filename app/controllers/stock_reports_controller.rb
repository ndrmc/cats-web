class StockReportsController < ApplicationController
  def index
	  @stock_status = Reports.new.journal_reports(params[:hub], params[:warehouse])
  end

  def stock_status_by_project_code
     @stock_status = Reports.new.stock_status_by_project_code(params[:hub], params[:warehouse])
  end

  def stock_status_by_commodity_type
    @stock_status = Reports.new.stock_status_by_commodity_type(params[:hub], params[:warehouse])
  end

  def received_stock_by_project_code
    @warehouses = Warehouse.all
    @stock_status = Reports.new.received_stock_by_project_code(params[:from_date], params[:to_date], params[:hub], params[:warehouse])
  end
  
end
