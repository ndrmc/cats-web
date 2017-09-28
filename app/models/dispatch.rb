# == Schema Information
#
# Table name: dispatches
#
#  id                          :integer          not null, primary key
#  gin_no                      :string           not null
#  operation_id                :integer
#  requisition_number          :string
#  dispatch_date               :datetime
#  fdp_id                      :integer
#  weight_bridge_ticket_number :string
#  transporter_id              :integer
#  plate_number                :string
#  trailer_plate_number        :string
#  drivers_name                :string
#  remark                      :text
#  draft                       :boolean          default(FALSE)
#  created_by                  :integer
#  modified_by                 :integer
#  deleted                     :boolean          default(FALSE)
#  deleted_at                  :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  hub_id                      :integer
#  warehouse_id                :integer
#  storekeeper_name            :string(200)      not null
#  dispatch_id_guid            :string
#  dispatched_date_ec          :string
#

class Dispatch < ApplicationRecord
    include Postable

    acts_as_paranoid 

    belongs_to :fdp 
    belongs_to :hub 
    belongs_to :warehouse 
    belongs_to :transporter
    
    has_many :dispatch_items

    after_save :pre_post

    after_update :reverse

    def self.fdp_allocations (hub_id, operation_id, allocation_filter, fdp_ids)
        @dispatch_summary = []
        Requisition.joins(:requisition_items, :commodity).where( allocation_filter ).where(' requisition_items.amount > 0').uniq{|t| t.requisition_no }.each do |allocation|
            @row = Hash.new
            @row['requisition_no'] = allocation.requisition_no
            @row['commodity'] = allocation.commodity.name
            @total_allocated = 0
            allocation.requisition_items.where(:fdp_id => fdp_ids).each do |ri|
                uom_id = allocation&.operation&.ration&.ration_items.where(commodity_id: allocation.commodity_id)&.first&.unit_of_measure_id
                if(uom_id.present?)
                    @total_allocated = @total_allocated + UnitOfMeasure.find(uom_id).to_ref(ri.amount)
                else
                    @total_allocated = @total_allocated + ri.amount
                end
            end
            @row['allocated'] = @total_allocated
            # dispatch_filter[:requisition_number] = allocation.requisition_no
            @total_dispatched = 0
            Dispatch.joins(:dispatch_items).where( {:'dispatches.hub_id' => hub_id, :'dispatches.operation_id' => operation_id, :'dispatches.fdp_id' => fdp_ids, :'dispatches.requisition_number' => allocation.requisition_no } ).select(:id, :'dispatch_items.quantity', :'dispatch_items.unit_of_measure_id').find_each do |di|                    
                @qty_in_ref = UnitOfMeasure.find(di.unit_of_measure_id).to_ref(di.quantity)
                @total_dispatched = @total_dispatched + @qty_in_ref
            end
            @row['dispatched'] = @total_dispatched
            @row['progress'] = (@total_dispatched.to_f / @total_allocated.to_f) * 100
            @dispatch_summary << @row
        end
        return @dispatch_summary
    end

    def self.fdp_dispatches (dispatch_filter)
        @dispatches = []
        Dispatch.joins( :transporter, dispatch_items: [:unit_of_measure, :commodity] ).where( dispatch_filter ).find_each do |dispatch|
            @gin_row = Hash.new
            @gin_row['gin_no'] = dispatch.gin_no
            @gin_qty = 0
            dispatch.dispatch_items.find_each do |di|
                @qty_in_ref = UnitOfMeasure.find(di.unit_of_measure_id).to_ref(di.quantity)
                @gin_qty = @gin_qty + @qty_in_ref
                @gin_row['commodity'] = di.commodity.name
            end
            @gin_row['dispatch_qty'] = @gin_qty
            @gin_row['uom'] = 'MT'
            @gin_row['transporter'] = dispatch.transporter.name
            @gin_row['dispatch_date'] = dispatch.dispatch_date
            @dispatches << @gin_row
        end
        return @dispatches
    end
end
