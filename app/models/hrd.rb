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
    "#{self.season.name} #{self.year_ec} EC"
  end


end
