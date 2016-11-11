class CreateContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :contracts do |t|
      t.string :contract_no, null: false
      t.integer :transport_id
      t.text :description
      t.timestamps
    end
  end
end
