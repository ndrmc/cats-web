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

  

    def user_uom_preference(value,unit)
         unit_to_be_changed = UnitOfMeasure.cache_find(unit).name
         user_default_unit = User.cache_find(current_user.id).default_uom
         target_unit = UnitOfMeasure.cache_find(user_default_unit)
         amount_in_user_preference = target_unit.convert_to(unit_to_be_changed, value)
         return amount_in_user_preference
    end

    def to_user_unit(value)
        if value.nil?
            value = 0
        end
         user_default_unit = User.cache_find(current_user.id).default_uom
         target_unit = UnitOfMeasure.cache_find(user_default_unit)
         amount_in_user_preference = target_unit.ref_to_unit(value)
         return amount_in_user_preference
    end
    
    
end
