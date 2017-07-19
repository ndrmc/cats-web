class ProjectPolicy < ApplicationPolicy

  def index?
    @current_user.has_permission('Project')
  end

  
  def show?
    @current_user.has_permission('Project') && @current_user.user_type_in(['guest','admin', 'cleark', 'manager'])
  end

  
  def new?
     @current_user.has_permission('Project') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  
  def edit?
     @current_user.has_permission('Project') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # POST /projects
  # POST /projects.json
  def create?
     @current_user.has_permission('Project') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update?
     @current_user.has_permission('Project') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy?
     @current_user.has_permission('Project') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

    def archive?
     @current_user.has_permission('Project') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end
    
    def unarchive?
        @current_user.has_permission('Project') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

end

