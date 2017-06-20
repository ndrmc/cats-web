require 'test_helper'

class StockStatusControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_status_index_url
    assert_response :success
  end

end
