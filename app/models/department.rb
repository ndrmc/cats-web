# == Schema Information
#
# Table name: departments
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

class Department < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: true

    has_many :users_departments
    has_many :users, through: :users_departments

    has_many :department_permissions
    has_many :permissions, through: :department_permissions

  


  
   
end
