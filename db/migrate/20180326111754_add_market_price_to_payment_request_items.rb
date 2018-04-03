class AddMarketPriceToPaymentRequestItems < ActiveRecord::Migration[5.0]
  def change
    add_column :payment_request_items, :market_price, :decimal
  end
end
