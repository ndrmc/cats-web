class UserPolicy < ApplicationPolicy


def index?
  return true
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
