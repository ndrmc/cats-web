# == Schema Information
#
# Table name: bid_plans
#
#  id          :integer          not null, primary key
#  year        :string           not null
#  half_year   :integer
#  program_id  :integer
#  code        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class BidPlanTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
