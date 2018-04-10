class HrdPolicy < ApplicationPolicy
    

    def index?
        @current_user.permission('HRD', :guest)
    end
    
    def show?
        @current_user.permission('HRD', :guest)
    end
    
    def new?
        @current_user.permission('HRD', :clerk)
    end

    def create?
        @current_user.permission('HRD', :clerk)
    end

    def edit?
        @current_user.permission('HRD', :clerk)
    end
    
    def update?
        @current_user.permission('HRD', :clerk)
    end

    def archive?
        @current_user.permission('HRD', :clerk)
    end

    def hrd_items?
        @current_user.permission('HRD', :clerk)
    end

    def update_hrd_item?
        @current_user.permission('HRD', :clerk)
    end

     def edit_hrd_form?
        @current_user.permission('HRD', :clerk)
    end 

    def new_hrd_item?
        @current_user.permission('HRD', :clerk)
    end 

    def save_hrd_item?
        @current_user.permission('HRD', :clerk)
    end 

    def remove_hrd_id?
        @current_user.permission('HRD', :clerk)
    end

    def download_hrd_items?
        @current_user.permission('HRD', :clerk)
    end 

end

