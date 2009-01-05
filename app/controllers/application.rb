# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include ApplicationHelper
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  #:secret => '4f88732ee102eb78af32ee59062d4ea1'
  ####################
  #login() should get
  #=>
  # and should return
  #=>
  def login()
    @cas_user  = session[:cas_user]
    @cas_extra = session[:cas_extra_attributes]
    if User.verify(@cas_user,@cas_extra)
      User.update_attr(@cas_user,@cas_extra)
    else
      return false
    end
  end

  def logout
    session[:casfilteruser] = nil
    reset_session
    redirect_to "https://10.0.1.20/logout"
    #CASClient::Frameworks::Rails::Filter.logout(self)
  end
  

  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
