class HolidayObserver < ActiveRecord::Observer

  def before_validation( holiday )
    holiday.adjust_time!( holiday.leave_length )
    holiday.sanitize_input!
  end

  def before_destroy( holiday )
    if holiday.approved?
      holiday.delete_from_calendar
    end
  end

end
