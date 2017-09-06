# == Schema Information
#
# Table name: warehouses
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  description     :string
#  hub_id          :integer
#  location_id     :integer
#  organization_id :integer
#  lat             :decimal(15, 13)
#  lon             :decimal(15, 13)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by      :integer
#  modified_by     :integer
#  deleted_at      :datetime
#  address         :string
#

class Warehouse < ApplicationRecord
    belongs_to :hub
    has_many :stores
    belongs_to :organization


    reverse_geocoded_by :lat , :lon
    after_validation :reverse_geocode

    validates :name, presence: true
   

    validates :name, uniqueness: {scope: :hub_id}
end

