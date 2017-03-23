class Department < ApplicationRecord
    validates_uniqueness_of :name
    has_many :users_departments
    has_many :users, through: :users_departments
     
end
