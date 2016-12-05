# == Schema Information
#
# Table name: commodity_categories
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  code        :string           not null
#  code_am     :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ancestry    :string
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

class CommodityCategory < ApplicationRecord
  has_ancestry
  has_many :commodities
  validates :name, presence: true
  validates :code, presence: true
end
