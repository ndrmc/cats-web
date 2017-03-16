class RenameBillOfLoadingInGiftCertificate < ActiveRecord::Migration[5.0]
  def change
    remove_column :gift_certificates , :bill_of_ladding 
  	add_column :gift_certificates, :bill_of_loading, :string
  end
end
