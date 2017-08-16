# == Schema Information
#
# Table name: currencies
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  symbol      :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

class Currency < ApplicationRecord
  validates :name, presence: true
  validates :symbol, presence: true

  validates :name, uniqueness: true
  validates :symbol, uniqueness: true
end
