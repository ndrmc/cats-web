require 'test_helper'

class CommoditySourcesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @commodity_source = commodity_sources(:commodity_source_1)
  end

  test "should get index" do
    get commodity_sources_url
    assert_response :success
  end

  test "should get new" do
    get new_commodity_source_url
    assert_response :success
  end

  test "should create commodity_source" do
    assert_difference('CommoditySource.count') do
      post commodity_sources_url, params: { commodity_source: { name: 'sample commodity source'} }
    end

    assert_redirected_to commodity_sources_url
  end

  test "should show commodity_source" do
    get commodity_source_url('en',@commodity_source)
    assert_response :success
  end


  test "should get edit" do
    get edit_commodity_source_url('en',@commodity_source)
    assert_response :success
  end


  test "should update commodity_source" do
    patch commodity_source_url('en', @commodity_source), params: { commodity_source: { name: 'Purchase' } }
    assert_redirected_to commodity_sources_url

  end

  test "should destroy commodity_source" do
    assert_difference('CommoditySource.count', -1) do
      delete commodity_source_url('en', @commodity_source)
    end

    assert_redirected_to commodity_sources_url
  end

  test "name should be unique" do
    duplicated_commodity_source = @commodity_source.dup
    @commodity_source.save
    assert_not duplicated_commodity_source.valid?
  end

  test "name must not be blank" do
    new_commodity_source = CommoditySource.new(name: '  ')
    assert !new_commodity_source.valid?
  end

  test "name must not be nil" do
      new_commodity_source = CommoditySource.new(name: nil)
     assert !new_commodity_source.valid?
  end
  
  
  
end
