require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "retrieving calendars from puhser's google account" do
  before(:each) do
    @file = YAML.load( File.open("#{RAILS_ROOT}/config/gcal.yml") )
    @user = @file['default']['username']
    @pwd  = @file['default']['password']
  end

  it "should get a list of calendars owned by the pusher" do
    pusher    = Gcal::Pusher.new( @user, @pwd )
    calendars = Gcal::Calendar.all( pusher.client, pusher.username )
    calendars.each { |cal| cal.class.should == Gcal::Calendar }
  end

  it "should find a pusher's calendar given the name of the calendar" do
    link = "http://www.google.com/calendar/feeds/pqo28p9na7bgkllplkkra1k0as%40group.calendar.google.com/private/full"    
    pusher    = Gcal::Pusher.new( @user, @pwd )
    calendar  = Gcal::Calendar.find( pusher.client, pusher.username, "rubytest" )
    calendar.link.should eql( link )
  end

end