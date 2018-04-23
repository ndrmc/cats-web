class RequisitionPolicy < ApplicationPolicy

  


  def index?
    @current_user.permission('Requisition', :guest)
  end

  def print?
    @current_user.permission('Requisition', :guest)
  end

  def print_rrd?
    @current_user.permission('Requisition', :guest)
  end

  def new?
    @current_user.permission('Requisition', :clerk)
  end


  def edit?
    @current_user.permission('Requisition', :clerk)
  end

  def export_requisition_to_excel?
    @current_user.permission('Requisition', :clerk)
  end

 
  def update?
    @current_user.permission('Requisition', :clerk)
  end

  
  def destroy?
    @current_user.permission('Requisition', :clerk)
  end


  def get_requisiton_by_number?
    @current_user.permission('Requisition', :guest)
  end


  def prepare?
    @current_user.permission('Requisition', :clerk)
  end

  def generate?
    @current_user.permission('Requisition', :clerk)
  end

  def contingency?
    @current_user.permission('Requisition', :clerk)
  end
  

  def add_requisition?
    @current_user.permission('Requisition', :clerk)
  end

  def summary?
    @current_user.permission('Requisition', :guest)
  end

  def delete_regional_requests_fdps_with_zero_ben_no?
    @current_user.permission('Requisition', :clerk)
  end

end

