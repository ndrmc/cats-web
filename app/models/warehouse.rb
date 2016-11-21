# == Schema Information
#
# Table name: warehouses
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  hub_id      :integer
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Warehouse < ApplicationRecord
    belongs_to :hub
    has_many :stores
end
