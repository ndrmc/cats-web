# == Schema Information
#
# Table name: hrds
#
#  id          :integer          not null, primary key
#  year_gc     :integer          not null
#  status      :integer          default("draft"), not null
#  month_from  :integer
#  duration    :integer
#  season_id   :integer
#  ration_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#  year_ec     :integer
#

class Hrd < ApplicationRecord
  
  enum status: [:draft, :approved, :canceled, :published, :archived]

  belongs_to :season
  belongs_to :ration
  has_many :hrd_items

  def name
    name = "#{self.season.name} - "
    if self.year_ec
      name = name + "#{self.year_ec} EC / "
    end
    if self.year_gc
      name = name + "#{self.year_gc} GC"
    end
  end

  validates :year_ec, :year_gc, :season_id, :ration_id, :duration, :month_from, :presence => true

 def allocated_woredas_in_hrd
    Hrd.find_by_sql("select count(distinct hd.woreda_id) as allocated_woredas from hrds  h inner join hrd_items hd on h.id = hd.hrd_id
                  where hd.beneficiary > 0 and h.id = '#{self.id}'").first.try(:allocated_woredas)
 end

def all_woredas_in_hrd
  Hrd.find_by_sql("select count(distinct hd.woreda_id) as all_woredas from hrds  h inner join hrd_items hd on h.id = hd.hrd_id
                  where h.id = '#{self.id}'").first.try(:all_woredas)
end

def total_beneficiaries
  self.hrd_items.sum(:beneficiary)
end

def self.current_hrd
  Hrd.where(status: :published).last
end

end
