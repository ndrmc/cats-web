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
  enum commodity_source: { Donation:0, Loan:2, Purchase:3, Return:4, Transfer:5, Others:7, Repayment:8, Swap:9  }

  validates :project_code, presence: true
  validates :commodity_id, presence: true
  validates :commodity_source, presence: true
  validates :organization_id, presence: true
  #validates :amount, presence: true
  validates :unit_of_measure_id, presence: true
  #validates :publish_date, presence: true

end
