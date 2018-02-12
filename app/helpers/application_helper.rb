module ApplicationHelper 
    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def toastr_method_name(level)
        case level.to_sym
            when :notice then 'info'
            when :alert then 'error'
            else level
        end
    end

    def google_map(center)
        "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=300x300&zoom=17"
    end

  

    def user_uom_preference(value)
         user_default_unit = User.cache_find(current_user.id).default_uom
         target_unit = UnitOfMeasure.cache_find(user_default_unit)
         ref_unit = UnitOfMeasure.cache_find_ref('ref')
         amount_in_user_preference = target_unit.convert_to(ref_unit&.name, value)
         return amount_in_user_preference
    end
    
end
