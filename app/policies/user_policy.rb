class UserPolicy
attr_reader :current_user, :model



def initialize(current_user,model)
    @current_user = current_user
    @model = model
end

def index?
    @current_user.has_role? :admin
end

end
