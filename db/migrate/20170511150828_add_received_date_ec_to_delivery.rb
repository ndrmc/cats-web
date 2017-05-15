class AddReceivedDateEcToDelivery < ActiveRecord::Migration[5.0]
  def change
     add_column :deliveries, :received_date_ec, :string
  end
end
