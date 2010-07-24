# encoding: utf-8

假設 /^系統己存下列文章:$/ do |posts|
  @current_user.posts.create(posts.hashes)
  #Post.create!(posts.hashes)
end

那麼 /^我看到一個文章列表$/ do |expected_table|
  html_table = tableish("table#posts tbody tr", "td").to_a
  html_table.map! { |r| r.map! { |c| c.gsub(/<.+?>/, '') } }
  expected_table.diff!(html_table)
end

當 /^我刪除第(\d+)個文章$/ do |pos|
  visit posts_path
  within("table tr:nth-child(#{pos.to_i})") do
    click_link "消除"
  end
end

