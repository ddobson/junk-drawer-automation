Given(/^I am on the homepage$/) do
  visit Capybara.app_host
end

When(/^I click the login button$/) do
  click_link 'Sign In'
end

When(/^I enter my user credentials$/) do
  fill_in 'email', :with => ENV['EMAIL']
  fill_in 'password', :with => ENV['PASSWORD']
end

When(/^I click to log in$/) do
  click_button 'Sign In'
end

Then(/^I should be logged in$/) do
  expect(page).to have_current_path('/dashboard')
  expect(page).to have_content('Sign Out')
end
