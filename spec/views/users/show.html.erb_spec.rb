require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :login => "value for login"
    )
  end

  it "should render attributes in <p>" do
    render "/users/show.html.erb"
    response.should have_text(/value\ for\ login/)
  end
end

