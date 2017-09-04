# == Schema Information
#
# Table name: users_departments
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  department_id :integer
#  created_by    :integer
#  modified_by   :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class UsersDepartmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
