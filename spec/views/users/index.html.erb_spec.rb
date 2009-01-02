require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :login => "value for login"
      ),
      stub_model(User,
        :login => "value for login"
      )
    ]
  end

  it "should render list of users" do
    render "/users/index.html.erb"
    response.should have_tag("tr>td", "value for login", 2)
  end
end

