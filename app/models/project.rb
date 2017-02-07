# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  created_by  :integer
#  modified_by :integer
#  deleted     :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Project < ApplicationRecord
  enum commodity_source: { Donation:0, Purchase:1, Loan:2 }

  validates :project_code, presence: true
  validates :commodity_id, presence: true
  validates :commodity_source, presence: true
  validates :organization_id, presence: true
  validates :amount, presence: true
  validates :unit_of_measure_id, presence: true
  validates :publish_date, presence: true

end
