class CreatePrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :programs do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.timestamps
    end

    add_index :programs, :code, :unique => true
  end
end
