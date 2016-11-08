class CreateSeasons < ActiveRecord::Migration[5.0]
  def change
    create_table :seasons do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end

    add_index :seasons, :name, :unique => true
  end
end
