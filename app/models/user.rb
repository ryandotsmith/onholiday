class User < ActiveRecord::Base
  has_many :holidays
  validates_uniqueness_of :login
  ####################
  #verify should get
  #=> a string that represents a user login.
  # => this comes from the session[:casuser]
  # => once the user is authenticated we need to see
  # => if the user is in the applications User table.
  # => 
  # and should return
  #=>  TRUE if the user is already in the table  
  # => USER if user was added to the table
  # => FALSE if the user was not able to be added to the table.
  # => (false)? I do not see how this could ever happen (maybe if there is a DB error)
  def self.verify( user,credentials )
    if user.nil? or credentials.nil?
      return false
    end
    user = user.to_s    
    if User.find_by_login(user)
      return true
    else
      User.create!( :login => user, 
                :name => credentials['cn'], 
                :email => credentials['mail'])
      return user
    end#end if 
  end#end verify()


end
