# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_css
    [ 'std',
      'list',
      'table',
      'form',
      'theme/ui.all.css',
      'tablesort/tablesort.css',
      'facebox.css']
  end
  def get_js
    [ :defaults,
      'jquery.corners.js',
      'jquery.easing.min.js',
      'jquery.tablesorter.min.js',
      'facebox.js'
      ]
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
