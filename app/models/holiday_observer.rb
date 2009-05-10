class HolidayObserver < ActiveRecord::Observer

  def before_validation( holiday )
    holiday.adjust_time!( holiday.leave_length )
  end

  def before_destroy
    self.delete_from_calendar
  end

end