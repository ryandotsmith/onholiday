module Gcal 
  def push_to_calendar
    event = GCal4Ruby::Event.new(load_calendar)
    event.title = self.user.name
    event.start = self.begin_time
    event.end   = self.end_time
    return false unless event.save
    self.event_id = event.edit_feed
    self.save
  end

  def delete_from_calendar
    event = GCal4Ruby::Event.find(load_calendar,self.event_id)
    return false unless event.delete
    self.event_id = nil
    self.save
  end

  def load_calendar
    load_service
    GCal4Ruby::Calendar.find(load_service,"onholiday").pop
  end

  def load_service
    service = GCal4Ruby::Service.new
    service.authenticate("this.ryansmith@gmail.com","$m1thert0n")
    service
  end

end
