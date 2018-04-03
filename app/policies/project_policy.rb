class ProjectPolicy < ApplicationPolicy

  def index?
    @current_user.permission('Project', User.user_types[:guest])
  end

  
  def show?
    permission = Permission.where(name: 'Project', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  
  def new?
    permission = Permission.where(name: 'Project', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  
  def edit?
    permission = Permission.where(name: 'Project', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # POST /projects
  # POST /projects.json
  def create?
    permission = Permission.where(name: 'Project', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update?
    permission = Permission.where(name: 'Project', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy?
    permission = Permission.where(name: 'Project', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

    def archive?
      permission = Permission.where(name: 'Project', user_type: :clerk).first
      @current_user.has_permission(permission.id)
    end
    
    def unarchive?
      permission = Permission.where(name: 'Project', user_type: :clerk).first
      @current_user.has_permission(permission.id)
    end

    def get_commodities?
      permission = Permission.where(name: 'Project', user_type: :clerk).first
      @current_user.has_permission(permission.id)
    end

    def get_commodity_source_code?
      permission = Permission.where(name: 'Project', user_type: :clerk).first
      @current_user.has_permission(permission.id)
    end

end

