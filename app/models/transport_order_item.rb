# == Schema Information
#
# Table name: transport_order_items
#
#  id                 :integer          not null, primary key
#  transport_order_id :integer
#  fdp_id             :integer
#  store_id           :integer
#  commodity_id       :integer
#  quantity           :decimal(, )
#  unit_of_measure_id :integer
#  tariff             :decimal(, )
#  requisition_no     :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  created_by         :integer
#  modified_by        :integer
#  deleted_at         :datetime
#

class TransportOrderItem < ApplicationRecord
  belongs_to :transport_order
  belongs_to :fdp
  belongs_to :store
  belongs_to :commodity
  belongs_to :unit_of_measure
  belongs_to :transport_requisition_item
  
end
