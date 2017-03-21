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

  scope :gin_number, ->(gin_number) { where gin_number: gin_number }
  scope :fdp_id, ->(fdp_id) { where fdp_id: fdp_id }
  scope :operation_id, ->(operation_id) { where operation_id: operation_id }
  scope :region_id, ->(region_id) {where Location.find(region_id).children.exists?(self)}

  has_many :delivery_details
  accepts_nested_attributes_for :delivery_details, reject_if: :all_blank

  validates :receiving_number, uniqueness: true
  validates :gin_number, uniqueness: true

  after_save :pre_post

  after_update :reverse

end
