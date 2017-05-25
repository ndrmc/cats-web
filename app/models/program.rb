# == Schema Information
#
# Table name: programs
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  code        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

class Program < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: true
    
     validates :code , presence: true
     validates :code, uniqueness: true 
    
    
end
