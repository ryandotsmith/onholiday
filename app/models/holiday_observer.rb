class HolidayObserver < ActiveRecord::Observer

  def before_validation( holiday )
    holiday.adjust_time!( holiday.leave_length )
    holiday.sanitize_input!
  end

  def before_destroy( holiday )
    Holiday.send_later( :update_calendar, holiday, :create )
  end

end