class AdminPolicy < Struct.new(:user, :admin)
  def admin?
    user.admin?
  end 
end 