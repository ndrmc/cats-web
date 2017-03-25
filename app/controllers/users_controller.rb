class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :roles, :updateRoles, :departments, :updateDepartments, :updatePermissions]

 

  layout 'admin'

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    authorize User
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    
    @roles = RoleType.all.map{ |t| [t.name, t.id]}
    @caseTeam= CaseTeam.where(role_type: User.role_types[:case_team]).map{ |h| [h.name, h.id]} # case teams
    @hubs= CaseTeam.where(role_type: User.role_types[:hub]).map{ |h| [h.name, h.id]}     # hubs
    @region = CaseTeam.where(role_type: User.role_types[:regional]).map{ |r| [r.name, r.id]}  # regions
  end

  # GET /users/1/edit
  def edit
    @roles = RoleType.all.map{ |t| [t.name, t.id]}
    @caseTeam= CaseTeam.where(role_type: User.role_types[:case_team]).map{ |h| [h.name, h.id]} # case teams
    @hubs= CaseTeam.where(role_type: User.role_types[:hub]).map{ |h| [h.name, h.id]}     # hubs
    @region = CaseTeam.where(role_type: User.role_types[:regional]).map{ |r| [r.name, r.id]}  # regions

  end

  def user_departments
     @user = User.find(params[:user_id])
     @all_departments = Department.all
  end

  def user_permissions
      @user = User.find(params[:user_id])
      @all_permissions = Permission.all
  end
  

  def departments
    @all_departments = Department.where(id: @user.users_departments.pluck(:department_id))
    @all_permissions = Permission.where(id: @user.users_permissions.pluck(:permission_id))
  end
  
  def updateDepartments
    new_departments =  params.require(:departments)
    UsersDepartment.where(user_id: @user.id).destroy_all
   

    new_departments.each do |department|
      
      dep =  UsersDepartment.new({
        department_id:department.to_i,
        user_id: @user.id
      })
      dep.save
    end

    redirect_to :action => "departments"
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

     _permission.save
   end

   redirect_to :action => "departments"
 end


  # GET /users/1/roles
  def roles
    @all_roles = Role.all
  end

  # PUT /users/updateRoles
  def updateRoles

    new_roles = params.require(:roles).permit!.keys.map { |key| key.to_sym}

    @user.roles =[]

    @user.save

    new_roles.each do |role|
      @user.add_role role
    end


    redirect_to users_path, success: 'Roles successfully updated.'


  end


  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

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
      params.require(:user).permit(:first_name, :last_name, :email, :is_active, :hub, :region, :case_team, :regionalUser, :hubUser, :mobileNo, :datePreference,:Admin,:IsCaseTeam)
    end
end
