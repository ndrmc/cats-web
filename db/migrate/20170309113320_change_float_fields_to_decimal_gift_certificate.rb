class ChangeFloatFieldsToDecimalGiftCertificate < ActiveRecord::Migration[5.0]
  def change

    remove_column :gift_certificates , :amount
    remove_column :gift_certificates , :estimated_price
    remove_column :gift_certificates , :estimated_tax

   
    add_column :gift_certificates , :amount , :decimal , precision: 15, scale: 2
    add_column :gift_certificates , :estimated_price , :decimal , precision: 15, scale: 2
    add_column :gift_certificates , :estimated_tax ,  :decimal , precision: 15, scale: 2

  end
end
