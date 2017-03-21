class AddHrdIdToContributions < ActiveRecord::Migration[5.0]
  def change
    add_reference :contributions, :hrd, foreign_key: true
  end
end
