# == Schema Information
#
# Table name: commodity_categories
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  code            :string           not null
#  code_am         :string
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ancestry        :string
#  created_by      :integer
#  modified_by     :integer
#  deleted_at      :datetime
#  uom_category_id :integer
#

class CommodityCategory < ApplicationRecord
  has_ancestry

  belongs_to :uom_category 

  has_many :commodities
  validates :name, presence: true
  validates :code, presence: true
end
