Given /^I am signed in$/ do
  user = Factory(:user)
  CASClient::Frameworks::Rails::Filter.fake("Ron")
  User.should_receive(:find_by_login).with("Ron").and_return(user)
  user.should_receive(:is_admin).and_return(true)
end

Then /^"([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  field_named(field).element.search(".//option[@selected = 'selected']").inner_html.should =~ /#{value}/
end

