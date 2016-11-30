# == Schema Information
#
# Table name: fscd_plan_items
#
#  id                  :integer          not null, primary key
#  beneficiary_no      :integer          not null
#  fscd_annual_plan_id :integer
#  woreda_id           :integer          not null
#  starting_month      :integer
#  food_ratio          :integer
#  cash_ratio          :integer
#  contingency         :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  created_by          :integer
#  modified_by         :integer
#  deleted_at          :datetime
#

class FscdPlanItem < ApplicationRecord
  belongs_to :fscd_annual_plan
end
