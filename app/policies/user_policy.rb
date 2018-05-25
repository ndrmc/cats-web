class UserPolicy < ApplicationPolicy


def index?

 @current_user.permission('UserAccount', :admin)
end

def new?
    @current_user.permission('UserAccount', :admin)
end

def roles?
    @current_user.permission('UserAccount', :admin)
end

def create?
    @current_user.permission('UserAccount', :admin)
end

def update?
   @current_user.permission('UserAccount', :admin)
end

def updateRoles?
   @current_user.permission('UserAccount', :admin)
end

end
