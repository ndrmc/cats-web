module TransportRequisitionsHelper

	def generate_tr (transport_requisition_params)
		@transport_requisition = TransportRequisition.new(transport_requisition_params)
		@transport_requisition.save
		count = Requisition.joins(:requisition_items).where({:operation_id => @transport_requisition.operation_id, :region_id => @transport_requisition.location_id, :status => :approved}).count
		if count > 0
		  	@program = Program.find(Operation.find(@transport_requisition.operation_id).program_id)
		  	@transport_requisition.reference_number = @program.code.to_s + '/' + @transport_requisition.location_id.to_s + '/' + @transport_requisition.id.to_s + '/' + Time.now.year.to_s
		  	@transport_requisition.status = :open
		  	@transport_requisition.save

		  	Requisition.where({:operation_id => @transport_requisition.operation_id, :region_id => @transport_requisition.location_id, :status => :approved}).find_each do |requisition|

		  		RequisitionItem.where({:requisition_id => requisition.id})
				.find_each do |ri|
			  		TransportRequisitionItem.new( transport_requisition_id: @transport_requisition.id, requisition_id: requisition.id, fdp_id: ri.fdp_id, commodity_id: requisition.commodity_id, quantity: ri.amount, has_transport_order: false, created_by: current_user.id).save
			  	end
			  	requisition.status = :ongoing
			  	requisition.save
		  	end
		  	return true
	    else
	    	@transport_requisition.destroy
	    	return false
	    end
  	end
end
