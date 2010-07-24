Given /^the following posts:$/ do |posts|
  @current_user.posts.create(posts.hashes)
  #Post.create!(posts.hashes)
end

Then /^I should see posts table$/ do |expected_table|
  html_table = tableish("table#posts tbody tr", "td").to_a
  html_table.map! { |r| r.map! { |c| c.gsub(/<.+?>/, '') } }
  expected_table.diff!(html_table)
end

When /^I delete the (\d+)(?:st|nd|rd|th) post$/ do |pos|
  visit posts_path
  within("table tr:nth-child(#{pos.to_i})") do
    click_link "Destroy"
  end
end

