# == Schema Information
#
# Table name: requisitions
#
#  id             :integer          not null, primary key
#  requisition_no :string           not null
#  operation_id   :integer
#  commodity_id   :integer
#  region_id      :integer
#  zone_id        :integer
#  ration_id      :integer
#  requested_by   :string
#  requested_on   :date
#  status         :integer          default("draft"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#  request_id     :integer          not null
#

class Requisition < ApplicationRecord
   include Filterable
   include OperationLoggable
 
  scope :operation, ->(operation) { where operation_id: operation }
  scope :status, ->(status) { where status: status }  
  scope :region, ->(region) {where region_id: region}
  
  enum status: [:draft, :approved, :ongoing, :completed, :archived]
  belongs_to :operation
  has_many :requisition_items

  after_save :create_log_callback

  def region
    Location.find_by id: self.region_id
  end

  def zone
    Location.find_by id: self.zone_id
  end

  def ration
    Ration.find_by id: self.ration_id
  end

  def commodity
    Commodity.find_by(id: self.commodity_id)
  end

  def fdps
    Fdp.where(location_id: zone.descendant_ids)
  end
end
