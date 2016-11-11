# == Schema Information
#
# Table name: location_types
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LocationType < ApplicationRecord
  has_many :locations
end
