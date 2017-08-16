# == Schema Information
#
# Table name: deliveries
#
#  id                 :integer          not null, primary key
#  receiving_number   :string           not null
#  transporter_id     :integer          not null
#  fdp_id             :integer          not null
#  gin_number         :integer          not null
#  requisition_number :string           not null
#  received_by        :string           not null
#  received_date      :date             not null
#  status             :integer
#  operation_id       :integer
#  remark             :text
#  created_by         :integer
#  modified_by        :integer
#  deleted            :boolean          default(FALSE)
#  deleted_at         :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Delivery < ApplicationRecord
include Filterable
  include Postable
  include OperationLoggable

  
  #scope :fdp_id, ->(fdp_id) { where fdp_id: fdp_id }
  scope :operation_id, ->(operation_id) { where operation_id: operation_id }
  scope :woreda, ->(woreda) {where fdp_id: Fdp.find_by_location_id(woreda)? Fdp.find_by_location_id(woreda).id : nil}
  
  has_many :delivery_details
  belongs_to :fdp
  accepts_nested_attributes_for :delivery_details, reject_if: :all_blank

  validates :receiving_number, uniqueness: true
  #validates :gin_number, uniqueness: true

  after_save :pre_post

  after_update :reverse

end
