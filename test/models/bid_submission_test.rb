# == Schema Information
#
# Table name: bid_submissions
#
#  id              :integer          not null, primary key
#  bid_id          :integer
#  transporter_id  :integer
#  bid_bond_amount :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class BidSubmissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
