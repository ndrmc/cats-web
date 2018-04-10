class AddPaymentDateToPaymentRequeste < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_requests, :payment_date, :datetime
  end
end
