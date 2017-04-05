class UsersDepartment < ApplicationRecord
  belongs_to :user
  belongs_to :department
end
