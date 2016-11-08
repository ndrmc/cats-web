class CreateFdpContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :fdp_contacts do |t|
      t.string :full_name, null: false
      t.string :mobile
      t.string :email
      t.integer :fdp_id
      t.timestamps
    end    
  end
end
