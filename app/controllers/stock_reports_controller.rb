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
    dates = []
    if params[:received_date].present?
      dates = params[:received_date].split(' - ').map { |d| Date.parse d }
    end
    @warehouses = Warehouse.all
    @stock_status = Reports.new.received_stock_by_project_code(dates[0],dates[1], params[:hub], params[:warehouse])
  end

  def received_stock_by_commodity_source
    dates = []
    if params[:received_date].present?
      dates = params[:received_date].split(' - ').map { |d| Date.parse d }
    end
    @warehouses = Warehouse.all
    @stock_status = Reports.new.received_stock_by_commodity_source(dates[0],dates[1], params[:hub], params[:warehouse])
  end
  
   def dispatch_report_by_project
     if params[:dispatched_date ].present?
        dates = params[:dispatched_date].split(' - ').map { |d| Date.parse d }
        @dispatch_status_by_project = Reports.new.dispatch_report_by_project(params[:hub], params[:warehouse],dates[0],dates[1])
      else
        @dispatch_status_by_project = Reports.new.dispatch_report_by_project(params[:hub], params[:warehouse],'','')
      end
    
  end
  
end
