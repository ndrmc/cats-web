# == Schema Information
#
# Table name: permissions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class PermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
