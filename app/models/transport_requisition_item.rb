# == Schema Information
#
# Table name: transport_requisition_items
#
#  id                            :integer          not null, primary key
#  transport_requisition_item_id :integer
#  requisition_id                :string
#  fdp_id                        :integer
#  commodity_id                  :integer
#  quantity                      :decimal(, )
#  has_transport_order           :boolean
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  created_by                    :integer
#  modified_by                   :integer
#  deleted_at                    :datetime
#

class TransportRequisitionItem < ApplicationRecord
  belongs_to :transport_requisition
  belongs_to :fdp  
  belongs_to :commodity
  belongs_to :requisition

end
