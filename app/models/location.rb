# == Schema Information
#
# Table name: locations
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  code           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ancestry       :string
#  location_type  :integer
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#  parent_node_id :integer
#

class Location < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true

  enum location_type: {
    region: 1,
    zone: 2,
    woreda: 3,
    kebele: 4
  }

  has_ancestry 

  has_many :fdps
  has_many :users
end
