module TransportRequisitionsHelper

	def generate_tr (transport_requisition_params)
		
		@requisitions = Requisition.joins(:requisition_items).where({:operation_id =>transport_requisition_params[:operation_id], :region_id => transport_requisition_params[:location_id], :status => :approved})
		if @requisitions.count > 0
			@transport_requisition = TransportRequisition.new(transport_requisition_params)
				@transport_requisition.save
		  	@program = Program.find(Operation.find(@transport_requisition.operation_id).program_id)
		  	@transport_requisition.reference_number = @program.code.to_s + '/' + @transport_requisition.location_id.to_s + '/' + @transport_requisition.id.to_s + '/' + Time.now.year.to_s
		  	@transport_requisition.status = :open
		  	@transport_requisition.save

		  	@requisitions.find_each do |requisition|

		  		requisition.requisition_items
				.find_each do |ri|
			  		TransportRequisitionItem.new( transport_requisition_id: @transport_requisition.id, requisition_id: requisition.id, fdp_id: ri.fdp_id, commodity_id: requisition.commodity_id, quantity: ri.amount, has_transport_order: false, created_by: current_user.id).save
			  	end
			  	requisition.status = :ongoing
			  	requisition.save
		  	end
		  	return true
	    else
	    	return false
	    end
  	end
end
