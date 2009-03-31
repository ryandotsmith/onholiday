namespace :utils do

  desc "push all holidays to calendar"
  task(:push_all => :environment) do
    for holiday in Holiday.find_all_by_state(1)
      puts "pushing #{holiday.user.name}"
      holiday.push_to_calendar
    end
  end
  
  desc "delete all events from calendar"
  task(:delete_all => :environment)do
    TFT::GcalPush::Base.new(:calendar =>  'onholiday')
    TFT::GcalPush::Calendar.get_calendars.each { |c| @calendar = c if c.title == 'onholiday' }
    TFT::GcalPush::Event.load( @calendar )
    TFT::GcalPush::Event.get_events.each do |e|
      puts "deleting #{e.title}"
      TFT::GcalPush::Event.delete( e )
    end
  end

end#namespace