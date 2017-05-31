require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  

  setup do
    sign_in users(:admin)
    @warehouse = Warehouse.new(id: 1, name: 'warehouse 1')
    @store = stores(:one)
  end

  test "should get index" do
    get stores_url
    assert_response :success
  end

  #test "should get new" do
  #  get new_store_url, params: { warehouse_id: @warehouse.id } 
  #  assert_response :success
  #end

  test "should create store" do
    assert_difference('Store.count') do
      post stores_url, params: { store: { name: 'store 3', warehouse_id: @warehouse.id, store_keeper_name: 'abebe' },warehouse_id: @warehouse.id }
    end

    assert_redirected_to  warehouse_path(@warehouse)
  end

  test "should show store" do
    get store_url('en',@store)
    assert_response :success
  end

  test "should get edit" do
    get edit_store_url('en',@store)
    assert_response :success
  end

  test "should update store" do
    patch store_url('en',@store), params: { store: {  name: 'store 4', warehouse_id: 1, store_keeper_name: 'mola' } }
    assert_redirected_to warehouse_path(@warehouse)
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete store_url('en',@store)
    end

    assert_redirected_to warehouse_path(@warehouse)
  end

  test "name and store keeper name must not be blank" do
    new_store = Store.new(name: ' ', store_keeper_name: ' ')
    assert !new_store.valid?
  end

  test "name and store keeper name must not be nil" do
    new_store = Store.new(name: nil, store_keeper_name: nil)
    assert !new_store.valid?
  end

  test "a store name must be unique under the same warehouse" do 
    duplicated_store = @store.dup
    @store.save
    assert_not duplicated_store.valid?
  end
  
  
end
