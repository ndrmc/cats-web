class DashboardController < ApplicationController
  def index
  	@hrd = Hrd.current_hrd
	@psnp_plan = PsnpPlan.current_plan
  	@total_stock = StockSummary.total_stock[0].sum_quantity
  	@category_balance = StockSummary.category_balance
  	@operations = operation_summary
  end

  private
  def operation_summary
  	
  	allocations = AllocationSummary.get_last_five_operations
  	dispatches = DispatchSummary.get_all

  	summary = []

  	allocations.each do |alloc|
  		dispatch = dispatches.find{ |d| d["operation_id"] == alloc[:id]}
  		status = 0
  		status = dispatch&.sum/alloc[:allocation_total] unless dispatch.nil?
  		entry = {
  			     id: alloc[:id],
  			     name: alloc[:operation],
  			     allocated: alloc[:allocation_total],
  			     dispatched: dispatch&.sum.to_s,
  			     progress: status
  			 }

  		summary << entry
  	end

  	return summary

  end
end
