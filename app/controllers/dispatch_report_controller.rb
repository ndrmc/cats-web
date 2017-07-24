class DispatchReportController < ApplicationController

	# GET /dispatch_report
	# GET /dispatch_report.json
	def index
		@woreda = params[:woreda]
		@zone = params[:zone]
		@region = params[:region]
		@operation = params[:operation]


		if( @woreda.present? )
		  @woreda_name = Location.find(params[:woreda]).name
		  @zone_name = Location.find(params[:zone]).name
		  @region_name = Location.find(params[:region]).name
		  @operation_name = Operation.find(params[:operation]).name
		  @dispatch_report_cols = [ 'FDP', 'Requisition', 'Commodity', 'Allocated', 'Dispatched', 'Progress' ]
		  @dispatch_report = Reports.new.dispatch_reports_by_fdp @operation, @woreda 

		elsif ( @zone.present? )
		  @zone_name = Location.find(params[:zone]).name
		  @region_name = Location.find(params[:region]).name
		  @operation_name = Operation.find(params[:operation]).name
		@dispatch_report_cols = [ 'Woreda', 'Requisition', 'Commodity', 'Allocated', 'Dispatched', 'Progress' ]
		  @dispatch_report = Reports.new.dispatch_reports_by_woreda @operation, @zone

		elsif ( @region.present? )
		  @region_name = Location.find(params[:region]).name
		  @operation_name = Operation.find(params[:operation]).name
		  @dispatch_report_cols = [ 'Zone', 'Requisition', 'Commodity', 'Allocated', 'Dispatched', 'Progress' ]
		  @dispatch_report = Reports.new.dispatch_reports_by_zone @operation, @region

		elsif ( @operation.present? )
		  @operation_name = Operation.find(params[:operation]).name
		  @dispatch_report_cols = [ 'Region', 'Allocated', 'Dispatched', 'Progress' ]
		  @dispatch_report = Reports.new.dispatch_reports_by_region @operation

		else
		  @dispatch_report_cols = [ 'Region', 'Allocated', 'Dispatched', 'Progress' ]
		  @dispatch_report = Reports.new.dispatch_reports
		end
	end

end
