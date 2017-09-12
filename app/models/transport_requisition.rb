# == Schema Information
#
# Table name: transport_requisitions
#
#  id           :integer          not null, primary key
#  region_id    :integer
#  operation_id :integer
#  created_date :date
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  created_by   :integer
#  modified_by  :integer
#  deleted_at   :datetime
#

class TransportRequisition < ApplicationRecord
  enum status: [:open, :closed]
  has_many :transport_requisition_items
  belongs_to :operation
  belongs_to :location
  belongs_to :created_by, :class_name => 'User', :foreign_key => 'created_by_id'
  belongs_to :certified_by, :class_name => 'User', :foreign_key => 'certified_by_id'
  has_many :transport_order_items

  def self.generate_tr (transport_requisition_params, current_user_id)
    
    @requisitions = Requisition.includes(:requisition_items).where({:operation_id =>transport_requisition_params[:operation_id], :region_id => transport_requisition_params[:location_id], :status => :approved})
      if @requisitions.count > 0
        transport_requisition_params.delete("bid_id")
        transport_requisition_params["created_by_id"] = current_user_id
        transport_requisition_params["certified_by_id"] = current_user_id
        @transport_requisition = TransportRequisition.new(transport_requisition_params)
        @transport_requisition.save
        @program = Program.find(Operation.find(@transport_requisition.operation_id).program_id)
        @transport_requisition.reference_number = @program.code.to_s + '/' + @transport_requisition.location_id.to_s + '/' + @transport_requisition.id.to_s + '/' + Time.now.year.to_s
        @transport_requisition.status = :open
        @transport_requisition.save
        @requisitions.find_each do |requisition|
          requisition.requisition_items
        .find_each do |ri|
          if ri.unit_of_measure_id.present?
            @ri_qunatity = UnitOfMeasure.find(ri.unit_of_measure_id).to_ref(ri.amount)
          else
            @ri_qunatity = UnitOfMeasure.where(code: 'QTL').first.to_ref(ri.amount)
          end
            TransportRequisitionItem.new( transport_requisition_id: @transport_requisition.id, requisition_id: requisition.id, fdp_id: ri.fdp_id, commodity_id: requisition.commodity_id, quantity: @ri_qunatity, has_transport_order: false, created_by: current_user_id).save

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
