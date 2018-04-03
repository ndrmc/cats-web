class PsnpPlanPolicy < ApplicationPolicy
    
    
  def index?
    @current_user.permission('PSNP Annual Plan', :guest)
  end

  def show?
    @current_user.permission('PSNP Annual Plan', :guest)
  end

  def psnp_plan_items?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def new_psnp_plan_item?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def save_psnp_plan_item?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def remove_psnp_plan_id?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def edit_psnp_plan_form?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def update_psnp_plan_item?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def download_psnp_plan_items?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def new?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def create?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def edit?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def update?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end

  def archive?
    @current_user.permission('PSNP Annual Plan', :clerk)
  end
end

