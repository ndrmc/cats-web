# == Schema Information
#
# Table name: bid_winners
#
#  id             :integer          not null, primary key
#  bid_id         :integer
#  transporter_id :integer
#  store_id       :integer
#  destination_id :integer
#  tariff_amount  :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#

require 'test_helper'

class BidWinnerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
