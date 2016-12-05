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
#  region_id                :integer
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

require 'test_helper'

class TransportOrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
