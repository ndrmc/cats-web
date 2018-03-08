class PaymentRequestItem < ApplicationRecord
  belongs_to :payment_request
  belongs_to :commodity
  belongs_to :hub
  belongs_to :fdp
end
