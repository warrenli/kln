# encoding: utf-8

假設 /^(?:|I )選用 (.+)$/ do |language_name|
  visit path_to(language_name)
end

假設 /^我是一位登記用戶電郵地址是"([^"]*)"$/ do |email_address|
  user = User.create!( :email => "#{email_address}", :password => "password" )
  user.confirm!
end

假設 /^我已使用電郵地址"([^"]*)"登入系統$/ do |email_address|
  Given %{I go to the sign in page}
  And %{I fill in "電子郵件" with "#{email_address}"}
  And %{I fill in "帳戶密碼" with "password"}
  And %{I press "Sign in"}
  Then %{I should see "登錄成功。"}
  @current_user = User.find_by_email("#{email_address}")
end

