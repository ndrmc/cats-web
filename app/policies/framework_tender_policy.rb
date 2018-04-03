class FrameworkTenderPolicy < ApplicationPolicy
    
    
 def index?
    @current_user.permission('FrameworkTender', :guest)  
 end

 # GET /framework_tenders/1
 # GET /framework_tenders/1.json
 def show?
    @current_user.permission('FrameworkTender', :guest)  
 end

 # GET /framework_tenders/new
 def new?
    @current_user.permission('FrameworkTender', :clerk)  
 end

 # GET /framework_tender/1/edit
 def edit?
    @current_user.permission('FrameworkTender', :clerk)    
 end

 # POST /framework_tenders
 # POST /framework_tenders.json
 def create?
    @current_user.permission('FrameworkTender', :clerk)  
 end

 # PATCH/PUT /framework_tenders/1
 # PATCH/PUT /framework_tenders/1.json
 def update?
    @current_user.permission('FrameworkTender', :clerk)  
 end

 # DELETE /framework_tenders/1
 # DELETE /framework_tenders/1.json
 def destroy?
    @current_user.permission('FrameworkTender', :clerk)  
 end

 def update_status?
    @current_user.permission('FrameworkTender', :clerk)  
 end

end

