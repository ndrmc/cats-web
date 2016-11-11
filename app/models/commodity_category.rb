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
#

class CommodityCategory < ApplicationRecord
  has_ancestry
  has_many :commodities
end
