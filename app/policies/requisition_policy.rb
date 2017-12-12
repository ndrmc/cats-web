class RequisitionPolicy < ApplicationPolicy

  


  def index?
    @current_user.has_permission('Requisition')
  end

  def print?
    @current_user.has_permission('Requisition')
  end

  def new?
    @current_user.has_permission('Requisition') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end


  def edit?
    @current_user.has_permission('Requisition') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  

 
  def update?
    @current_user.has_permission('Requisition') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  
  def destroy?
    @current_user.has_permission('Requisition') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end


  def get_requisiton_by_number?
      @current_user.has_permission('Requisition') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end


  def prepare?
    @current_user.has_permission('Requisition') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def generate?
    @current_user.has_permission('Requisition') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def add_requisition?
    @current_user.has_permission('Requisition') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def summary?
    @current_user.has_permission('Requisition') && @current_user.user_type_in(['guest','admin', 'cleark', 'manager'])
  end

end

