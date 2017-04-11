require 'test_helper'

class CommodityCategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @commodity_category = commodity_categories(:commodity_category_1)
  end

  test "should get index" do
    get commodity_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_commodity_category_url
    assert_response :success
  end

  test "should create commodity_category" do
    assert_difference('CommodityCategory.count') do
      post commodity_categories_url, params: { commodity_category: { name: 'Test', code: 'TST', description: 'This is test data' } }
    end

    assert_redirected_to commodity_categories_url
  end

  test "should show commodity_category" do
    get commodity_category_url('en',@commodity_category)
    assert_response :success
  end


  test "should get edit" do
    get edit_commodity_category_url('en',@commodity_category)
    assert_response :success
  end


  test "should update commodity_category" do
    patch commodity_category_url('en', @commodity_category), params: { commodity_category: { name: 'Updated Name' } }
    assert_redirected_to commodity_categories_url

  end

  test "should destroy commodity_category" do
    assert_difference('CommodityCategory.count', -1) do
      delete commodity_category_url('en', @commodity_category)
    end

    assert_redirected_to commodity_categories_url
  end

end
