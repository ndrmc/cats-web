class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :roles, :updateRoles]

 

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
    @department= Department.where(role_type: User.role_types[:case_team]).map{ |h| [h.name, h.id]} # case teams
    @hubs= Department.where(role_type: User.role_types[:hub]).map{ |h| [h.name, h.id]}     # hubs
    @region = Department.where(role_type: User.role_types[:regional]).map{ |r| [r.name, r.id]}  # regions
  end

  # GET /users/1/edit
  def edit
    @roles = RoleType.all.map{ |t| [t.name, t.id]}
    @department= Department.where(role_type: User.role_types[:case_team]).map{ |h| [h.name, h.id]} # case teams
    @hubs= Department.where(role_type: User.role_types[:hub]).map{ |h| [h.name, h.id]}     # hubs
    @region = Department.where(role_type: User.role_types[:regional]).map{ |r| [r.name, r.id]}  # regions

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
      params.require(:user).permit(:first_name, :last_name, :email, :is_active, :hub, :region, :case_team, :regional_user, :hub_user, :mobile_no, :date_preference,:is_admin,:is_case_team)
    end
end
