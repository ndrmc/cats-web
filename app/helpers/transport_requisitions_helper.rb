module TransportRequisitionsHelper

	def generate_tr (transport_requisition_params)
		
		@requisitions = Requisition.where({:operation_id =>transport_requisition_params[:operation_id], :region_id => transport_requisition_params[:location_id], :status => :approved})
		if @requisitions.count > 0
			@transport_requisition = TransportRequisition.new(location_id: transport_requisition_params['location_id'], operation_id: transport_requisition_params['operation_id'], description: transport_requisition_params['description'])
				@transport_requisition.save
		  	@program = Program.find(Operation.find(@transport_requisition.operation_id).program_id)
		  	@transport_requisition.reference_number = @program.code.to_s + '/' + @transport_requisition.location_id.to_s + '/' + @transport_requisition.id.to_s + '/' + Time.now.year.to_s
		  	@transport_requisition.status = :open
		  	@transport_requisition.created_by = current_user.id
		  	@transport_requisition.save

		  	@requisitions.find_each do |requisition|

		  		requisition.requisition_items
				.find_each do |ri|
					if ri.unit_of_measure_id.present?
						@ri_qunatity = UnitOfMeasure.find(ri.unit_of_measure_id).to_ref(ri.amount)
					else
						@ri_qunatity = UnitOfMeasure.where(code: 'QTL').first.to_ref(ri.amount)
					end
			  		TransportRequisitionItem.new( transport_requisition_id: @transport_requisition.id, requisition_id: requisition.id, fdp_id: ri.fdp_id, commodity_id: requisition.commodity_id, quantity: @ri_qunatity, has_transport_order: false, created_by: current_user.id).save

			  	end
			  	requisition.status = :ongoing
			  	requisition.save
		  	end
		  	return @transport_requisition
	    else
	    	return nil
	    end
  	end
end
