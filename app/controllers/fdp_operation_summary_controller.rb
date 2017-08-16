class FdpOperationSummaryController < ApplicationController

  def index
  	if( params[:fdp_id].present? && params[:operation_id].present? )

  		@backPath = request.referer
  		
		@operation = Operation.find(params[:operation_id])

		@program = Program.find(@operation.program_id)

		@fdp = Fdp.find(params[:fdp_id])

		if( params[:requisition_id].present?)
			@requisitionNumbers = Requisition.where('id' => params[:requisition_id]).pluck(:requisition_no)
		else
			@requisitionNumbers = Requisition.joins(:requisition_items).where(requisition_items: { fdp_id: params[:fdp_id] }, 
							operation_id: params[:operation_id]).pluck(:requisition_no)
		end

  		@dispatches = Dispatch.joins(:dispatch_items)
					    .select("fdp_id, operation_id, requisition_number, dispatch_date, draft, dispatch_id, gin_no, remark,
					    	sum(dispatch_items.quantity) as dispatched_qty")
					    .group('fdp_id, operation_id, requisition_number, dispatch_date, draft, dispatch_id, gin_no, remark')
					    .where(fdp_id: params[:fdp_id], operation_id: params[:operation_id], requisition_number: @requisitionNumbers)

    	@dispatchedAmountOfRequisitions = Dispatch.joins(:dispatch_items)
					    .select("sum(dispatch_items.quantity) as dispatched_qty")
					    .group('requisition_number')
					    .where(fdp_id: params[:fdp_id], operation_id: params[:operation_id], requisition_number: @requisitionNumbers)

					  		  
		@dispatchedQty = 0
	  	@dispatches.each do |d|
	  		@dispatchItems = DispatchItem.select('quantity').where('dispatch_id = ?', d.dispatch_id)
  			@dispatchItems.each do |di|
  				@dispatchedQty += di.quantity
			end
  		end

		@deliveries = Delivery.joins(:delivery_details)
					    .select("fdp_id, delivery_id_guid, operation_id, requisition_number, receiving_number, gin_number, received_date,
					    	sum(delivery_details.received_quantity) as delivered_qty")
					    .group('fdp_id, delivery_id_guid, operation_id, requisition_number, receiving_number, gin_number, received_date')
					    .where(fdp_id: params[:fdp_id], operation_id: params[:operation_id], requisition_number: @requisitionNumbers)

	    @deliveredAmountOfRequisitions = Delivery.joins(:delivery_details)
					    .group('requisition_number')
					    .where(fdp_id: params[:fdp_id], operation_id: params[:operation_id], requisition_number: @requisitionNumbers).pluck("sum(delivery_details.received_quantity) as delivered_qty")

		@deliveredQty = 0
	  	@deliveries.each do |de|
	  		@deliveryItems = DeliveryDetail.select('received_quantity').where('guid_ref_delivery_id = ?', de.delivery_id_guid)
  			@deliveryItems.each do |dd|
  				@deliveredQty += dd.received_quantity
			end
  		end

    else
		@operation = []
      	@requisitionNumbers = []
      	@fdp = []
      	@dispatches = []
      	@delivery = []
    end
  end

end
