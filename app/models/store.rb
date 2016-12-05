# == Schema Information
#
# Table name: stores
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  temporary    :boolean
#  warehouse_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  created_by   :integer
#  modified_by  :integer
#  deleted_at   :datetime
#

class Store < ApplicationRecord

  belongs_to :store_owner
  belongs_to :warehouse

end
