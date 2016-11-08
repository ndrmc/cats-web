class CreateDonors < ActiveRecord::Migration[5.0]
  def change
    create_table :donors do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.boolean :responsible
      t.boolean :source
      t.text :description

      t.timestamps
    end

    add_index :donors, :code, :unique => true
  end
end
