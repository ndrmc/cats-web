require 'test_helper'

class HrdsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @hrd = hrds(:hrd1)
  end


  test "should get new" do
    get new_hrd_url
    assert_response :success
  end

  test "should create hrd" do
    assert_difference('Hrd.count') do
      post hrds_url, params: { hrd: { 

        year_ec: 2009, year_gc:2020, month_from: 'Jan', season_id:2 ,ration_id: 1, duration: 6
       } }
    end

    assert_redirected_to hrd_url(Hrd.last)
  end



  test "should get edit" do
    get edit_hrd_url('en',@hrd)
    assert_response :success
  end

  test "should update hrd" do
    patch hrd_url('en',@hrd), params: { hrd: {  
        year_ec: 2009, year_gc:2017, month_from: 'Jan', season_id:1 ,ration_id: 1, duration: 6
         } }
    assert_redirected_to hrds_url
  end

  test "should destroy hrd" do
     get "/hrds/archive/#{@hrd.id}"
      assert_redirected_to hrds_url
  end

 

  test "fields must not be blank" do
    new_hrd = Hrd.new(year_ec: ' ', year_gc: '  ', ration_id: 2 )
    assert !new_hrd.valid?
  end
  
  test "fields must not be nil" do
    new_hrd = Hrd.new(year_ec: nil, year_gc: nil, ration_id: 2 )
    assert !new_hrd.valid?
  end


  
end
