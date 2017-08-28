class StockSummary < ActiveRecord::Base
	self.primary_key = "id"

	def self.total_stock
		stock = StockSummary.select('sum(quantity) as sum_quantity')
					.where(account_name: :Stock)		
	end

	def self.category_balance
		StockSummary.select('commodity_category_name, sum(quantity) as category_sum')
					.where(account_name: :Stock)
					.group(:commodity_category_name)
					.order(:commodity_category_name)
	end

	def self.commodity_balanace
		StockSummary.select('commodity_name, sum(quantity) as commodity_sum')
					.where(account_name: :Stock)
					.group(:commodity_name)
					.order(:commodity_name)
	end
end