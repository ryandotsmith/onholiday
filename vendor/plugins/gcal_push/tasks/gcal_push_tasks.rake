require File.dirname(__FILE__) + '/../../../../config/boot.rb'
require File.dirname(__FILE__) + '/../../../../config/environment.rb'

namespace :gcal do

  desc "push all holidays to calendar"
  task :push_all, :cal do |t,args|
    Holiday.find_all_by_state(1).each do |h|
        h.push_to_calendar( args.cal )
        puts "pushed #{h.id}"
    end#for
  end#task
  
  desc "delete all events from calendar"
  task :delete_all, :cal  do |t, args|
    @file = YAML.load( File.open("#{RAILS_ROOT}/config/gcal.yml") )
    @usr  = @file['default']['username']
    @pwd  = @file['default']['password']
    pusher    = Gcal::Pusher.new( @usr, @pwd )
    calendar  = Gcal::Calendar.find( pusher.client, pusher.username, args.cal )
    events    = Gcal::Event.all( pusher, calendar )
    events.each do |e| 
      pusher.remove_event( e ) 
      puts "."
    end
  end

end#namespace