class FrameworkTenderPolicy < ApplicationPolicy
    
    
 def index?
    @current_user.permission('FrameworkTender', User.user_types[:guest])  
 end

 # GET /framework_tenders/1
 # GET /framework_tenders/1.json
 def show?
    permission = Permission.where(name: 'FrameworkTender', user_type: :guest).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
 end

 # GET /framework_tenders/new
 def new?
    permission = Permission.where(name: 'FrameworkTender', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id)  
 end

 # GET /framework_tender/1/edit
 def edit?
    permission = Permission.where(name: 'FrameworkTender', user_type: :clerk).first
     permission.nil? ? false :  permission.nil? ? false : @current_user.has_permission(permission.id)  
 end

 # POST /framework_tenders
 # POST /framework_tenders.json
 def create?
    permission = Permission.where(name: 'FrameworkTender', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
 end

 # PATCH/PUT /framework_tenders/1
 # PATCH/PUT /framework_tenders/1.json
 def update?
    permission = Permission.where(name: 'FrameworkTender', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
 end

 # DELETE /framework_tenders/1
 # DELETE /framework_tenders/1.json
 def destroy?
    permission = Permission.where(name: 'FrameworkTender', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
 end

 def update_status?
    permission = Permission.where(name: 'FrameworkTender', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
 end

end

