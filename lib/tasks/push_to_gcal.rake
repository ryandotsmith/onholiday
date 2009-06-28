namespace :utils do

  desc "push all holidays to calendar"
  task(:push_all => :environment) do
    threads = []
    for holiday in Holiday.find_all_by_state(1)
      threads << Thread.new(holiday)  do |h|
        h.push_to_calendar
        puts "pushed #{h.id}"
      end#do
    end#for

    threads.each { |aThread|  aThread.join }
  end#task
  
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