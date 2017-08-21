require 'test_helper'

class WarehouseSelectionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @warehouse_selection = warehouse_selections(:warehouse_selection_1)
  end

  test "should get index" do
    get warehouse_selections_url
    assert_response :success
  end

  test "should get new" do
    get new_warehouse_selection_url
    assert_response :success
  end

  test "should create warehouse_selection" do
    post warehouse_selections_url, params: { warehouse_selection: { created_by: @warehouse_selection.created_by, deleted: @warehouse_selection.deleted, deleted_at: @warehouse_selection.deleted_at, estimated_qty: @warehouse_selection.estimated_qty, framework_tender_id: @warehouse_selection.framework_tender_id, modified_by: @warehouse_selection.modified_by, warehouse_id: @warehouse_selection.warehouse_id, location_id: @warehouse_selection.location_id } }

    assert_response :success
  end

  test "should show warehouse_selection" do
    get warehouse_selection_url('en',@warehouse_selection)
    assert_response :success
  end

  test "should get edit" do
    get edit_warehouse_selection_url('en',@warehouse_selection)
    assert_response :success
  end

  test "should update warehouse_selection" do
    patch warehouse_selection_url('en',@warehouse_selection), params: { warehouse_selection: { created_by: @warehouse_selection.created_by, deleted: @warehouse_selection.deleted, deleted_at: @warehouse_selection.deleted_at, estimated_qty: @warehouse_selection.estimated_qty, framework_tender_id: @warehouse_selection.framework_tender_id, modified_by: @warehouse_selection.modified_by, warehouse_id: @warehouse_selection.warehouse_id, location_id: @warehouse_selection.location_id } }
    assert_redirected_to warehouse_selection_url(@warehouse_selection)
  end

  test "should destroy warehouse_selection" do
    assert_difference('WarehouseSelection.count', -1) do
      delete warehouse_selection_url('en',@warehouse_selection)
    end

    assert_redirected_to '/en/warehouse_selections/' + @warehouse_selection&.framework_tender_id&.to_s
  end
end
