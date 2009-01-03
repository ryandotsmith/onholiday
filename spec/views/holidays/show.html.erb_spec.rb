require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/holidays/show.html.erb" do
  include HolidaysHelper
  
  before(:each) do
    assigns[:holiday] = @holiday = stub_model(Holiday,
      :approved_by => "value for approved_by"
    )
  end

  it "should render attributes in <p>" do
    render "/holidays/show.html.erb"
    response.should have_text(/value\ for\ approved_by/)
  end
end

