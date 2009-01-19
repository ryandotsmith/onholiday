# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  ####################
  #get_css should get
  #=>
  # and should return
  #=>
  def get_css
    ['std','list','table','form']
  end
  ####################
  #current_user should get
  #=>
  # and should return
  #=>
  def current_user
    #@user = User.find_by_login(session[:cas_user])
    User.find_by_login(session[:cas_user])
  end
  ####################
  #is_admin?( user ) should get
  #=> a user object
  # and should return
  #=>
  def authorized
    unless current_user.is_admin
      flash[:notice] = "This feature requires elevated credentials."
      redirect_to user_url(current_user)  
    end
  end

end
