# == Schema Information
#
# Table name: bids
#
#  id                 :integer          not null, primary key
#  bid_no             :string           not null
#  start_date         :date
#  end_date           :date
#  description        :text
#  opening_date       :date
#  status             :integer          default("open"), not null
#  bid_plan_id        :integer
#  region_id          :integer
#  document_price     :decimal(, )
#  cpo_deposit_amount :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class BidTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
