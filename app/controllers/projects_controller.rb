class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_project
  # GET /projects
  # GET /projects.json
  def index
    authorize Project
    @projects = Project.filter(params.slice(:organization_id, :status)).includes([:commodity, :organization, :commodity_source, :unit_of_measure])   
  end

  # GET /projects/1
  # GET /projects/1.json
  def show

  end

  # GET /projects/new
  def new
    authorize Project

    project_code = Project.pluck(:project_code).last # get last record of project code
    sequence_number = project_code.split('/')[1] # get number
    saved_year = project_code.split('/')[2] # get year

   
    if ! is_numeric?(sequence_number)
       sequence_number = '0001'
    else

      sequence_number = sequence_number.to_i + 1 # increment number by one
      zeros = ""
      i=1
      max_length = sequence_number.to_s.length
     
      for i in 1..4-max_length # append zeros
        zeros = zeros + '0'
      end

      sequence_number =  zeros + sequence_number.to_s

      if Date.today.year < saved_year.to_i   # reset year
        sequence_number ='0001'
      end
      
    end    
    
    if(params[:source].to_i == CommoditySource.find_by_name('Donation').id)
       project_code = CommoditySource.find_by_name('Donation').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
    elsif (params[:source].to_i == CommoditySource.find_by_name('Local Purchase').id)
       project_code = CommoditySource.find_by_name('Local Purchase').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
    elsif (params[:source].to_i == CommoditySource.find_by_name('Loan').id)
         project_code = CommoditySource.find_by_name('Loan').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
    elsif (params[:source].to_i == CommoditySource.find_by_name('Swap').id)
       project_code = CommoditySource.find_by_name('Swap').code + '/' + sequence_number.to_s + '/' + Date.today.year.to_s
    else
      
    end

   
   

    @project = Project.new(commodity_source_id: params[:source], project_code: project_code)

  
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
                    flash[:error] = "Operation failed! Please try again shortly."
                    redirect_to projects_url 
                }
            end
        end
end

 def unarchive
     @project = Project.find params[:id] 

            respond_to do |format|
            if @project.update_columns(:archived => false) 
                format.html { redirect_to projects_url, notice: 'Project was successfully activated.' }
            else
                format.html { 
                    flash[:error] = "Operation failed! Please try again shortly."
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


def get_commodities
  val = params[:id]
  @commodities = Commodity.find_by commodity_category_id: params[:id]
  @commodities =  Commodity.where(commodity_category_id: params[:id]).map{ |r| [r.name, r.id]} 

 respond_to do |format|
      format.json { render json: @commodities }
    end
end

  def get_commodity_source_code
    commodity_source_id = params[:id]
    result = CommoditySource.find_by_id(commodity_source_id)
    respond_to do |format|
      format.json { render json: result }
    end
  end

  private
  def authorize_project
    authorize Project
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:project_code, :commodity_id, :commodity_source_id, :organization_id, :amount, :unit_of_measure_id, :publish_date, :commodity_categories_id)
  end
end
