class RequisitionPolicy < ApplicationPolicy

  


  def index?
    permission = Permission.where(name: 'Requisition', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  def print?
    permission = Permission.where(name: 'Requisition', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  def print_rrd?
    permission = Permission.where(name: 'Requisition', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  def new?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end


  def edit?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def export_requisition_to_excel?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

 
  def update?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  
  def destroy?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end


  def get_requisiton_by_number?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end


  def prepare?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def generate?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def add_requisition?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def summary?
    permission = Permission.where(name: 'Requisition', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  def delete_regional_requests_fdps_with_zero_ben_no?
    permission = Permission.where(name: 'Requisition', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

end

