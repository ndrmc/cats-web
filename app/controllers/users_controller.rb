class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :roles, :updateRoles, :user_profile, :updateDepartments, :updatePermissions]
  include Administrated

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    authorize User
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @all_departments = Department.where(id: @user.users_departments.pluck(:department_id))
    @all_permissions = Permission.where(id: @user.users_permissions.pluck(:permission_id))
  end

  # GET /users/new
  def new
    @user = User.new
    @department= Department.all.map{ |h| [h.name, h.id]} # case teams
    @region= Location.where(location_type: 1).map{ |h| [h.name, h.id]}     # regions
    @hubs = Hub.all.map{ |r| [r.name, r.id]}  # hubs
  end

  # GET /users/1/edit
  def edit
    @department= Department.all.map{ |h| [h.name, h.id]} # case teams
    @region= Location.where(location_type: 1).map{ |h| [h.name, h.id]}     # regions
    @hubs = Hub.all.map{ |r| [r.name, r.id]}  # hubs

  end

  def user_departments
    @user = User.find(params[:user_id])
    @all_departments = Department.all
  end

  def user_permissions
    @user = User.find(params[:user_id])
    @all_permissions = Permission.all
  end



  def updateDepartments
    new_departments =  params.require(:departments)
    UsersDepartment.where(user_id: @user.id).destroy_all


    new_departments.each do |department|

      dep =  UsersDepartment.new({
                                   department_id:department.to_i,
                                   user_id: @user.id
      })
      dep.modified_by = current_user.id
      dep.save
    end


    user_deparments =  UsersDepartment.where(user_id: @user.id)

    if user_deparments.count>0 then
      UsersPermission.where(user_id: @user.id).destroy_all
    end
    
    user_deparments.each do |user_department|
        
        departmentPermissions = DepartmentPermission.where(department_id: user_department.department_id)
        departmentPermissions.each do |d|
         
         if !UsersPermission.exists? user_id: @user.id , permission_id: d.permission_id then
            dep =  UsersPermission.new({
            permission_id: d.permission_id,
            user_id: user_department.user_id
            })
            dep.save
        end

        end
        
    end


     redirect_to  @user
    end
  


  def updatePermissions
    puts @user.id
    new_permissions = params.require(:permissions)
    UsersPermission.where(user_id: @user.id).destroy_all

    new_permissions.each do |permission|
      _permission = UsersPermission.new ({
                                           permission_id: permission.to_i,
                                           user_id: @user.id
      })
      _permission.modified_by = current_user.id
      _permission.save
    end

    redirect_to @user, success: 'User profile was successfully updated.'
  end



def updateDepartmentPermission
  
   department_id = params[:department_id]  
 
   new_permissions = params.require(:permissions)
   DepartmentPermission.where(department_id: department_id).destroy_all

   new_permissions.each do |permission|
     _departmentPermission = DepartmentPermission.new ({
       permission_id: permission.to_i,
       department_id: department_id
     })

     _departmentPermission.save
   end



   user_departments = UsersDepartment.all
    user_departments.each do |d|
      UsersPermission.where(user_id: d.user_id).destroy_all
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




    redirect_to departments_path, success: 'Department detail was successfully updated.' 
 end


  # GET /users/1/roles
  def roles
    @all_roles = Role.all
  end

  # PUT /users/updateRoles
  def updateRoles

    new_roles = params.require(:roles).permit!.keys.map { |key| key.to_sym}

    @user.roles =[]
    @user.modified_by = current_user.id
    @user.save

    new_roles.each do |role|
      @user.modified_by = current_user.id
      @user.add_role role
    end


    redirect_to @user, success: 'Roles successfully updated.'


  end


  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.created_by = current_user.id
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, success: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.modified_by = current_user.id
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, success: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :is_active, :hub_id, :location_id, :mobile_no, :user_types, :department_id)
  end
end
