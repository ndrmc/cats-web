# == Schema Information
#
# Table name: bids
#
#  id                  :integer          not null, primary key
#  framework_tender_id :integer
#  region_id           :integer
#  bid_number          :string
#  bid_bond_amount     :decimal(15, 3)
#  start_date          :date
#  closing_date        :date
#  opening_date        :date
#  status              :integer
#  remark              :text
#  created_by          :integer
#  modified_by         :integer
#  deleted_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class BidTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
