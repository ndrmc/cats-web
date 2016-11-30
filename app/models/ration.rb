# == Schema Information
#
# Table name: rations
#
#  id           :integer          not null, primary key
#  reference_no :string           not null
#  description  :string
#  current      :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  created_by   :integer
#  modified_by  :integer
#  deleted_at   :datetime
#

class Ration < ApplicationRecord
  validates :reference_no , presence: true

  has_many :ration_items

  def total_amount(beneficiaries)
    # TODO: Iterate over ration_items collection and calculate total amount based on
    # beneficiaries parameter. Return key-value pair containing commodity and value
  end
end
