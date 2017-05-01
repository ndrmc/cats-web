class Permission < ApplicationRecord
    has_many :users_permissions
    has_many :users, through: :users_permissions

    has_many :department_permissions
end
