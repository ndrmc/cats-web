class RenameDonorIdToOrganizationIdOnGiftCertificate < ActiveRecord::Migration[5.0]
  def change
    rename_column :gift_certificates, :donor_id, :organization_id
  end
end
