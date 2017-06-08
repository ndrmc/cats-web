require 'test_helper'

class FdpsControllerTest < ActionDispatch::IntegrationTest
 include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @fdp = fdps(:fdp1)
  end

  test "should get index" do
    get fdps_url
    assert_response :success
  end

  test "should get new" do
    get new_fdp_url
    assert_response :success
  end

  test "should create fdp" do
    assert_difference('Fdp.count') do
      post fdps_url, params: { fdp: { name: @fdp.name, zone: @fdp.zone, region: @fdp.region, location_id: @fdp.location_id } }
    end

    assert_redirected_to fdps_url
  end

  test "should show fdp" do
    get fdp_url('en',@fdp)
    assert_response :success
  end

  test "should get edit" do
    get edit_fdp_url('en',@fdp)
    assert_response :success
  end

  test "should update fdp" do
    patch fdp_url('en',@fdp), params: { fdp: { name: @fdp.name, zone: @fdp.zone, region: @region, location: @fdp.location  } }
    assert_redirected_to fdp_url(@fdp)
  end

  test "should destroy fdp" do
    assert_difference('Fdp.count', -1) do
      delete fdp_url('en',@fdp)
    end

    assert_redirected_to fdps_url
  end

  test "fdp name  must not be blank" do
    new_fdp=Fdp.new(name: ' ')
    assert !new_fdp.valid?

  end
  
  test "fdp name must not be nil" do
    new_fdp=Fdp.new(name: nil)
    assert !new_fdp.valid?

  end
  
end
