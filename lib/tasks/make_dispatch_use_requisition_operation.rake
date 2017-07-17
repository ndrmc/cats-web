namespace :cats do
	namespace :operation do
		desc "Populates fdp_operations_log table with each participating documents"
		task make_dispatch_use_requisition_operation: :environment do
			puts "Start updating dispatch operaion_id with requisition opeartion_id..."

			Dispatch.joins("LEFT JOIN requisitions ON requisitions.requisition_no = dispatches.requisition_number")
			.select("dispatches.id, dispatches.operation_id AS d_op_id, requisitions.operation_id AS req_op_id")
			.where("requisitions.operation_id != dispatches.operation_id")
				.find_each do |dispatch_obj|
					@dispatch = Dispatch.find_by_id(dispatch_obj.id)
			  		@dispatch.operation_id = dispatch_obj.req_op_id
			  		@dispatch.save
				end
			puts "Updating dispatch is successfully completed."
		end
	end
end