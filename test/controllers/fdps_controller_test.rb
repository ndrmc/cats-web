require 'test_helper'

class FdpsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fdp = fdps(:one)
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
      post fdps_url, params: { fdp: { active: @fdp.active, description: @fdp.description, lat: @fdp.lat, lon: @fdp.lon, name: @fdp.name } }
    end

    assert_redirected_to fdp_url(Fdp.last)
  end

  test "should show fdp" do
    get fdp_url(@fdp)
    assert_response :success
  end

  test "should get edit" do
    get edit_fdp_url(@fdp)
    assert_response :success
  end

  test "should update fdp" do
    patch fdp_url(@fdp), params: { fdp: { active: @fdp.active, description: @fdp.description, lat: @fdp.lat, lon: @fdp.lon, name: @fdp.name } }
    assert_redirected_to fdp_url(@fdp)
  end

  test "should destroy fdp" do
    assert_difference('Fdp.count', -1) do
      delete fdp_url(@fdp)
    end

    assert_redirected_to fdps_url
  end
end
