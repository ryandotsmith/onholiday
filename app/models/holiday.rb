class Holiday < ActiveRecord::Base
  # 0.1875 != 0.5 , nevertheless, these calculations were decided
  # to be accurate based upon our business logic. 
  HALF_DAY  = 0.1875
  WHOLE_DAY = 0.3958
  RAILS_ENV == "production" ? calendar = "onholiday" : calendar = "rubytest"

  pushes_to_gcal  :calendar         =>  calendar, 
                  :begin_datetime   =>  :begin_time,
                  :end_datetime     =>  :end_time

  belongs_to :user
  has_many :whole_days
  has_many :half_days

  validate :prohibit_time_travel
  validate_on_create :not_nice_twice

  validates_presence_of :begin_time,  :message => "please specify beginning time"
  validates_presence_of :description, :message => "please add a descirption"

  # i expect search to only be called in code when the search parameter 
  # is built. I am not ready to have the search parameter be user input.
  def self.search(search, page)
    user = User.find_by_login(search)
    return paginate( :per_page => 20, :page => page,:order => "created_at DESC" ) if user.nil?
    paginate :per_page => 20, :page => page,
             :conditions => ['user_id like ?', "%#{user.id}%"], :order => 'user_id'
  end
 
  ####################
  #self.get_leave_ratio 
  def self.get_leave_ratio
    max   = User.get_total_holiday_time()
    taken = Holiday.get_taken_leave()
    max / taken
  end

  ####################
  #self.get_remaining_leave should get
  def self.get_taken_leave()
    sum = 0.0
    Holiday.find(:all).each do |holiday|
      if holiday.state == 1
        sum += holiday.get_length()
      end
    end
    sum
  end#def
    
  ####################
  #self.get_holiday_types should get
  #=> called from a Holiday class
  # and should return
  #=> the following array IN ORDER! 
  def self.get_holiday_types
    ["etc","personal","vacation"]  
  end

  ####################
  #prohibit_time_travel 
  def prohibit_time_travel
    errors.add_to_base "Time travel is strictly prohibited! Correct ending date." if
      !begin_time.nil? and end_time < begin_time
  end
 
  ####################
  #not_nice_twice
  def not_nice_twice
    errors.add_to_base "This request contains a day that already belongs to one of your holidays." if
      !begin_time.nil? and in_range_of_existing
  end#not_nice_twice
 
  ####################
  #in_range_of_existing
  def in_range_of_existing
    # return false if the intersection of the arrays is 0
    # return true if the requested holiday has days belonging to other holidays
    (self.user.get_list_of_dates & self.included_dates) != []
  end#in_range_of_existing

  ####################
  #get_pending should get called from a holiday
  # and should return all holidays that have state == 0
  # by default new holidays are set to state == 0
  #=>
  def self.get_pending
    Holiday.find_all_by_state(0).to_a
  end
  ####################
  #approve
  # update action in holiday controller. 
  def approve( current_user )
    #Postoffice.deliver_request_change( self, :approve )
    HolidayWorker.asynch_publish( :holiday_id => self.id ) 
    self.reviewed_by = current_user.login
    self.reviewed_on = DateTime.now
    self.state       = 1
    self.save!
  end
  ####################
  #deny
  # update action in holiday controller. 
  # current_user should be an "admin" since 
  def deny( current_user )
    #Postoffice.deliver_request_change( self, :denied )
    self.reviewed_by = current_user.login
    self.reviewed_on = DateTime.now
    self.state       = -1
    self.save!
  end
  ####################
  # get_length should get called any time that you need
  # to display the length of a holiday. Since the DB only 
  # holds a begin and end DateTime, you can add methods similar to this one 
  # to represent holiday length in a view. 
  #
  # This particular method will subtract the dates (which will yield the diff in sec)
  # and then convert the difference to a float.
  def get_length()
    length      = 0.0
    difference  = ( self.end_time.to_datetime - self.begin_time.to_datetime).to_f
    # approx is a monkey patch ( look-out! ). it uses the concept of epsilon math. 
    if difference.approx( HALF_DAY, 0.01)
      length = 0.5
    elsif difference.approx( WHOLE_DAY, 0.01)
      length = 1.0
    else 
      self.included_dates.each {|date| length += 1.0 if date.working_day? }
    end
    length
  end# end method

  ####################
  #adjust_time
  def adjust_time!( type )
    return if self.begin_time.nil?
    case type
    when 'half'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7,  :min => 30 )
      self.end_time   = self.begin_time.to_datetime.change( :hour => 12, :min => 00 )
    when 'whole'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7, :min => 30 )
      self.end_time   = self.begin_time.to_datetime.change( :hour => 17, :min => 00 )
    when 'many'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7, :min => 30 )
      self.end_time   = self.end_time.to_datetime.change( :hour => 17, :min => 00 )
    end
  end#adjust_time

  ####################
  #included_dates
  #  returns a list of dates that are 
  #  the days between and including the begin_time and end_time
  def included_dates
    array = []
    begin_time.to_date.upto(end_time.to_date) do |date|
      array << date if date.working_day?
    end
    array
  end#included_dates
  
end# end class
