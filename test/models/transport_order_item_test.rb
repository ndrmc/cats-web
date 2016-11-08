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

require 'test_helper'

class TransportOrderItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
