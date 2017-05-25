require 'test_helper'

class ProgramsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)

    @program = programs(:one)
  end

  test "should get index" do
    get programs_url
    assert_response :success
  end

  test "should get new" do
    get new_program_url
    assert_response :success
  end

  test "should create program" do
    assert_difference('Program.count') do
      post programs_url, params: { program: { name: 'new program', code: 'np'  } }
    end

    assert_redirected_to programs_url
  end

  test "should show program" do
    get programs_url
    assert_response :success
  end

  test "should get edit" do
    get edit_program_url('en',@program)
    assert_response :success
  end

  test "should update program" do
    patch program_url('en', @program), params: { program: { name: 'update program', code: 'up'  } }
    assert_redirected_to program_url(@program)
  end

  test "should destroy program" do
    assert_difference('Program.count', -1) do
      delete program_url('en',@program)
    end

    assert_redirected_to programs_url
  end

  test "Program name must be unique" do 
    duplicated_program = @program.dup
    @program.save
    assert_not duplicated_program.valid?
  end

  test "Program name must be present" do 
     new_program = Program.new(name: 'new program', code: 'new code')
    assert @program.valid?
  end

  test "Program name and code must not be blank" do 
    new_program = Program.new(name: '  ', code: 'new code')
    assert !new_program.valid?
  end

  test "Program name and code must not be nil" do
     new_program = Program.new(name: nil, code: nil)
    assert !new_program.valid?
  end
  
  
  

end
