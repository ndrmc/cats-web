require 'test_helper'

class RationsControllerTest < ActionDispatch::IntegrationTest
  setup do
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
      post rations_url, params: { ration: { current: @ration.current, description: @ration.description, reference_no: @ration.reference_no } }
    end

    assert_redirected_to ration_url(Ration.last)
  end

  test "should show ration" do
    get ration_url(@ration)
    assert_response :success
  end

  test "should get edit" do
    get edit_ration_url(@ration)
    assert_response :success
  end

  test "should update ration" do
    patch ration_url(@ration), params: { ration: { current: @ration.current, description: @ration.description, reference_no: @ration.reference_no } }
    assert_redirected_to ration_url(@ration)
  end

  test "should destroy ration" do
    assert_difference('Ration.count', -1) do
      delete ration_url(@ration)
    end

    assert_redirected_to rations_url
  end
end
