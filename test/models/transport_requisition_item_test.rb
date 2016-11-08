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

require 'test_helper'

class TransportRequisitionItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
