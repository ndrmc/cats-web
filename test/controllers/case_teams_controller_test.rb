require 'test_helper'

class CaseTeamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @case_team = case_teams(:one)
  end

  test "should get index" do
    get case_teams_url
    assert_response :success
  end

  test "should get new" do
    get new_case_team_url
    assert_response :success
  end

  test "should create case_team" do
    assert_difference('CaseTeam.count') do
      post case_teams_url, params: { case_team: { discription: @case_team.discription, name: @case_team.name, role_type: @case_team.role_type } }
    end

    assert_redirected_to case_team_url(CaseTeam.last)
  end

  test "should show case_team" do
    get case_team_url(@case_team)
    assert_response :success
  end

  test "should get edit" do
    get edit_case_team_url(@case_team)
    assert_response :success
  end

  test "should update case_team" do
    patch case_team_url(@case_team), params: { case_team: { discription: @case_team.discription, name: @case_team.name, role_type: @case_team.role_type } }
    assert_redirected_to case_team_url(@case_team)
  end

  test "should destroy case_team" do
    assert_difference('CaseTeam.count', -1) do
      delete case_team_url(@case_team)
    end

    assert_redirected_to case_teams_url
  end
end
