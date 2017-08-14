class AddRankToBidQuotationDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :bid_quotation_details, :rank, :integer
  end
end
