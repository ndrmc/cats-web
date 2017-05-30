class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    authorize Project
    @projects = Project.all.includes([:commodity, :organization, :commodity_source, :unit_of_measure])    
  end

  # GET /projects/1
  # GET /projects/1.json
  def show

  end

  # GET /projects/new
  def new
    authorize Project
    @project = Project.new(commodity_source_id: params[:source])
  end

  # GET /projects/1/edit
  def edit
     authorize Project
  end

  # POST /projects
  # POST /projects.json
  def create
     authorize Project

    @project = Project.new(project_params)
    @project.created_by = current_user.id
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    authorize Project
    respond_to do |format|
      @project.modified_by = current_user.id

      if project_params[:amount].to_d < @project.amount
        @project.errors[:amount] << 'can not be less than the previous amount.'
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }


      elsif @project.valid? && @project.update(project_params)
        format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

 def archive
     @project = Project.find params[:id] 

            respond_to do |format|
            if @project.update_columns(:archived => true) 
                format.html { redirect_to projects_url, notice: 'Project was successfully archived.' }
            else
                format.html { 
                    flash[:error] = "Save failed! Please check your input and try again shortly."
                    redirect_to projects_url 
                }
            end
        end
end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
     authorize Project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:project_code, :commodity_id, :commodity_source_id, :organization_id, :amount, :unit_of_measure_id, :publish_date)
  end
end
