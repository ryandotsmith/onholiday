Given /^I am signed in$/ do
  admin_user = Factory(:user)
  CASClient::Frameworks::Rails::Filter.fake("Ron")
  User.should_receive(:find_by_login).with("Ron").and_return(admin_user)
  admin_user.should_receive(:is_admin).and_return(true)
end

Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  field_named(field).element.search(".//option[@selected = 'selected']").inner_html.should =~ /#{value}/
end

Given /^an employee exists with a start date of last month$/ do
  @user = Factory(:user, :date_of_hire => Date.today - 1.month)
end

Given /^an employee exists$/ do
  @user = Factory(:user)
end

Given /^an employee exists with 10 days of vacation available$/ do
  @user = Factory(:user, :max_vacation => 10)
end

Given /^the employe has taken 4 days off this year$/ do
  this_year = Date.new(2010,1,4) #monday
  @holiday = Factory(:holiday, :user => @user, :begin_time => this_year, :end_time =>this_year + 3.days)
  @holiday.state = 1
  @holiday.save!
end

Given /^the employe had taken 4 days off last year$/ do
  last_year = Date.new(2009,1,19) #monday
  @holiday = Factory(:holiday, :user => @user, :begin_time => last_year, :end_time => last_year + 3.days)
  @holiday.state = 1
  @holiday.save!
end


