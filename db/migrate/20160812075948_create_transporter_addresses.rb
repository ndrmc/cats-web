class CreateTransporterAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :transporter_addresses do |t|
      t.integer :transporter_id
      t.integer :region_id
      t.string :city
      t.string :subcity
      t.string :kebele
      t.string :house_no
      t.string :phone
      t.string :mobile
      t.string :email
      t.timestamps
    end
  end
end
