# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_css
    [ 'std',
      'list',
      'table',
      'form',
      'theme/ui.all.css',
      'tablesort/tablesort.css']
  end

  def get_js
    [ :defaults,
      'jquery.corners.js',
      'jquery.easing.min.js',
      'jquery.tablesorter.min.js']
  end
  
  def shorten( object )
    return object if object.length < 25 
		object[0..24] + " ..."
  end#shorten

  def current_user
    #@user = User.find_by_login(session[:cas_user])
    User.find_by_login(session[:cas_user])
  end

  def authorized
    unless current_user.is_admin
      flash[:notice] = "This feature requires elevated credentials."
      redirect_to user_url(current_user)  
    end
  end

end
