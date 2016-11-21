# == Schema Information
#
# Table name: hubs
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  location_id :integer
#  lat         :float
#  long        :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Hub < ApplicationRecord
  has_many :warehouses
  has_many :stores, through: :warehouses
end
