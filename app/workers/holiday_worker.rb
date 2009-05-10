class HolidayWorker < Workling::Base 

  ####################
  #publish
  def publish( options )
    holiday = Holiday.find( options[:holiday_id] )
    holiday.push_to_calendar
  end#publish

end