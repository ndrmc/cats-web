class AddGeneratedFlagToRequest < ActiveRecord::Migration[5.0]
  def change
  	add_column :regional_requests, :generated, :boolean, defult: false
	
  end
end
