require 'test_helper'

class RationsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

  setup do
     sign_in users(:admin)
    @ration = rations(:one)
  end

  test "should get index" do
    get rations_url
    assert_response :success
  end

  test "should get new" do
    get new_ration_url
    assert_response :success
  end

  test "should create ration" do
    assert_difference('Ration.count') do
      post rations_url, params: { ration: {reference_no: 1908 , description: ''  } }
    end

    assert_redirected_to ration_url(Ration.last)
  end

  test "should show ration" do
    get rations_url
    assert_response :success
  end

  test "should get edit" do
    get edit_ration_url(id: @ration.id)
    assert_response :success
  end

  test "should update ration" do
    patch ration_url(id: @ration.id), params: { ration: { reference_no: 01 , description: ''  } }
    assert_redirected_to ration_url(@ration)
  end

  test "should destroy ration" do
    assert_difference('Ration.count', -1) do
      delete ration_url(id: @ration.id)
    end

    assert_redirected_to rations_url
  end
end
