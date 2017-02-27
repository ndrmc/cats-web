class CaseTeamsController < ApplicationController
  before_action :set_case_team, only: [:show, :edit, :update, :destroy]

  # GET /case_teams
  # GET /case_teams.json
  def index
    @case_teams = CaseTeam.all
  end

  # GET /case_teams/1
  # GET /case_teams/1.json
  def show
  end

  # GET /case_teams/new
  def new
    @case_team = CaseTeam.new
  end

  # GET /case_teams/1/edit
  def edit
  end

  # POST /case_teams
  # POST /case_teams.json
  def create
    @case_team = CaseTeam.new(case_team_params)

    respond_to do |format|
      if @case_team.save
        format.html { redirect_to @case_team, notice: 'Case team was successfully created.' }
        format.json { render :show, status: :created, location: @case_team }
      else
        format.html { render :new }
        format.json { render json: @case_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /case_teams/1
  # PATCH/PUT /case_teams/1.json
  def update
    respond_to do |format|
      if @case_team.update(case_team_params)
        format.html { redirect_to @case_team, notice: 'Case team was successfully updated.' }
        format.json { render :show, status: :ok, location: @case_team }
      else
        format.html { render :edit }
        format.json { render json: @case_team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /case_teams/1
  # DELETE /case_teams/1.json
  def destroy
    @case_team.destroy
    respond_to do |format|
      format.html { redirect_to case_teams_url, notice: 'Case team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case_team
      @case_team = CaseTeam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_team_params
      params.require(:case_team).permit(:name, :discription, :role_type)
    end
end
