class PaymentRequest < ApplicationRecord
  belongs_to :transporter
  has_many :payment_request_items
end
