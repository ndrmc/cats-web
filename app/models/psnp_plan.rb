class PsnpPlan < ApplicationRecord

  enum status: [:draft, :approved, :canceled, :published, :archived]

  belongs_to :season
  belongs_to :ration
  has_many :psnp_plan_items


  def name
    "#{self.year_ec} EC"
  end

end
