# == Schema Information
#
# Table name: hubs
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Hub < ApplicationRecord
  has_many :stores
  has_many :store_locations
  
end
