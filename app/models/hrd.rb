# == Schema Information
#
# Table name: hrds
#
#  id          :integer          not null, primary key
#  year        :string           not null
#  status      :integer          default("draft"), not null
#  month_from  :integer
#  month_to    :integer
#  duration    :integer
#  archived    :boolean
#  current     :boolean
#  season_id   :integer
#  ration_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

class Hrd < ApplicationRecord
  enum status: [:draft, :approved, :canceled, :published, :archived]
  belongs_to :season
  belongs_to :ration
  has_many :hrd_items

end
