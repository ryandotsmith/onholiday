require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "creating an event" do
  before(:each) do
    @holiday = OpenStruct.new
    @holiday.should_receive(:user).any_number_of_times.and_return( OpenStruct.new )
    @holiday.should_receive(:id).any_number_of_times.and_return( 1 )
    @holiday.begin_time   = DateTime.now
    @holiday.end_time     = DateTime.now + 3.days
    @holiday.user.name    = "rsmith"
    @holiday.description  = "nothing to see"
    
  end
  it "make XML for an event" do
    event = Gcal::Event.new( @holiday )
    # TODO: these strings are very similar, why will they not pass a test?
  end

end

describe "deleting and event" do
  
  it "should find the event first" do
    url = "http://www.google.com/calendar/feeds/pqo28p9na7bgkllplkkra1k0as%40group.calendar.google.com/private/full"
    calendar  = mock( Gcal::Calendar )
    pusher    = mock( Gcal::Pusher   )
    holiday   = mock( Holiday        )
    calendar.should_receive(:link).and_return( url )
    pusher.should_receive( :client    )
    pusher.should_receive( :username  ).and_return( "rsmith" )
    holiday.should_receive( :id ).and_return( 1 )
    #Gcal::Event.should_receive(:find).and_return( calendar )
    Gcal::Event.find( pusher, calendar, holiday.id )
  end

end