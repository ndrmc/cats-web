# == Schema Information
#
# Table name: commodities
#
#  id                    :integer          not null, primary key
#  name                  :string           not null
#  name_am               :string
#  long_name             :string
#  code                  :string           not null
#  code_am               :string
#  description           :text
#  hazardous             :boolean
#  cold_storage          :boolean
#  min_temperature       :float
#  max_temperature       :float
#  commodity_category_id :integer
#  uom_category_id       :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  created_by            :integer
#  modified_by           :integer
#  deleted_at            :datetime
#

class Commodity < ApplicationRecord
  belongs_to :commodity_category
  belongs_to :uom_category

  validates :name , presence: true
end
