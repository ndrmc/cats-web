# == Schema Information
#
# Table name: department_permissions
#
#  id            :integer          not null, primary key
#  department_id :integer
#  permission_id :integer
#  created_by    :integer
#  modified_by   :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class DepartmentPermission < ApplicationRecord
    belongs_to :permission
    belongs_to :department
end
