class AlterColumnTransportersStatus < ActiveRecord::Migration[5.0]
 change_column :transporters, :status, 'boolean USING CAST(status AS boolean)'
end
