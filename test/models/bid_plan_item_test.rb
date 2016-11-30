# == Schema Information
#
# Table name: bid_plan_items
#
#  id                 :integer          not null, primary key
#  bid_plan_id        :integer
#  woreda_id          :integer
#  store_id           :integer
#  quantity           :decimal(, )
#  unit_of_measure_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  created_by         :integer
#  modified_by        :integer
#  deleted_at         :datetime
#

require 'test_helper'

class BidPlanItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
