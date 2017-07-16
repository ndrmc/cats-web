namespace :cats do
	namespace :operation do
		desc "Populates fdp_operations_log table with each participating documents"
		task populate_fdp_operations_log: :environment do

			# FdpOperationsLog.destroy_all

		puts "Check if unit_of_measure_id is null(empty) in dispatch_items, this will set them to quintal......"

		DispatchItem.find_each do |dispatch_item|
			if(dispatch_item.unit_of_measure_id.blank?)
				@qtl_unit_obj = UnitOfMeasure.where(:code => "QTL").first
				dispatch_item.unit_of_measure_id = @qtl_unit_obj.id
				dispatch_item.save
			end
		end
		puts "All dispatch_items now have unit_of_measure_id set for them"

		puts "Populate FdpOperationsLog with common and allocation data..."

		Requisition.joins("LEFT JOIN requisition_items ON requisitions.id = requisition_items.requisition_id LEFT JOIN commodities ON requisitions.commodity_id = commodities.id LEFT JOIN fdps ON requisition_items.fdp_id = fdps.id LEFT JOIN locations woreda ON fdps.location_id = woreda.id").select("requisitions.id, operation_id, fdp_id, woreda.id AS location_id, requisitions.id AS requisitions_id, requisitions.commodity_id, amount AS allocated").group("operation_id, fdp_id, woreda.id, requisitions.id, requisitions.commodity_id, allocated")
			.find_each do |allocation|
				disp_log = FdpOperationsLog.where(operation_id: allocation.operation_id, fdp_id: allocation.fdp_id, requisition_id: allocation.id, commodity_id: allocation.commodity_id).first
		  		fdp_op_log = FdpOperationsLog.new
		  		if( ! allocation.operation_id.blank? )
  					fdp_op_log.operation_id = allocation.operation_id
  				else
  					fdp_op_log.operation_id = 0
  				end
  				fdp_op_log.fdp_id = allocation.fdp_id
  				fdp_op_log.location_id = allocation.location_id
  				fdp_op_log.requisition_id = allocation.id
  				fdp_op_log.commodity_id = allocation.commodity_id
  				fdp_op_log.allocated_in_mt = allocation.allocated
  				fdp_op_log.save
  				
		  		if( disp_log.blank? )
			  		puts "Created Allocation Log: operation_id: #{allocation.operation_id}, fdp_id: #{allocation.fdp_id}, commodity_id: #{allocation.commodity_id}, requisition_id: #{allocation.id}, allocated: #{allocation.allocated}"
  				else
  					puts "Duplicate allocation found. - ABNORMAL"
	  			end
			end
		puts "populating allocation data is now successfully completed."

		puts "Populate FdpOperationsLog with dispatch data..."

		Dispatch.joins("LEFT JOIN dispatch_items d_items ON d_items.dispatch_id = dispatches.id LEFT JOIN requisitions ON requisitions.requisition_no = dispatches.requisition_number LEFT JOIN commodities ON d_items.commodity_id = commodities.id LEFT JOIN fdps ON dispatches.fdp_id = fdps.id LEFT JOIN locations woreda ON fdps.location_id = woreda.id").select("dispatches.id, requisitions.id AS requisition_id, d_items.quantity AS dispatched, dispatches.fdp_id, dispatches.operation_id, d_items.commodity_id, commodities.name AS commodity_name, dispatches.requisition_number, d_items.id, d_items.unit_of_measure_id, woreda.id AS location_id")
			.find_each do |dispatch_obj|
				@amount_in_ref = UnitOfMeasure.find(dispatch_obj.unit_of_measure_id).to_ref(dispatch_obj.dispatched)
		  		@disp_log = FdpOperationsLog.where("operation_id = ? AND fdp_id = ? AND requisition_id = ? AND commodity_id = ?", dispatch_obj.operation_id, dispatch_obj.fdp_id, dispatch_obj.requisition_id, dispatch_obj.commodity_id).first
		  		if( @disp_log.present? )
		  			if ( ! @disp_log.dispatched_in_mt.blank? )
			  			@disp_log.dispatched_in_mt += @amount_in_ref
			  		else
			  			@disp_log.dispatched_in_mt = @amount_in_ref
			  		end
			  		@disp_log.save
			  		puts "Duplicate dispatch found. - NORMAL"
		  		else
	  				fdp_op_log = FdpOperationsLog.new
	  				if( ! dispatch_obj.operation_id.blank? )
	  					fdp_op_log.operation_id = dispatch_obj.operation_id
	  				else
	  					fdp_op_log.operation_id = 0
	  				end
	  				fdp_op_log.fdp_id = dispatch_obj.fdp_id
	  				fdp_op_log.location_id = dispatch_obj.location_id
	  				fdp_op_log.requisition_id = dispatch_obj.requisition_id
	  				fdp_op_log.commodity_id = dispatch_obj.commodity_id
	  				fdp_op_log.dispatched_in_mt = @amount_in_ref
	  				fdp_op_log.save
	  				puts "Created Dispatch Log: operation_id: #{dispatch_obj.operation_id}, fdp_id: #{dispatch_obj.fdp_id}, commodity_id: #{dispatch_obj.commodity_id}, requisition_id: #{dispatch_obj.requisition_id}, dispatched: #{@amount_in_ref}"
	  			end
			end
		puts "Populating dispatch data is now successfully completed."
		
		puts "Populating FdpOperationsLog with delivery data..."

		Delivery.joins("LEFT JOIN delivery_details ON delivery_details.delivery_id = deliveries.id LEFT JOIN requisitions ON requisitions.requisition_no = deliveries.requisition_number LEFT JOIN fdps ON deliveries.fdp_id = fdps.id LEFT JOIN locations woreda ON fdps.location_id = woreda.id").select("deliveries.id, delivery_details.received_quantity, deliveries.fdp_id, deliveries.operation_id, woreda.id AS location_id, delivery_details.commodity_id, deliveries.requisition_number, delivery_details.uom_id, requisitions.id AS requisition_id")
			.find_each do |delivery|
				@amount_in_ref = UnitOfMeasure.find(delivery.uom_id).to_ref(delivery.received_quantity)
		  		@delivery_log = FdpOperationsLog.where("operation_id = ? AND fdp_id = ? AND requisition_id = ? AND commodity_id = ?", delivery.operation_id, delivery.fdp_id, delivery.requisition_id, delivery.commodity_id).first
		  		if( @delivery_log.present? )
		  			if ( ! @delivery_log.delivered_in_mt.blank? )
			  			@delivery_log.delivered_in_mt += @amount_in_ref
			  		else
			  			@delivery_log.delivered_in_mt = @amount_in_ref
			  		end
			  		@delivery_log.save
			  		puts "Duplicate delivery found. - NORMAL"
		  		else
	  				fdp_op_log = FdpOperationsLog.new
	  				if( ! delivery.operation_id.blank? )
	  					fdp_op_log.operation_id = delivery.operation_id
	  				else
	  					fdp_op_log.operation_id = 0
	  				end
	  				fdp_op_log.fdp_id = delivery.fdp_id
	  				fdp_op_log.location_id = delivery.location_id
	  				fdp_op_log.requisition_id = delivery.requisition_id
	  				fdp_op_log.commodity_id = delivery.commodity_id
	  				fdp_op_log.delivered_in_mt = @amount_in_ref
	  				fdp_op_log.save
	  				puts "Created Delivery Log: operation_id: #{delivery.operation_id}, fdp_id: #{delivery.fdp_id}, commodity_id: #{delivery.commodity_id}, requisition_id: #{delivery.requisition_id}, delivered: #{@amount_in_ref}"
	  			end
			end
		end
		puts "Populating delivery data is now successfully completed."
	end
end