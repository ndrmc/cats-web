class BidQuotationDetail < ApplicationRecord
  belongs_to :bid_quotation
  belongs_to :warehouse
  belongs_to :location
end
