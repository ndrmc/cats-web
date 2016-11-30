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
#  created_by        :integer
#  modified_by       :integer
#  deleted_at        :datetime
#

class Store < ApplicationRecord

  belongs_to :store_owner
  belongs_to :warehouse

end
