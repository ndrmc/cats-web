# == Schema Information
#
# Table name: ration_items
#
#  id                 :integer          not null, primary key
#  amount             :decimal(, )      not null
#  ration_id          :integer
#  unit_of_measure_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  commodity_id       :integer
#  created_by         :integer
#  modified_by        :integer
#  deleted_at         :datetime
#

class RationItem < ApplicationRecord

  validates :amount, presence: true , :numericality => true
  validates :commodity, :unit_of_measure, :ration, presence: true

  belongs_to :ration
  belongs_to :unit_of_measure
  belongs_to :commodity

  def total_amount(beneficiaries)
    return self.amount * beneficiaries
  end

end
