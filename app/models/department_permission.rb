class DepartmentPermission < ApplicationRecord
    belongs_to :permission
    belongs_to :department
end
