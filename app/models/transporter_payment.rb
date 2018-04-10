class TransporterPayment < ApplicationRecord
  belongs_to :payment_request
  enum status: [:open, :approved,:paid,:closed]
end
