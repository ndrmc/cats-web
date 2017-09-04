# == Schema Information
#
# Table name: adjustments
#
#  id                    :integer          not null, primary key
#  stock_take_id         :integer          not null
#  stock_take_item_id    :integer          not null
#  commodity_id          :integer          not null
#  commodity_category_id :integer          not null
#  amount                :decimal(, )      not null
#  adjustment_type       :integer          not null
#  reason                :string
#  created_by            :integer
#  modified_by           :integer
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

require 'test_helper'

class AdjustmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
