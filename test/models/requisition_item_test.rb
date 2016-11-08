# == Schema Information
#
# Table name: requisition_items
#
#  id                 :integer          not null, primary key
#  requisition_id     :integer
#  commodity_id       :integer
#  unit_of_measure_id :integer
#  fdp_id             :integer
#  beneficiary_no     :integer          not null
#  amount             :decimal(, )      not null
#  contingency        :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class RequisitionItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
