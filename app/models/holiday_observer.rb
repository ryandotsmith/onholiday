class HolidayObserver < ActiveRecord::Observer

  ####################
  #before_validate( holiday )
  def before_validation( holiday )
    holiday.adjust_time!( holiday.leave_length )
  end#before_validate( holiday )

  ####################
  #before_save( holiday )
  def before_save( holiday )
  end#before_save( holiday )

end