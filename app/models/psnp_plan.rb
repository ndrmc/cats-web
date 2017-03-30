class PsnpPlan < ApplicationRecord

  enum status: [:draft, :approved, :canceled, :published, :archived]

  belongs_to :season
  belongs_to :ration
  has_many :psnp_plan_items


  validate :duration_ratio

  def duration_ratio
    if self.cash_ratio + self.kind_ratio != self.duration
      errors.add(:duration, " should be equal to the sum of cash and kind ratio")
      return false
    end
  end


  def name
    "#{self.season.name} #{self.year_ec} EC"
  end

end
