# == Schema Information
#
# Table name: projects
#
#  id                 :integer          not null, primary key
#  project_code       :string
#  commodity_id       :integer
#  commodity_source   :integer
#  organization_id    :integer
#  amount             :decimal(, )
#  unit_of_measure_id :integer
#  publish_date       :date
#  created_by         :integer
#  modified_by        :integer
#  deleted_at         :datetime
#  created_at         :datetime
#  updated_at         :datetime
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
