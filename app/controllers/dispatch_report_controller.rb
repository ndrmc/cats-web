class DispatchReportController < ApplicationController

  def index

  	@woreda = params[:woreda]
  	@zone = params[:zone]
  	@region = params[:region]
  	@operation = params[:operation]

  	if( @woreda.present? )

  		@dispatch_report = Reports.new.dispatch_reports_by_fdp @operation, @woreda 

  	elsif ( @zone.present? )

  		@dispatch_report = Reports.new.dispatch_reports_by_woreda @operation, @zone

  	elsif ( @region.present? )

  		@dispatch_report = Reports.new.dispatch_reports_by_zone @operation, @region

  	elsif ( @operation.present? )

  		@dispatch_report = Reports.new.dispatch_reports_by_region @operation

	else

		@dispatch_report = []

  	end

  end
end
