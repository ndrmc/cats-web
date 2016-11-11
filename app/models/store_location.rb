# == Schema Information
#
# Table name: store_locations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  hub_id      :integer
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StoreLocation < ApplicationRecord
end
