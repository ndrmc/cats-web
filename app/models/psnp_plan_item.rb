class PsnpPlanItem < ApplicationRecord
  before_save :populate_region_and_ids

  belongs_to :psnp_plan

  #validate :duration_ratio

  def duration_ratio
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
