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

class UsersDepartment < ApplicationRecord
  belongs_to :user
  belongs_to :department
end
