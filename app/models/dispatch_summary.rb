class DispatchSummary < ActiveRecord::Base
	self.primary_key = "row_id"

	def self.operation(operation_id)
		DispatchSummary.where(operation_id: operation_id)
	end

	def self.yearly(year)
		DispatchSummary.where(operation_year: year)
	end

end