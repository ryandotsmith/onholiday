class Holiday < ActiveRecord::Base
  belongs_to :user
  ####################
  #self.get_holiday_types should get
  #=> called from a Holiday class
  # and should return
  #=> the following array IN ORDER! 
  def self.get_holiday_types
    ["etc","personal","vacation"]  
  end
  ####################
  #get_pending should get called from a holiday
  #=>
  # and should return all holidays that have state == 0
  # by default new holidays are set to state == 0
  #=>
  def self.get_pending
    Holiday.find_all_by_state(0).to_a
  end
  ####################
  #approve( user ) should get
  #=>
  # and should return
  #=>
  def approve( user )
    self.reviewed_by = user.login
    self.reviewed_on = DateTime.now
    self.state       = 1
    self.save
  end
  ####################
  #deny( user ) should get
  #=>
  # and should return
  #=>
  def deny( user )
    self.reviewed_by = user.login
    self.reviewed_on = DateTime.now
    self.state       = -1
    self.save
  end

  ####################
  #adjust_half_day should get
  #=>
  # and should return
  #=>
  def adjust_half_day
    self.end_time = (self.begin_time + 5.hours)
    self.save!
  end#end method
  ####################
  #adjust_whole_day should get
  #=>
  # and should return
  #=>
  def adjust_whole_day
    self.end_time = (self.begin_time + 24.hours)
    self.save!
  end
  ####################
  #get_length should get
  #=>
  # and should return
  #=>
  def get_length
    delta = (self.end_time.to_datetime - self.begin_time.to_datetime).to_f
    if  delta <= 0.5
      return 0.5
    end #end if
    delta.to_f.round
  end# end method

end# end class
