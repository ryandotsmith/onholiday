require 'facets/dictionary'
class Holiday < ActiveRecord::Base

  belongs_to :user
  has_many :whole_days
  has_many :half_days

  validates_presence_of :begin_time,  :message => "please specify beginning time"
  validates_presence_of :description, :message => "please add a descirption"

  validate :prohibit_time_travel
  validate_on_create :not_nice_twice
  
  def update_hook( type='whole' )
    self.begin_time = begin_time.beginning_of_day
    self.end_time ||= self.begin_time
    self.end_time = end_time.end_of_day
    self.add_days(type)
  end

  ####################
  #self.get_leave_ratio should get
  #=>
  # and should return
  #=>
  def self.get_leave_ratio
    max   = User.get_total_holiday_time
    taken = Holiday.get_taken_leave
    max / taken
  end

  ####################
  #self.get_remaining_leave should get
  #=>
  # and should return
  #=>
  def self.get_taken_leave
    sum = 0.0
    Holiday.find(:all).each do |holiday|
      if holiday.state == 1
        sum += holiday.get_length
      end
    end
    sum
  end#def

  # ~\  hackety hack
  # until i can find a good solution for cleaning up 
  # how rails handels error messages, I will change the 
  # human readables to empty strings. 
  #=> TODO: figure out how to axe the attribute name when
  #=>       an error message is displayed in a view. 
  def self.human_attribute_name(attribute_key_name)
    if attribute_key_name.to_sym == :begin_time
      " "
    elsif attribute_key_name.to_sym == :end_time
      " "
    elsif attribute_key_name.to_sym == :description
      " "
    else
      super
    end
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
    if end_time < begin_time
      errors.add_to_base "Time travel is strictly prohibited! Correct ending date."
    end
  end
  ####################
  #not_nice_twice
  def not_nice_twice
    if in_range_of_existing
      errors.add_to_base "This request contains a day that already belongs to one of your holidays."
    end
  end#not_nice_twice
  ####################
  #in_range_of_existing
  def in_range_of_existing
    # return false if the intersection of the arrays is 0
    # return true if the requested holiday has days belonging to other holidays
    (self.user.get_list_of_dates & self.print_days_in_between) != []
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
  #approve( user ) should get called from 
  # update action in holiday controller. 
  def approve( user )
    #Postoffice.deliver_request_change( self, :approve )
    self.push_to_gcal
    self.reviewed_by = user.login
    self.reviewed_on = DateTime.now
    self.state       = 1
    self.save!
  end
  ####################
  #deny( user ) should get called from 
  # update action in holiday controller. 
  def deny( user )
    #Postoffice.deliver_request_change( self, :denied )
    self.reviewed_by = user.login
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
  def get_length
    length = 0.0
      whole_days.each { length += 1.0 }
      half_days.each { length += 0.5 }
    length
  end# end method
  
  def add_days( type )
    n = (end_time.to_datetime - begin_time.to_datetime).to_f.round
    return if n < 0
    dates = user.get_list_of_dates.uniq
    n.times do |t|
      unless dates.include?( begin_time.to_date + t.days )
        self.whole_days.build if type == 'many'
        self.whole_days.build if type == 'whole'
        self.half_days.build  if type == 'half'
      end#unless
    end#
  end#add_days

  def print_days_in_between()
    array = []
    n = (end_time.to_datetime - begin_time.to_datetime).to_f.round
    n.times do |t|
      array << ( begin_time.to_date + t.days )
    end    
    array
  end
  ####################
  #push_to_gcal
  def push_to_gcal
    ActiveCalendar::Engine.create_event :event => self
  end#push_to_gcal

end# end class
