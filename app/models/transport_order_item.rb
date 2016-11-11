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
#

class TransportOrderItem < ApplicationRecord
  belongs_to :transport_order

  def fdp
    Fdp.find_by(id: self.fdp_id)
  end

  def store
    Store.find_by(id: self.store_id)
  end

  def commodity
    Commodity.find_by(id: self.commodity_id)
  end

  def unit_of_measure
    UnitOfMeasure.find_by(id: self.unit_of_measure_id)
  end

  
end
