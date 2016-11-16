require 'test_helper'

class CommoditiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commodity = commodities(:one)
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
      post commodities_url, params: { commodity: { : @commodity., code: @commodity.code, code_am: @commodity.code_am, cold_storage: @commodity.cold_storage, commodity_category: @commodity.commodity_category, description: @commodity.description, hazardous: @commodity.hazardous, long_name: @commodity.long_name, max_temperature: @commodity.max_temperature, min_temperature: @commodity.min_temperature, name: @commodity.name, name_am: @commodity.name_am, unit_of_measure: @commodity.unit_of_measure } }
    end

    assert_redirected_to commodity_url(Commodity.last)
  end

  test "should show commodity" do
    get commodity_url(@commodity)
    assert_response :success
  end

  test "should get edit" do
    get edit_commodity_url(@commodity)
    assert_response :success
  end

  test "should update commodity" do
    patch commodity_url(@commodity), params: { commodity: { : @commodity., code: @commodity.code, code_am: @commodity.code_am, cold_storage: @commodity.cold_storage, commodity_category: @commodity.commodity_category, description: @commodity.description, hazardous: @commodity.hazardous, long_name: @commodity.long_name, max_temperature: @commodity.max_temperature, min_temperature: @commodity.min_temperature, name: @commodity.name, name_am: @commodity.name_am, unit_of_measure: @commodity.unit_of_measure } }
    assert_redirected_to commodity_url(@commodity)
  end

  test "should destroy commodity" do
    assert_difference('Commodity.count', -1) do
      delete commodity_url(@commodity)
    end

    assert_redirected_to commodities_url
  end
end
