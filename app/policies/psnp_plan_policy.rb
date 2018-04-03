class PsnpPlanPolicy < ApplicationPolicy
    
    
  def index?
     @current_user.permission('PSNP Annual Plan', User.user_types[:guest])
  end

  def show?
    permission = Permission.where(name: 'PSNP Annual Plan', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  def psnp_plan_items?
    permission = Permission.where(name: 'PSNP Annual Plan', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def new_psnp_plan_item?
    permission = Permission.where(name: 'PSNP Annual Plan', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def save_psnp_plan_item?
    permission = Permission.where(name: 'PSNP Annual Plan', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def remove_psnp_plan_id?
    permission = Permission.where(name: 'PSNP Annual Plan', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end




  def edit_psnp_plan_form?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def update_psnp_plan_item?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def download_psnp_plan_items?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end


  def new?
        @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def create?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def edit?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def update?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def archive?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end
end

