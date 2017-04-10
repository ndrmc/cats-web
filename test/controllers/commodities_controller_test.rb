require 'test_helper'

class CommoditiesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @commodity = commodities(:commodity_1)
  end

  test "should get index" do
    get commodities_url
    assert_response :success
  end

  test "should get new" do
    get new_commodity_url
    assert_response :success
  end

  test "should create commodity" do
    assert_difference('Commodity.count') do
      post commodities_url, params: { commodity: { name: 'Test', code: 'TST', description: 'This is test data' } }
    end

    assert_redirected_to commodity_url(Commodity.last)
  end

  test "should show commodity" do
    get commodity_url('en',@commodity)
    assert_response :success
  end


  test "should get edit" do
    get edit_commodity_url('en',@commodity)
    assert_response :success
  end


  test "should update commodity" do
    patch commodity_url('en', @commodity), params: { commodity: { name: 'Updated Name' } }
    assert_redirected_to commodities_url

  end

  test "should destroy commodity" do
    assert_difference('Commodity.count', -1) do
      delete commodity_url('en', @commodity)
    end

    assert_redirected_to commodities_url
  end

end
