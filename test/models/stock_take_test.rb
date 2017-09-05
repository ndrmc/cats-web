# == Schema Information
#
# Table name: stock_takes
#
#  id            :integer          not null, primary key
#  hub_id        :integer          not null
#  warehouse_id  :integer          not null
#  store_no      :integer
#  date          :date             not null
#  fiscal_period :integer
#  created_by    :integer
#  modified_by   :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  draft         :boolean          default(TRUE)
#  title         :string           not null
#

require 'test_helper'

class StockTakeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
