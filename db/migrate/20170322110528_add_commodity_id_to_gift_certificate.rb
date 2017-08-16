class AddCommodityIdToGiftCertificate < ActiveRecord::Migration[5.0]
  def change
    add_column :gift_certificates, :commodity_id, :integer
  end
end
