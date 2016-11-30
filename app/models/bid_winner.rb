# == Schema Information
#
# Table name: bid_winners
#
#  id             :integer          not null, primary key
#  bid_id         :integer
#  transporter_id :integer
#  store_id       :integer
#  destination_id :integer
#  tariff_amount  :decimal(, )
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#

class BidWinner < ApplicationRecord
  belongs_to :bid
  belongs_to :transporter

  def destiation
    Location.find_by(id: self.destination_id)
  end

  def source_warehouse
    Store.find_by(id: self.store_id)
  end

end
