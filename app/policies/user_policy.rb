class UserPolicy < ApplicationPolicy


def index?
   @current_user.permissions.where(name: 'HRD').count > 0 || @current_user.user_types == 'admin'
end

def new?
    return true
end

def roles
    return true
end

def create
    return true
end

def update
   return true
end

def updateRoles
   return true
end

end
