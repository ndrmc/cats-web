class CreateControllers < ActiveRecord::Migration[5.0]
  def change
    create_table :controllers do |t|
      t.string :Organization
      t.string :name
      t.string :long_name
      t.string :description

      t.timestamps
    end
  end
end
