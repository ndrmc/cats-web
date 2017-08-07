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

  after_save :pre_post
  after_update :reverse


end
