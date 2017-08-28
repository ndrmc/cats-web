class AllocationSummary < ActiveRecord::Base
	self.primary_key = "row_id"

	def self.operation_allocations(operation)
		allocations = AllocationSummary.where(operation_id: :operation)	
	end

end