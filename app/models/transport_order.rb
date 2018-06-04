# == Schema Information
#
# Table name: transport_orders
#
#  id                       :integer          not null, primary key
#  order_no                 :string
#  transporter_id           :integer
#  contract_id              :integer
#  bid_id                   :integer
#  operation_id             :integer
#  location_id                :integer
#  order_date               :date
#  created_date             :date
#  start_date               :date
#  end_date                 :date
#  performance_bond_receipt :string
#  performance_bond_amount  :decimal(, )
#  printed_copies           :integer          default(0), not null
#  status                   :integer          default("draft"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  created_by               :integer
#  modified_by              :integer
#  deleted_at               :datetime
#

class TransportOrder < ApplicationRecord
	enum status: [:draft, :approved, :ongoing, :closed, :canceled, :archived]
	belongs_to :operation
	belongs_to :transporter
	belongs_to :contract
	has_many :transport_order_items, dependent: :destroy
	belongs_to :bid
	belongs_to :location

  	def self.generate_transport_order (tr_id, bid_id, user_id)
		@transport_requisition = TransportRequisition.find(tr_id)
		@uom = UnitOfMeasure.where(:code => 'MT').first
		@transport_requisition.transport_requisition_items
		.find_each do |tr_item|
			@woreda = Location.find(Fdp.find(tr_item.fdp_id).location_id)
			@requisition = Requisition.find(tr_item.requisition_id)

			# @warehouse_ids = BidQuotation.joins(:bid_quotation_details).where(:bid_id => bid_id, :'bid_quotation_details.location_id' => @woreda.id, :'bid_quotation_details.rank' => 1).select(:'bid_quotation_details.warehouse_id').distinct

			# @warehouse_ids.each do |warehouse_id|
		
			@bid_quotations = BidQuotation.joins(:bid_quotation_details).where(:bid_id => bid_id,:'bid_quotation_details.location_id' => @woreda.id, :'bid_quotation_details.rank' => 1).select(:'bid_quotation_details.id', :transporter_id, :'bid_quotation_details.location_id', :'bid_quotation_details.warehouse_id', :'bid_quotation_details.tariff')# bid quotation for each warehouse
			@bid_quotations.each do |bid_quotation|
				@transport_order = TransportOrder.where({:transporter_id => bid_quotation.transporter_id, :bid_id => bid_id, :operation_id => @transport_requisition.operation_id}).first
				if (@transport_order.present?)
					@new_to_detail = TransportOrderItem.new(transport_order_id: @transport_order.id, fdp_id: tr_item.fdp_id, commodity_id: tr_item.commodity_id, quantity: tr_item.quantity / @bid_quotations.pluck(:id).count, unit_of_measure_id: @uom.id, tariff: bid_quotation.tariff, requisition_no: @requisition.requisition_no, created_by: user_id, transport_requisition_item_id: tr_item.id, warehouse_id: bid_quotation.warehouse_id)
					@new_to_detail.save
					tr_item.has_transport_order = true
					tr_item.save

				else
					@new_to = TransportOrder.new(order_no: SecureRandom.uuid, transporter_id: bid_quotation.transporter_id, bid_id: bid_id, operation_id: @transport_requisition.operation_id, location_id: @woreda.parent.parent_node_id, order_date: Time.current, created_date: Time.current, start_date: 3.days.from_now, end_date: 13.days.from_now, printed_copies: 0, status: 0, created_by: user_id)
					@new_to.save
					@new_to.order_no = "TRN-ORD-" + @new_to.id.to_s	
					@new_to.save				
					@new_to_detail = TransportOrderItem.new(transport_order_id: @new_to.id, fdp_id: tr_item.fdp_id, commodity_id: tr_item.commodity_id, quantity: tr_item.quantity / @bid_quotations.pluck(:id).count, unit_of_measure_id: @uom.id, tariff: bid_quotation.tariff, requisition_no: @requisition.requisition_no, created_by: user_id, transport_requisition_item_id: tr_item.id, warehouse_id: bid_quotation.warehouse_id)
					@new_to_detail.save
					tr_item.has_transport_order = true
					tr_item.save

				end
			end
			
			
		end
		return true
	end

	def self.to_for_exception (tr_id, woreda_id, transporter_id, tariff, user_id)
	    @transport_requisition = TransportRequisition.find(tr_id)
	    if(@transport_requisition.transport_requisition_items.count < 1)
	      return false
	    end   


	    @uom = UnitOfMeasure.where(:code => 'MT').first
	    @transport_requisition.transport_requisition_items.joins(fdp: :location).where(:has_transport_order => false, :'locations.id' => woreda_id)
	      .find_each do |tr_item|
	        @woreda = Location.find(woreda_id)
	        @requisition = Requisition.find(tr_item.requisition_id)
	        @transport_order = TransportOrder.where({:transporter_id => transporter_id, :operation_id => @transport_requisition.operation_id}).where.not({status: [:closed, :canceled, :archived] }).first
	        if (@transport_order.present?)
	          @new_to_detail = TransportOrderItem.new(transport_order_id: @transport_order.id, fdp_id: tr_item.fdp_id, commodity_id: tr_item.commodity_id, quantity: tr_item.quantity, unit_of_measure_id: @uom.id, tariff: tariff, requisition_no: @requisition.requisition_no, created_by: user_id, transport_requisition_item_id: tr_item.id)
	          @new_to_detail.save
	          tr_item.has_transport_order = true
	          tr_item.save
	        else
	          @new_to = TransportOrder.new(order_no: SecureRandom.uuid, transporter_id: transporter_id, operation_id: @transport_requisition.operation_id, location_id: @woreda.parent.parent_node_id, order_date: Time.current, created_date: Time.current, start_date: 3.days.from_now, end_date: 13.days.from_now, printed_copies: 0, status: 0, created_by: user_id)
	          @new_to.save
	          @new_to.order_no = "TRN-ORD-" + @new_to.id.to_s 
	          @new_to.save        
	          @new_to_detail = TransportOrderItem.new(transport_order_id: @new_to.id, fdp_id: tr_item.fdp_id, commodity_id: tr_item.commodity_id, quantity: tr_item.quantity, unit_of_measure_id: @uom.id, tariff: tariff, requisition_no: @requisition.requisition_no, created_by: user_id, transport_requisition_item_id: tr_item.id)
	          @new_to_detail.save
	          tr_item.has_transport_order = true
	          tr_item.save
	        end
	      end
	    return true
  	end
	
	def self.move_transport_order(transporter_id, list_of_ids,user_id)
		@uom = UnitOfMeasure.where(:code => 'MT').first
		TransportOrderItem.includes(:transport_order).where(:id => list_of_ids).find_each do |to_item|
			 @transport_order = TransportOrder.where({:transporter_id => transporter_id, :operation_id => to_item&.transport_order&.operation_id}).where.not({status: [:closed, :canceled, :archived] }).first
	        if (@transport_order.present?)
				@transport_order_item = TransportOrderItem.where(:transport_order_id => @transport_order.id, :fdp_id => to_item.fdp_id,:commodity_id => to_item.commodity_id, :tariff => to_item.tariff,:unit_of_measure_id => to_item.unit_of_measure_id).first
				if (@transport_order_item.present?)
						@transport_order_item.quantity = @transport_order_item.quantity + to_item.quantity

						@transport_order_item.save
						to_item.destroy
				else
					@new_to_detail = TransportOrderItem.new(transport_order_id: @transport_order.id, fdp_id: to_item.fdp_id, commodity_id: to_item.commodity_id, quantity: to_item.quantity, unit_of_measure_id: @uom.id, tariff: to_item.tariff, requisition_no: to_item.requisition_no, created_by: user_id, transport_requisition_item_id: to_item.id,warehouse_id: to_item.warehouse_id)
					
	          		@new_to_detail.save
					to_item.destroy
				end
				
			else
					 @new_to = TransportOrder.new(order_no: SecureRandom.uuid, transporter_id: transporter_id, operation_id: to_item&.transport_order&.operation_id, location_id: to_item&.transport_order&.location_id, order_date: Time.current, created_date: Time.current, start_date: 3.days.from_now, end_date: 13.days.from_now, printed_copies: 0, status: 0, created_by: user_id)
					@new_to.save
					@new_to.order_no = "TRN-ORD-" + @new_to.id.to_s 
					@new_to.save        
					@new_to_detail = TransportOrderItem.new(transport_order_id: @new_to.id, fdp_id: to_item.fdp_id, commodity_id: to_item.commodity_id, quantity: to_item.quantity, unit_of_measure_id: @uom.id, tariff: to_item.tariff, requisition_no: to_item.requisition_no, created_by: user_id, transport_requisition_item_id: to_item.id)
					@new_to_detail.save
					to_item.destroy
			end
		end
		return true
	end
	

end
