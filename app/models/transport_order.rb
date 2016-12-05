# == Schema Information
#
# Table name: transport_orders
#
#  id                       :integer          not null, primary key
#  order_no                 :string
#  transporter_id           :integer
#  contract_id              :integer
#  bid_id                   :integer
#  operation_id             :integer
#  region_id                :integer
#  order_date               :date
#  created_date             :date
#  start_date               :date
#  end_date                 :date
#  performance_bond_receipt :string
#  performance_bond_amount  :decimal(, )
#  printed_copies           :integer          default(0), not null
#  status                   :integer          default("draft"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  created_by               :integer
#  modified_by              :integer
#  deleted_at               :datetime
#

class TransportOrder < ApplicationRecord
  enum status: [:draft, :approved, :ongoing, :closed, :canceled, :archived]
  belongs_to :operation
  belongs_to :transporter
  belongs_to :contract

  def bid
    Bid.find_by(id: self.bid_id)
  end

  def region
    Location.find_by(id: self.region_id)
  end

  def requisitions
    # get list of requistions within all TO items.
  end
end
