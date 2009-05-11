class HolidayObserver < ActiveRecord::Observer

  def before_validation( holiday )
    holiday.adjust_time!( holiday.leave_length )
  end

  def before_destroy( holiday )
    holiday.delete_from_calendar if holiday.state != -1 
  end

end