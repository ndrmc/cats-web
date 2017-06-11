require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @project = projects(:project1)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post projects_url, params: { project: { 

        project_code: 'pc-0020',
        commodity_id: 1,
        commodity_source_id: 1,
        organization_id: 1,
        amount: 50,
        unit_of_measure_id: 1,
        publish_date: '1/1/2000',
        commodity_categories_id: 1

       } }
    end

    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    get project_url'en',(@project)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_url('en',@project)
    assert_response :success
  end

  test "should update project" do
    patch project_url('en',@project), params: { project: { 

        project_code: 'pc-0020',
        commodity_id: 1,
        commodity_source_id: 1,
        organization_id: 1,
        amount: 50,
        unit_of_measure_id: 1,
        publish_date: '1/1/2000',
        commodity_categories_id: 1

     } }
    assert_redirected_to project_url(@project)
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete project_url('en',@project)
    end

    assert_redirected_to projects_url
  end
end
