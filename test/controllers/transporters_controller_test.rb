require 'test_helper'

class TransportersControllerTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:admin)
    @transporter = transporters(:transporter_1)
  end

  test "should get index" do
    get transporters_url
    assert_response :success
  end

  test "should get new" do
    get new_transporter_url
    assert_response :success
  end

  test "should create transporter" do
    assert_difference('Transporter.count') do
      post transporters_url, params: { transporter: { name: 'Transporter name', code: 'tn' } }
    end

    assert_redirected_to transporters_url
  end

  test "should show transporter" do
    get transporter_url('en',@transporter)
    assert_response :success
  end

  test "should get edit" do
    get edit_transporter_url('en',@transporter)
    assert_response :success
  end

  test "should update transporter" do
    patch transporter_url('en',@transporter), params: { transporter: { name: 'new transporter name' , code: 'nta' } }
    assert_redirected_to transporter_path(@transporter, {notice: "Transporter was successfully updated."})
  end

  test "should destroy transporter" do
    assert_difference('Transporter.count', -1) do
      delete transporter_url('en',@transporter)
    end

    assert_redirected_to transporters_url
  end


  test "Transporter name must be unique" do
    duplicate_transporter =  @transporter.dup
    @transporter.save
    assert_not duplicate_transporter.valid?
  end

  test "Transporter name and code must not be blank" do 
    new_transporter = Transporter.new(name: ' ', code: 'cd')
    assert !new_transporter.valid?
  end

  test "Transporter name and code must not be nil" do 
        new_transporter = Transporter.new(name: nil, code: 'cd')
       assert !new_transporter.valid?
 end
  
  
end
