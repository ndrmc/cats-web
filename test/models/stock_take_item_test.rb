# == Schema Information
#
# Table name: stock_take_items
#
#  id                    :integer          not null, primary key
#  commodity_id          :integer          not null
#  commodity_category_id :integer          not null
#  theoretical_amount    :decimal(, )      not null
#  actual_amount         :decimal(, )      not null
#  stock_take_id         :integer          not null
#  created_by            :integer
#  modified_by           :integer
#  deleted_at            :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  donor_id              :integer          not null
#  project_id            :integer
#

require 'test_helper'

class StockTakeItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
