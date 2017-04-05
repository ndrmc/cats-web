class ApplicationPolicy
attr_reader :current_user, :model



def initialize(current_user,model)
    @current_user = current_user
    @model = model
end

end
