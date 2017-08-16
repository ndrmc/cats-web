class BidQuotation < ApplicationRecord
  belongs_to :bid
  belongs_to :transporter

  has_many :bid_quotation_detail
end
