class PsnpPlanPolicy < ApplicationPolicy
    
    
  def index?
     @current_user.has_permission('PSNP Annual Plan')
  end

  def show?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['guest', 'admin', 'cleark', 'manager'])
  end

  def psnp_plan_items?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def new_psnp_plan_item?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def save_psnp_plan_item?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def remove_psnp_plan_id?
    @current_user.has_permission('PSNP Annual Plan') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
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

