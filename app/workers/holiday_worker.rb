class HolidayWorker < Workling::Base 

  ####################
  #publish
  def publish( options )
    logger.info("Pushing holiday ##{ options[:holiday_id] }")
    holiday = Holiday.find( options[:holiday_id] )
    holiday.push_to_calendar
  end#publish
  
  def un_publish( options )
    logger.info("Pushing holiday ##{ options[:holiday_id] }")
    holiday = Holiday.find( options[:holiday_id] )
    holiday.delete_from_calendar
  end

end