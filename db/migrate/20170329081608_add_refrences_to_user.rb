class AddRefrencesToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :location, index: true
    add_reference :users, :hub,      index: true
    add_reference :users, :department, index: true
  end
end
