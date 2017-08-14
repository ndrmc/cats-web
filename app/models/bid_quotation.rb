class BidQuotation < ApplicationRecord
  belongs_to :bid
  belongs_to :transporter
end
