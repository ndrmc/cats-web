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

end
