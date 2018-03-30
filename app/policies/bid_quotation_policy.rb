class BidQuotationPolicy < ApplicationPolicy
    
    
 def index?
    permission = Permission.where(name: 'BidQuotation', user_type: :guest).first
    @current_user.has_permission(permission.id) 
 end

 # GET /bid_quotations/1
 # GET /bid_quotations/1.json
 def show?
    permission = Permission.where(name: 'BidQuotation', user_type: :guest).first
    @current_user.has_permission(permission.id)
 end

 # GET /bid_quotations/new
 def new?
    permission = Permission.where(name: 'BidQuotation', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 # GET /bid_quotations/1/edit
 def edit?
    permission = Permission.where(name: 'BidQuotation', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 # POST /bid_quotations
 # POST /bid_quotations.json
 def create?
    permission = Permission.where(name: 'BidQuotation', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 # PATCH/PUT /bid_quotations/1
 # PATCH/PUT /bid_quotations/1.json
 def update?
    permission = Permission.where(name: 'BidQuotation', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 # DELETE /bid_quotations/1
 # DELETE /bid_quotations/1.json
 def destroy?
    permission = Permission.where(name: 'BidQuotation', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def update_tariff?
    permission = Permission.where(name: 'BidQuotation', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

 def delete_bid_quuotation_detail?
    permission = Permission.where(name: 'BidQuotation', user_type: :clerk).first
    @current_user.has_permission(permission.id)
 end

end

