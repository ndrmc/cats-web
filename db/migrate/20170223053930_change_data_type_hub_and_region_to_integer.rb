class ChangeDataTypeHubAndRegionToInteger < ActiveRecord::Migration[5.0]
def self.up
    change_table :users do |t|
      t.change :hub, :string
      t.change :region, :string
    end
  end
  def self.down
    change_table :users do |t|
      t.change :hub, :integer
      t.change :region, :integer
    end
  end
end
