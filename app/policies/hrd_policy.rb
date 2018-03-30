class HrdPolicy < ApplicationPolicy
    

    def index?
        permission = Permission.where(name: 'HRD', user_type: :guest).first
        @current_user.has_permission(permission&.id)
    end
    
    def show?
        permission = Permission.where(name: 'HRD', user_type: :guest).first
        @current_user.has_permission(permission&.id)
    end
    
    def new?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end

    def create?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end

    def edit?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end
    
    def update?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end

    def archive?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end

    def hrd_items?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end

    def update_hrd_item?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end

     def edit_hrd_form?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end 

    def new_hrd_item?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end 

    def save_hrd_item?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end 

    def remove_hrd_id?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end

    def download_hrd_items?
        permission = Permission.where(name: 'HRD', user_type: :clerk).first
        @current_user.has_permission(permission&.id)
    end 

end

