class PaymentRequest < ApplicationRecord
  belongs_to :transporter
  has_many :payment_request_items
  enum status: [:open, :closed]
end
