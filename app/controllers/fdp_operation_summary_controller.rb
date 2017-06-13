class FdpOperationSummaryController < ApplicationController

  def index
  	if( params[:fdp_id].present? && params[:operation_id].present? )
		@operation = Operation.find(params[:operation_id])

		@program = Program.find(@operation.program_id)

		@fdp = Fdp.find(params[:fdp_id])

		if( params[:requisition_id].present?)
			@requisitionNumbers = Requisition.where('id' => params[:requisition_id]).pluck(:requisition_no)
		else
			@requisitionNumbers = Requisition.joins(:requisition_items).where(requisition_items: { fdp_id: params[:fdp_id] }, 
							operation_id: params[:operation_id]).pluck(:requisition_no)
		end
		#render :text => @requisitionNumbers.inspect


	  	#@dispatches = Dispatch.where(fdp_id: params[:fdp_id], operation_id: params[:operation_id], requisition_number: @requisitionNumbers)
	  					#.where('dispatch.requisition_no IN ? AND dispatch.fdp_id = ? AND disptach.operation_id = ?', @requisitionNumbers, params[:fdp_id], params[:operation_id])

  		@dispatches = Dispatch.where(fdp_id: params[:fdp_id], operation_id: params[:operation_id], requisition_number: @requisitionNumbers)
  						.joins(:dispatch_items)
					    .select("dispatch.*,  sum(dispatch_items.quantity) as dispatched_qty")
					    .group('dispatch.id')
					    
		@dispatchedQty = 0
	  	@dispatches.each do |d|
	  		@dispatchItems = DispatchItem.select('quantity').where('guid_ref = ?', d.dispatch_id_guid)
  			@dispatchItems.each do |di|
  				@dispatchedQty += di.quantity
			end
  		end

  		#@deliveries = Delivery.where(fdp_id: params[:fdp_id], operation_id: params[:operation_id], requisition_number: @requisitionNumbers)
	  					#.where('dispatch.requisition_no IN ? AND dispatch.fdp_id = ? AND disptach.operation_id = ?', @requisitionNumbers, params[:fdp_id], params[:operation_id])
		# @deliveries = Delivery.joins(:delivery_details)
		# 			    .select("delivery.*,  sum(delivery_details.received_quantity) as delivered_qty")
		# 			    .group('delivery.id')
		# 			    .where(fdp_id: params[:fdp_id], operation_id: params[:operation_id], requisition_number: @requisitionNumbers)
		# @deliveredQty = 0
	 #  	@deliveries.each do |de|
	 #  		@deliveryItems = DeliveryDetail.select('received_quantity').where('guid_ref_delivery_id = ?', de.delivery_id_guid)
  # 			@deliveryItems.each do |dd|
  # 				@deliveredQty += dd.received_quantity
		# 	end
  # 		end

    else
		@operation = []
      	@requisitionNumbers = []
      	@fdp = []
      	@dispatches = []
      	@delivery = []
    end
  end

end
