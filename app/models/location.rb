# == Schema Information
#
# Table name: locations
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  code             :string
#  location_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ancestry         :string
#

class Location < ApplicationRecord
  has_ancestry
  belongs_to :location_type
  has_many :fdps
  
end
