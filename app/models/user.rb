class User < ActiveRecord::Base
  has_many :holidays
  validates_uniqueness_of :login
  
  ####################
  #list_admins should get
  #=>
  # and should return
  #=>
  def self.list_admins
    ["rsmith","dpanjada","csmith","gsmith"]
  end
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
  ####################
  #update_attr(user, credentials) should get
  #=>
  # and should return
  #=>
  def self.update_attr(user, credentials)
    u = User.find_by_login(user)
    u.email = credentials['mail']
    u.name  = credentials['cn']
    if User.list_admins.include?(u.login.to_s)
      u.is_admin = true
    end
    u.save!
  end
  ####################
  #get_total_holiday_time should get
  #=>
  # and should return
  #=>
  def get_total_holiday_time
      total_time = 0
      holidays.each do |holiday|
        total_time += holiday.get_length
      end# end do
      total_time
  end#end method
  ####################
  #get_remaining_holiday_time should get
  #=>
  # and should return
  #=>
  def get_remaining_holiday_time
    results = Hash.new
    Holiday.get_holiday_types.each {|t| results[t.to_sym] = self.send("max_#{t}")}
    holidays.each do |holiday|
      results[holiday.leave_type.to_sym] -= holiday.get_length if holiday.state == 1
    end#end do
    results
  end#end method
end# end class