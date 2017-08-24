module TransportOrdersHelper
	def generate_transport_order (tr_id, bid_id, performance_bond_receipt, performance_bond_amount)
		@transport_requisition = TransportRequisition.find(tr_id)

		@transport_requisition.transport_requisition_items
		.find_each do |tr_item|
			@woreda = Location.find(Fdp.find(tr_item.fdp_id).location_id)

			@bid_qoutations = BidQoutation.joins(:bid_quotation_details).where(:bid_id => bid_id, :'bid_quotation_details.location_id' => @woreda.id, :'bid_quotation_details.rank' => 1)
			@bid_qoutations.each do |bid_qoutation|
				@transport_order = TransportOrder.where({:transporter_id => bid_qoutation.transporter_id, :bid_id => bid_id, :operation_id => @transport_requisition.operation_id}).first
				if (@transport_order.present?)
					@new_to_detail = TransportOrderItem.new(transport_order_id: @transport_order.id, fdp_id: tr_item.fdp_id, commodity_id: tr_item.commodity_id, quantity: tr_item.quantity / @bid_qoutations.count, tariff: bid_qoutation.tariff)
					tr_item.has_transport_order = true
					tr_item.save
				else
					@new_to = TransportOrder.new(order_no: SecureRandom.uuid, transporter_id: bid_qoutation.transporter_id, bid_id: bid_id, operation_id: transport_requisition.operation_id, region_id: @woreda.parent.parent_node_id, order_date: (Date)Time.current, created_date: (Date)Time.current, start_date: 3.days.from_now, end_date: 13.days.from_now, performance_bond_receipt: performance_bond_receipt, performance_bond_amount: performance_bond_amount, printed_copies: 0, status: 0, created_by: current_user.id)
					@new_to.order_no = "TRN-ORD-" + @new_to.id
					@new_to.save
					@new_to_detail = TransportOrderItem.new(transport_order_id: @new_to.id, fdp_id: tr_item.fdp_id, commodity_id: tr_item.commodity_id, quantity: tr_item.quantity / @bid_qoutations.count, tariff: bid_qoutation.tariff)
					tr_item.has_transport_order = true
					tr_item.save
				end
			end
			
			
		end
	end
end
