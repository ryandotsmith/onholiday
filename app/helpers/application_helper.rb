# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def get_css( controller )
    [ controller.controller_name, 
      'application',
      'tablesort/tablesort.css',
      'theme/ui.all.css',
      'table',
      'list',
      'jquery.cluetip.css' ]
  end

  def get_js( controller )
    [ :defaults,
      controller.controller_name, 
      'jquery.corners.js',
      'jquery.easing.min.js',
      'jquery.tablesorter.min.js',
      'jquery.cluetip.js']
  end
  
  def shorten( attr , len=24)
    attr.length <= len ? attr : attr[0..len] + "... "  
  end#shorten

  def n_a_ify( string )
    string.length.zero? ? %W( NA ) : string
  end
  
  def date_ify( date )
    date.strftime('%m/%d/%Y')
  end

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
