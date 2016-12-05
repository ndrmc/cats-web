# == Schema Information
#
# Table name: uom_categories
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

class UomCategory < ApplicationRecord
  has_many :unit_of_measures
end
