# == Schema Information
#
# Table name: transport_requisitions
#
#  id           :integer          not null, primary key
#  region_id    :integer
#  operation_id :integer
#  created_date :date
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  created_by   :integer
#  modified_by  :integer
#  deleted_at   :datetime
#

class TransportRequisition < ApplicationRecord
  has_many :transport_requisition_items
  belongs_to :operation

  def region
    Location.find_by(id: self.region_id)
  end
  
end
