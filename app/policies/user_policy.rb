class UserPolicy
attr_reader :current_user, :model



def initialize(current_user,model)
    @current_user = current_user
    @model = model
end

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
