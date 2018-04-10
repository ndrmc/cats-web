# == Schema Information
#
# Table name: psnp_plan_items
#
#  id             :integer          not null, primary key
#  psnp_plan_id   :integer
#  woreda_id      :integer
#  duration       :integer
#  starting_month :integer
#  beneficiary    :integer
#  region_id      :integer
#  zone_id        :integer
#  cash_ratio     :integer
#  kind_ratio     :integer
#  created_by     :integer
#  modified_by    :integer
#  deleted        :boolean          default(FALSE)
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class PsnpPlanItem < ApplicationRecord
  before_save :populate_region_and_ids

  belongs_to :psnp_plan

  validate :duration_ratio

  def duration_ratio
    if(self.cash_ratio_public_work!=nil || self.kind_ratio_beneficiary_public_work!=nil)
      if self.cash_ratio_public_work + self.kind_ratio_beneficiary_public_work != self.duration_public_work
        errors.add(:duration, "should be equal to the sum of cash and kind ratio for public work")
        return false
      end
    end

     if(self.cash_ratio!=nil || self.kind_ratio!=nil)
      if self.cash_ratio + self.kind_ratio != self.duration
        errors.add(:duration, "should be equal to the sum of cash and kind ratio")
        return false
      end
    end

    return true
  end


  def woreda
    if @woreda
      return @woreda
    end

    return @woreda = Location.find_by(id: self.woreda_id)
  end

  def populate_region_and_ids
    woreda_ancestor_ids = woreda.ancestor_ids

    self.region_id = woreda_ancestor_ids[0]
    self.zone_id = woreda_ancestor_ids[1]
  end


end
