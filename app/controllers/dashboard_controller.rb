class DashboardController < ApplicationController
  def index
  	@hrd = Hrd.current_hrd
  	@total_stock = StockSummary.total_stock[0].sum_quantity
  	@category_balance = StockSummary.category_balance	
  end
end
