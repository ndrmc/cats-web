# == Schema Information
#
# Table name: contributions
#
#  id                :integer          not null, primary key
#  donor_id          :integer
#  contribution_type :integer
#  amount            :decimal(, )
#  created_by        :integer
#  modified_by       :integer
#  deleted           :boolean          default(FALSE)
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class ContributionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
