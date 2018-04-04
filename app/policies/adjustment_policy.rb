class AdjustmentPolicy < ApplicationPolicy
      
    # GET /adjustments/1/edit
    def edit?
      @current_user.permission('Adjustment', :clerk)
    end
    
    # PATCH/PUT /adjustments/1
    # PATCH/PUT /adjustments/1.json
    def update?
      @current_user.permission('Adjustment', :clerk)
    end
 
  end
  