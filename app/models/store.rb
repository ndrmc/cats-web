# == Schema Information
#
# Table name: stores
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  temporary         :boolean
#  hub_id            :integer
#  store_owner_id    :integer
#  store_location_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Store < ApplicationRecord

  belongs_to :store_owner

end
