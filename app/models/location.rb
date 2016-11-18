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

  validates :name, presence: true

  enum location_type: {
    region: 1,
    zone: 2,
    woreda: 3,
    kebele: 4
  }

  has_ancestry

  has_many :fdps
  
end
