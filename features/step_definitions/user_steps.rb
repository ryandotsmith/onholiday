Given /^I am signed in$/ do
  CASClient::Frameworks::Rails::Filter.fake("Ron")
end

