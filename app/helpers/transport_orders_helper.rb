module TransportOrdersHelper
	def generate_transport_order (tr_id, bid_id)
		@transport_requisition = TransportRequisition.find(tr_id)
		@uom = UnitOfMeasure.where(:code => 'MT').first
		@transport_requisition.transport_requisition_items
		.find_each do |tr_item|
			@woreda = Location.find(Fdp.find(tr_item.fdp_id).location_id)
			@requisition = Requisition.find(tr_item.requisition_id)

			@bid_quotations = BidQuotation.joins(:bid_quotation_details).where(:bid_id => bid_id, :'bid_quotation_details.location_id' => @woreda.id, :'bid_quotation_details.rank' => 1).select(:'bid_quotation_details.id', :transporter_id, :'bid_quotation_details.location_id', :'bid_quotation_details.warehouse_id', :'bid_quotation_details.tariff')

			@bid_quotations.each do |bid_quotation|
				@transport_order = TransportOrder.where({:transporter_id => bid_quotation.transporter_id, :bid_id => bid_id, :operation_id => @transport_requisition.operation_id}).first
				if (@transport_order.present?)
					@new_to_detail = TransportOrderItem.new(transport_order_id: @transport_order.id, fdp_id: tr_item.fdp_id, commodity_id: tr_item.commodity_id, quantity: tr_item.quantity / @bid_quotations.pluck(:id).count, unit_of_measure_id: @uom.id, tariff: bid_quotation.tariff, requisition_no: @requisition.requisition_no, created_by: current_user.id)
					@new_to_detail.save
					tr_item.has_transport_order = true
					tr_item.save
				else
					@new_to = TransportOrder.new(order_no: SecureRandom.uuid, transporter_id: bid_quotation.transporter_id, bid_id: bid_id, operation_id: @transport_requisition.operation_id, region_id: @woreda.parent.parent_node_id, order_date: Time.current, created_date: Time.current, start_date: 3.days.from_now, end_date: 13.days.from_now, printed_copies: 0, status: 0, created_by: current_user.id, transport_requisition_id: @transport_requisition.id)
					@new_to.save
					@new_to.order_no = "TRN-ORD-" + @new_to.id.to_s	
					@new_to.save				
					@new_to_detail = TransportOrderItem.new(transport_order_id: @new_to.id, fdp_id: tr_item.fdp_id, commodity_id: tr_item.commodity_id, quantity: tr_item.quantity / @bid_quotations.pluck(:id).count, unit_of_measure_id: @uom.id, tariff: bid_quotation.tariff, requisition_no: @requisition.requisition_no, created_by: current_user.id)
					@new_to_detail.save
					tr_item.has_transport_order = true
					tr_item.save
				end
			end
			
			
		end
		return true
	end
end
