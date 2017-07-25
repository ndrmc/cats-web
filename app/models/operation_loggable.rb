module OperationLoggable

	def create_log_callback
		if (self.is_a?(Requisition))
	      logger.info "Log operation information for Requisition"
	      create_log_requisition
	    elsif(self.is_a?(Dispatch))
	      logger.info "Log operation information for Dispatch"
	      create_log_dispatch
	    elsif(self.is_a?(Delivery))
	      logger.info "Log operation information for Delivery"
	      create_log_delivery
	    elsif(self.is_a?(Distribution))
	      logger.info "Log operation information for Distribution"
	      create_log_distribution
	    end
	end 

	def create_log_requisition
		self.requisition_items.each do |requisition_item|
			existing_operation_log = FdpOperationsLog.where(operation_id: self.operation_id, fdp_id: requisition_item.fdp_id, requisition_id: self.id, commodity_id: self.commodity_id).first
			operation = Operation.find_by_id(self.operation_id)
			fdp = Fdp.find_by_id(requisition_item.fdp_id)
			woreda = Location.find_by_id(fdp.location_id)
			zone = Location.find_by_id(woreda.parent_node_id)
			region = Location.find_by_id(zone.parent_node_id)
			commodity = Commodity.find_by_id(self.commodity_id)

			if( ! existing_operation_log.present? )	

				fdp_op_log = FdpOperationsLog.new
		  		fdp_op_log.operation_id = operation.id
				fdp_op_log.operation_name = operation.name
  				fdp_op_log.fdp_id = fdp.id
  				fdp_op_log.fdp_name = fdp.name
  				fdp_op_log.woreda_id = woreda.id
  				fdp_op_log.woreda_name = woreda.name
  				fdp_op_log.zone_id = zone.id
  				fdp_op_log.zone_name = zone.name
  				fdp_op_log.region_id = region.id
  				fdp_op_log.region_name = region.name
  				fdp_op_log.requisition_id = self.id
  				fdp_op_log.requisition_no = self.requisition_no
  				fdp_op_log.commodity_id = commodity.id
  				fdp_op_log.commodity_name = commodity.name
  				fdp_op_log.allocated_in_mt = requisition_item.amount
  				fdp_op_log.save
			else
				if(existing_operation_log.allocated_in_mt.blank?)
					existing_operation_log.allocated_in_mt = requisition_item.amount
				else
					existing_operation_log.allocated_in_mt += requisition_item.amount
				end		
				existing_operation_log.operation_name = operation.name
  				existing_operation_log.fdp_name = fdp.name
  				existing_operation_log.woreda_name = woreda.name
  				existing_operation_log.zone_name = zone.name
  				existing_operation_log.region_name = region.name
  				existing_operation_log.requisition_no = self.requisition_no
  				existing_operation_log.commodity_name = commodity.name			
				existing_operation_log.save
			end
  		end  		
	end

	def create_log_dispatch
		self.dispatch_items.each do |dispatch_item|
			@requisition_obj = Requisition.where(:requisition_no => self.requisition_number).first
			existing_operation_log = FdpOperationsLog.where(operation_id: self.operation_id, fdp_id: self.fdp_id, requisition_id: @requisition_obj.id, commodity_id: dispatch_item.commodity_id).first
			@amount_in_ref = UnitOfMeasure.find(dispatch_item.unit_of_measure_id).to_ref(dispatch_item.quantity)		
			operation = Operation.find_by_id(self.operation_id)
			fdp = Fdp.find_by_id(self.fdp_id)
			woreda = Location.find_by_id(fdp.location_id)
			zone = Location.find_by_id(woreda.parent_node_id)
			region = Location.find_by_id(zone.parent_node_id)
			commodity = Commodity.find_by_id(dispatch_item.commodity_id)
			
			if( ! existing_operation_log.present? )				

				fdp_op_log = FdpOperationsLog.new
  				fdp_op_log.operation_id = self.operation_id
  				fdp_op_log.operation_name = operation.name
  				fdp_op_log.fdp_id = self.fdp_id
  				fdp_op_log.fdp_name = fdp.name
  				fdp_op_log.woreda_id = woreda.id
  				fdp_op_log.woreda_name = woreda.name
  				fdp_op_log.zone_id = zone.id
  				fdp_op_log.zone_name = zone.name
  				fdp_op_log.region_id = region.id
  				fdp_op_log.region_name = region.name
  				fdp_op_log.requisition_id = @requisition_obj.id
  				fdp_op_log.requisition_no = @requisition_obj.requisition_no
  				fdp_op_log.commodity_id = commodity.id
  				fdp_op_log.commodity_name = commodity.name
  				fdp_op_log.dispatched_in_mt = @amount_in_ref
  				fdp_op_log.save
			else
				if(existing_operation_log.dispatched_in_mt.blank?)
					existing_operation_log.dispatched_in_mt = @amount_in_ref
				else
					existing_operation_log.dispatched_in_mt += @amount_in_ref
				end	
				existing_operation_log.operation_name = operation.name
  				existing_operation_log.fdp_name = fdp.name
  				existing_operation_log.woreda_name = woreda.name
  				existing_operation_log.zone_name = zone.name
  				existing_operation_log.region_name = region.name
  				existing_operation_log.requisition_no = @requisition_obj.requisition_no
  				existing_operation_log.commodity_name = commodity.name				
				existing_operation_log.save
			end
  		end
	end

	def create_log_delivery
		self.delivery_details.each do |delivery_detail|
			@requisition_obj = Requisition.where(:requisition_no => self.requisition_number).first
			existing_operation_log = FdpOperationsLog.where(operation_id: self.operation_id, fdp_id: self.fdp_id, requisition_id: @requisition_obj.id, commodity_id: delivery_detail.commodity_id).first
			@amount_in_ref = UnitOfMeasure.find(delivery_detail.uom_id).to_ref(delivery_detail.received_quantity)		  		
			operation = Operation.find_by_id(self.operation_id)
			fdp = Fdp.find_by_id(self.fdp_id)
			woreda = Location.find_by_id(fdp.location_id)
			zone = Location.find_by_id(woreda.parent_node_id)
			region = Location.find_by_id(zone.parent_node_id)
			commodity = Commodity.find_by_id(delivery_detail.commodity_id)

			if( ! existing_operation_log.present? )				

				fdp_op_log = FdpOperationsLog.new
  				fdp_op_log.operation_id = self.operation_id
  				fdp_op_log.fdp_id = self.fdp_id
  				fdp_op_log.fdp_name = fdp.name
  				fdp_op_log.woreda_id = woreda.id
  				fdp_op_log.woreda_name = woreda.name
  				fdp_op_log.zone_id = zone.id
  				fdp_op_log.zone_name = zone.name
  				fdp_op_log.region_id = region.id
  				fdp_op_log.region_name = region.name
  				fdp_op_log.requisition_id = @requisition_obj.id
  				fdp_op_log.requisition_no = @requisition_obj.requisition_no
  				fdp_op_log.commodity_id = delivery_detail.commodity_id
  				fdp_op_log.commodity_name = commodity.commodity_name
  				fdp_op_log.delivered_in_mt = @amount_in_ref
  				fdp_op_log.save
			else
				if(existing_operation_log.delivered_in_mt.blank?)
					existing_operation_log.delivered_in_mt = @amount_in_ref
				else
					existing_operation_log.delivered_in_mt += @amount_in_ref
				end
				existing_operation_log.operation_name = operation.name
  				existing_operation_log.fdp_name = fdp.name
  				existing_operation_log.woreda_name = woreda.name
  				existing_operation_log.zone_name = zone.name
  				existing_operation_log.region_name = region.name
  				existing_operation_log.requisition_no = @requisition_obj.requisition_no
  				existing_operation_log.commodity_name = commodity.name
				existing_operation_log.save
			end
  		end
	end

	def create_log_distribution
		
	end



	def update_callback

	end
end
