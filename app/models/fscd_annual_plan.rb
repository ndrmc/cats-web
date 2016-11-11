# == Schema Information
#
# Table name: fscd_annual_plans
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  code       :string
#  year       :string
#  duration   :integer
#  status     :integer          default("draft"), not null
#  archive    :boolean
#  ration_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FscdAnnualPlan < ApplicationRecord
  enum status: [:draft, :approved, :canceled, :closed, :archived]
  has_many :fscd_plan_items

end
