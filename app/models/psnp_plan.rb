# == Schema Information
#
# Table name: psnp_plans
#
#  id          :integer          not null, primary key
#  year_gc     :integer          not null
#  year_ec     :integer
#  status      :integer          default("draft"), not null
#  month_from  :integer
#  duration    :integer
#  ration_id   :integer
#  created_by  :integer
#  modified_by :integer
#  deleted     :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PsnpPlan < ApplicationRecord

  enum status: [:draft, :approved, :canceled, :published, :archived]

  belongs_to :season
  belongs_to :ration
  has_many :psnp_plan_items


  def name
    name = ""
    if self.year_ec
      name = name + "#{self.year_ec} EC / "
    end
    if self.year_gc
      name = name + "#{self.year_gc} GC"
    end
  end

def total_beneficiaries
  self.psnp_plan_items.sum(:beneficiary) + self.psnp_plan_items.sum(:beneficiary_public_work)
end

def self.current_plan
  PsnpPlan.where(status: :published).last
end

end
