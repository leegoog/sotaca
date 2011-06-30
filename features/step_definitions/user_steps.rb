Given /^the following (.+) records?$/ do |factory, table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    Factory(factory, hash)
  end 
end

Given /^I am logged in as "([^"]*)" with password "([^"]*)"$/ do |username, password|
  visit new_user_session_path
  fill_in "user_login", :with => username
  fill_in "user_password", :with => password
  click_button "Log in"
end

Given /^I visit profile for "([^"]*)"$/ do |name|
 user = User.find_by_username!(name)
 visit user_url(user)
end
