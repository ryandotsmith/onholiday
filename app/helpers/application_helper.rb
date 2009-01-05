# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  ####################
  #current_user should get
  #=>
  # and should return
  #=>
  def current_user
    @user = User.find_by_login(session[:cas_user])
  end
  ####################
  #is_admin?( user ) should get
  #=> a user object
  # and should return
  #=>
  def authorized
    unless @user.is_admin
      flash[:notice] = "This feature requires elevated credentials."
      redirect_to user_url(@user)  
    end
  end

end
