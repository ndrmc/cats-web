# == Schema Information
#
# Table name: bid_submissions
#
#  id              :integer          not null, primary key
#  bid_id          :integer
#  transporter_id  :integer
#  bid_bond_amount :decimal(, )
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class BidSubmission < ApplicationRecord
  belongs_to :bid
  belongs_to :transporter
  has_many :quotations
  
end
