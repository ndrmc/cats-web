class ProjectPolicy < ApplicationPolicy

  def index?
    @current_user.permission('Project', :guest)
  end

  
  def show?
    @current_user.permission('Project', :guest)
  end

  
  def new?
    @current_user.permission('Project', :clerk)
  end

  
  def edit?
    @current_user.permission('Project', :clerk)
  end

  # POST /projects
  # POST /projects.json
  def create?
    @current_user.permission('Project', :clerk)
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update?
    @current_user.permission('Project', :clerk)
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy?
    @current_user.permission('Project', :clerk)
  end

    def archive?
      @current_user.permission('Project', :clerk)
    end
    
    def unarchive?
      @current_user.permission('Project', :clerk)
    end

    def get_commodities?
      @current_user.permission('Project', :clerk)
    end

    def get_commodity_source_code?
      @current_user.permission('Project', :clerk)
    end

end

