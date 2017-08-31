# == Schema Information
#
# Table name: allocation_summaries
#
#  row_id           :integer          primary key
#  operation_id     :integer
#  operation_name   :string
#  program_id       :integer
#  commodity_id     :integer
#  commodity_name   :string
#  total_allocation :decimal(, )
#

class AllocationSummary < ActiveRecord::Base
	self.primary_key = "row_id"

	def self.total(operation_id)
		# Ideally if we expect all items in a ration use the same unit of measure, the calculation would have been 
		# reduced to
		#AllocationSummary.commodity_allocation(34).map{|item| item['total_allocation']}.reduce(0, :+).to_i

		allocations = AllocationSummary.where(operation_id: operation_id)
		current_operation = Operation.find(operation_id)
		total_amount = 0
		current_operation.ration.ration_items.each do |item|
			allocations.each do |alloc|
				if alloc.commodity_id == item.commodity_id
					total_amount += item.unit_of_measure.to_ref(alloc.total_allocation)
				end			
			end
		end
		return total_amount		
	end

	def self.commodity_total(operation_id)
		AllocationSummary.where(operation_id: operation_id)
	end

	def self.yearly(year)
		ops = Operation.where(year: year)
		allocations = []
		ops.each do | operation|
			alloc_total = AllocationSummary.total(operation.id)
			allocations << {id: operation.id, operation: operation.name, allocation_total: alloc_total}
		end
		return allocations
	end


end
