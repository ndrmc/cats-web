class CreateHrds < ActiveRecord::Migration[5.0]
  def change
    create_table :hrds do |t|
      t.string :year, null: false
      t.integer :status, default: 0, null: false
      t.integer :month_from
      t.integer :month_to
      t.integer :duration
      t.boolean :archived
      t.boolean :current
      t.integer :season_id
      t.integer :ration_id
      t.timestamps
    end

    add_index :hrds, [:year, :season_id], :unique => true
  end
end
