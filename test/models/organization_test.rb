# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  long_name   :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
