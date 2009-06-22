class HolidayObserver < ActiveRecord::Observer

  def before_validation( holiday )
    holiday.adjust_time!( holiday.leave_length )
  end

  def before_destroy( holiday )
    HolidayWorker.asynch_un_publish( :holiday_id => holiday.id ) 
  end

end