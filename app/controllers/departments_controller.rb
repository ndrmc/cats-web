class DepartmentsController < ApplicationController
  layout 'admin'
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  include Administrated
  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @all_permissions = Permission.all
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)
    @department.created_by = current_user.id
    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    @department.modified_by = current_user.id
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
   
    users = UsersDepartment.where(department_id: @department.id)
    user_departments = UsersDepartment.where.not(department_id: @department.id)
     
     if user_departments.count < 1 then
        users.each do |d|
        UsersPermission.where(user_id: d.user_id).delete_all
        DepartmentPermission.where(department_id: d.department_id).delete_all
         end
    
    else

      user_departments.each do |d|
        UsersPermission.where(user_id: d.user_id).delete_all
        DepartmentPermission.where(department_id: d.id).delete_all
     end

   user_departments.each do |d|
   
   departmentPermissions = DepartmentPermission.where(department_id: d.department_id).all
        departmentPermissions.each do |departmentPermission|
         
         if !UsersPermission.exists? user_id: d.user_id , permission_id: departmentPermission.permission_id then
            dep =  UsersPermission.new({
            permission_id: departmentPermission.permission_id,
            user_id: d.user_id
            })
            dep.save
        end

        end
     

     end
end
 @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :description)
    end
end
