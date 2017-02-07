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
