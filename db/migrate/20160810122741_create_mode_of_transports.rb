class CreateModeOfTransports < ActiveRecord::Migration[5.0]
  def change
    create_table :mode_of_transports do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end

    add_index :mode_of_transports, :name, :unique => true
  end
end
