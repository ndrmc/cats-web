class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name, null:false
      t.string :long_name
      t.string :description
      t.timestamps
    end
  end
end
