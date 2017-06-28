class DispatchReportController < ApplicationController

  def index

  	@woreda = params[:woreda]
  	@zone = params[:zone]
  	@region = params[:region]
  	@operation = params[:operation]

  	if( @woreda.present? )
  		@dispatch_report_cols = [ 'FDP', 'Requisition', 'Commodity', 'Allocated', 'Dispatched', 'Progress' ]
  		@dispatch_report = Reports.new.dispatch_reports_by_fdp @operation, @woreda 

  	elsif ( @zone.present? )
		@dispatch_report_cols = [ 'Woreda', 'Requisition', 'Commodity', 'Allocated', 'Dispatched', 'Progress' ]
  		@dispatch_report = Reports.new.dispatch_reports_by_woreda @operation, @zone

  	elsif ( @region.present? )
  		@dispatch_report_cols = [ 'Zone', 'Requisition', 'Commodity', 'Allocated', 'Dispatched', 'Progress' ]
  		@dispatch_report = Reports.new.dispatch_reports_by_zone @operation, @region

  	elsif ( @operation.present? )
  		@dispatch_report_cols = [ 'Region', 'Allocated', 'Dispatched', 'Progress' ]
  		@dispatch_report = Reports.new.dispatch_reports_by_region @operation

	else
		@dispatch_report_cols = [ 'Region', 'Allocated', 'Dispatched', 'Progress' ]
  		@dispatch_report = Reports.new.dispatch_reports
  	end

  end
end
