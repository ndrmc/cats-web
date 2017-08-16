class HrdPolicy < ApplicationPolicy
    

    def index?
        @current_user.has_permission('HRD')
    end
    
    def show?
        @current_user.has_permission('HRD') && @current_user.user_type_in(['guest', 'admin', 'cleark', 'manager'])
    end
    
    def new?
       @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def create?
         @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def edit?
        @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end
    
    def update?
         @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def archive?
         @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def hrd_items?
        @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def update_hrd_item?
      @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

     def edit_hrd_form?
       @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end 

    def new_hrd_item?
       @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end 

    def save_hrd_item?
        @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end 

    def remove_hrd_id?
        @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def download_hrd_items?
        @current_user.has_permission('HRD') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end 

end

