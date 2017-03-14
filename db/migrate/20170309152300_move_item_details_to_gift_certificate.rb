class MoveItemDetailsToGiftCertificate < ActiveRecord::Migration[5.0]
  def change

    drop_table :gift_certificate_items
   
    add_column :gift_certificates , :fund_source_id , :integer 
    add_column :gift_certificates , :currency_id , :integer 
   

  end
end