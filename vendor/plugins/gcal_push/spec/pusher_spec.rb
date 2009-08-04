require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe "establishing connection" do

  before(:each) do
    @file = YAML.load( File.open("#{RAILS_ROOT}/config/gcal.yml") )
    @user = @file['default']['username']
    @pwd  = @file['default']['password']
  end

  it "should create a new object and store the pusher's default calendar" do
    pusher = Gcal::Pusher.new( @user, @pwd )
  end

  it "should raise exception if the client can not login" do
    lambda { Gcal::Pusher.new( @user, "badpassword" ) }.should raise_error
  end
  
  

end

describe "pushing an event to the calendar" do
  before(:each) do
    @file = YAML.load( File.open("#{RAILS_ROOT}/config/gcal.yml") )
    @user = @file['default']['username']
    @pwd  = @file['default']['password']

    @holiday = OpenStruct.new
    @holiday.should_receive(:user).any_number_of_times.and_return( OpenStruct.new )
    @holiday.should_receive(:id).any_number_of_times.and_return( 31 )
    @holiday.begin_time   = DateTime.now
    @holiday.end_time     = DateTime.now + 3.days
    @holiday.user.name    = "rsmith"
    @holiday.description  = "desc"

  end

  it "should send a post request to the GCal object" do
    calendar  = mock( Gcal::Calendar )
    event     = mock( Gcal::Event    )
    client    = mock( GData::Client::Calendar )

    client.should_receive(:clientlogin).and_return(true)
    GData::Client::Calendar.should_receive(:new).and_return( client )
    pusher = Gcal::Pusher.new( @user, @pwd )
    pusher.client.should_receive(:post)
    calendar.should_receive(:link)
    event.should_receive(:to_xml)
    pusher.send_event( calendar, event )
  end

end

describe "removing an event from the calendar" do
  
end


