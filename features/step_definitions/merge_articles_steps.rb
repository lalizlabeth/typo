Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create!(article)
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

When /^I (re)?visit the edit page for "(.*)"$/ do |re, title|
  visit 'admin/content/edit/' + Article.find_by_title(title).id.to_s
end

When /^I attempt to merge with "(.*)"$/ do |title|
  if Article.find_by_title(title)
    article_id = Article.find_by_title(title).id
  end
  fill_in 'merge_with', :with => article_id
  click_button 'Merge'
end