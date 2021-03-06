# == Schema Information
#
# Table name: stores
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  temporary         :boolean
#  warehouse_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by        :integer
#  modified_by       :integer
#  deleted_at        :datetime
#  store_keeper_name :string
#

class Store < ApplicationRecord

  belongs_to :store_owner
  belongs_to :warehouse

  validates :name, presence: true
  validates :warehouse_id,  presence:true

  validates :name, uniqueness: {scope: :warehouse_id }

end
