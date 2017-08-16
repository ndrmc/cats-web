# == Schema Information
#
# Table name: fund_types
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

require 'test_helper'

class FundTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
