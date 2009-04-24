class HolidayObserver < ActiveRecord::Observer
  ####################
  #before_validate( holiday )
  def before_validation( holiday )
    holiday.adjust_time!( holiday.type )
  end#before_validate( holiday )
end