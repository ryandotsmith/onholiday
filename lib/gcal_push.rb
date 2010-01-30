module GCalPush
  def push_to_calendar
    event = GCal4Ruby::Event.new(calendar)
    event.title = self.user.name
    event.start = self.begin_time
    event.end   = self.end_time
    return false unless event.save
    self.event_id = event.id
    true
  end

  def delete_from_calendar
    event = GCal4Ruby::Event.find(calendar,self.event_id)
    return false unless event.delete
    self.event_id = nil
    true
  end

  def calendar
    GCal4Ruby::Calendar.find(bind_to_gcal,"onholiday",:first)
  end

  def bind_to_gcal
    @gcal_service = GCal4Ruby::Service.new
    @gcal_service.authenticate("username","password")
    @gcal_service
  end

end
