# == Schema Information
#
# Table name: stock_summaries
#
#  id                      :integer          primary key
#  journal_id              :integer
#  journal_name            :string
#  account_id              :integer
#  account_name            :string
#  hub_id                  :integer
#  hub_name                :string
#  warehouse_id            :integer
#  warehouse_name          :string
#  program_id              :integer
#  program_name            :string
#  commodity_id            :integer
#  commodity_name          :string
#  commodity_category_id   :integer
#  commodity_category_name :string
#  quantity                :decimal(, )
#

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
