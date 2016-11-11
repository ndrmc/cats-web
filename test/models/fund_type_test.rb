# == Schema Information
#
# Table name: fund_types
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class FundTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
