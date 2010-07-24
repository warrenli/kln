Given /^(?:|I )I choose (.+)$/ do |language_name|
  visit path_to(language_name)
end

Given /^I am a registered user with email "([^"]*)"$/ do |email_address|
  user = User.create!( :email => "#{email_address}", :password => "password" )
  user.confirm!
end

Given /^I have logged in as "([^"]*)"$/ do |email_address|
  Given %{I go to the sign in page}
  And %{I fill in "Email" with "#{email_address}"}
  And %{I fill in "Password" with "password"}
  And %{I press "Sign in"}
  Then %{I should see "Signed in successfully"}
  @current_user = User.find_by_email("#{email_address}")
end

