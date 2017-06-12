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
  include Postable
   include Filterable

  scope :status, ->(status) { where archived:  status == 'Archived' ? true : [nil,false]}
  scope :organization_id, ->(organization_id) { where organization_id: organization_id }

  STATUSES = ["Active", "Archived"]

  validates :project_code, presence: true
  validates :commodity_id, presence: true
  validates :commodity_source_id, presence: true
  validates :organization_id, presence: true
  validates :amount, presence: true
  validates :unit_of_measure_id, presence: true
  validates :publish_date, presence: true

  belongs_to :commodity
  belongs_to :commodity_source
  belongs_to :organization
  belongs_to :unit_of_measure

  before_validation :default_project_code
  after_save :pre_post
  after_update :reverse

  def default_project_code
    if(self.project_code.nil? || self.project_code.empty?)
      donor = Organization.find(self.organization_id).name.upcase
      amount = self.amount
      month = self.publish_date.month
      year = self.publish_date.year
      self.project_code = "#{donor}/#{amount}/#{month}/#{year}"
    end
  end
end
