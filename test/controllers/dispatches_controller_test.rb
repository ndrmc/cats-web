require 'test_helper'

class DispatchesControllerTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @dispatch = dispatches(:dispatch1)
    @hub = hubs(:hub1)
    @warehouse = warehouses(:warehouse1)
    @fdp = fdps(:fdp1)
    @dispatch_items = dispatch_items(:dispatch_item1)
  end

  test "should get index" do
    get dispatches_url
    assert_response :success
  end

  test "should get new" do
    get new_dispatch_url
    assert_response :success
  end

  test "should create dispatch" do
    assert_difference('Dispatch.count') do
      post dispatches_url, params: { dispatch: { 

    gin_no: '001',
    requisition_number: 017234,
    operation_id: 01,
    dispatch_date: '1/12018',
    hub_id: @hub.id,
    warehouse_id:@warehouse.id,
    fdp_id:@fdp.id,
    weight_bridge_ticket_number: '-',
    storekeeper_name: 'Abebe',
    transporter_id:1,
    dispatch_items: [{

                 commodity_category_id:1,
                 commodity_id:2,
                 quantity:40,
                 unit_of_measure_id:2,
                 organization_id:1,
                 project_id:1

    }]

       } }
    end

    assert_redirected_to dispatch_url(Dispatch.last)
  end

  #test "should show dispatch" do
  #  get dispatch_url('en',@dispatch)
  #  assert_response :success
  #end

  test "should get edit" do
    get edit_dispatch_url('en',@dispatch)
    assert_response :success
  end

  test "should update dispatch" do
    patch dispatch_url('en',@dispatch), params: { dispatch: { 

    gin_no:'002',
    requisition_number: 017236,
    operation_id: 01,
    dispatch_date: '1/12019',
    hub_id: @hub.id,
    warehouse_id: @warehouse.id,
    fdp_id: @fdp.id,
    weight_bridge_ticket_number: '-',
    storekeeper_name: 'Abebe',
    transporter_id: 1,
    dispatch_items: [{

                 commodity_category_id:2,
                 commodity_id:3,
                 quantity:34,
                 unit_of_measure_id:3,
                 organization_id:3,
                 project_id:3

    }]

     } }
    assert_redirected_to dispatches_path
  end

#  test "should destroy dispatch" do
#    assert_difference('Dispatch.count', -1) do
#      delete dispatch_url('en',@dispatch)
#    end

#    assert_redirected_to dispatches_url
#  end
end
