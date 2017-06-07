# == Schema Information
#
# Table name: commodity_sources
#
#  id          :integer          not null, primary key
#  name        :string
#  created_by  :integer
#  modified_by :integer
#  deleted     :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CommoditySource < ApplicationRecord
    validates :name, presence: {message: " is required!"}
    validates :name, uniqueness: true
end
