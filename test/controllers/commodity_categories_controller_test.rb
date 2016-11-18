require 'test_helper'

class CommodityCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @commodity_category = commodity_categories(:one)
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
      post commodity_categories_url, params: { commodity_category: { code: @commodity_category.code, code_am: @commodity_category.code_am, description: @commodity_category.description, name: @commodity_category.name } }
    end

    assert_redirected_to commodity_category_url(CommodityCategory.last)
  end

  test "should show commodity_category" do
    get commodity_category_url(@commodity_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_commodity_category_url(@commodity_category)
    assert_response :success
  end

  test "should update commodity_category" do
    patch commodity_category_url(@commodity_category), params: { commodity_category: { code: @commodity_category.code, code_am: @commodity_category.code_am, description: @commodity_category.description, name: @commodity_category.name } }
    assert_redirected_to commodity_category_url(@commodity_category)
  end

  test "should destroy commodity_category" do
    assert_difference('CommodityCategory.count', -1) do
      delete commodity_category_url(@commodity_category)
    end

    assert_redirected_to commodity_categories_url
  end
end
