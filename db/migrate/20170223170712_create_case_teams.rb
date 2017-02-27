class CreateCaseTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :case_teams do |t|
      t.string :name
      t.string :discription
      

      t.integer :created_by
      t.integer :modified_by
      t.boolean :deleted, :default => false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
