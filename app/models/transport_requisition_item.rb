# == Schema Information
#
# Table name: transport_requisition_items
#
#  id                            :integer          not null, primary key
#  transport_requisition_item_id :integer
#  requisition_no                :string
#  fdp_id                        :integer
#  commodity_id                  :integer
#  quantity                      :decimal(, )
#  has_transport_order           :boolean
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#

class TransportRequisitionItem < ApplicationRecord
  belongs_to :transport_requisition

  def fdp
    Fdp.find_by(id: self.fdp_id)
  end

  def commodity
    Commodity.find_by(id: self.commodity_id)
  end

  def requistions
    # Get all requisition_no for all items and fetch list of requistion recrods
  end

end
