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

class Permission < ApplicationRecord
    has_many :users_permissions
    has_many :users, through: :users_permissions

    has_many :department_permissions

    validates :name, presence: true
    validates :name, uniqueness: true
end
