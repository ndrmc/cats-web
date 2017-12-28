class StockReportsController < ApplicationController
    def index
	  @stock_status = Reports.new.journal_reports(params[:hub], params[:warehouse])
  end

  def stock_status_by_project_code
     @stock_status = Reports.new.stock_status_by_project_code(params[:hub], params[:warehouse])
  end
end
