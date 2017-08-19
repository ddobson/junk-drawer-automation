Given('I am on the homepage') do
  visit Capybara.app_host
end

Given('I am signed in') do
  step 'I am on the homepage'
  step 'I click the Sign Up link'
  step 'I enter my new user credentials'
  step 'I click to Sign Up'
end

Given('I have a user account') do
  step 'I am signed in'
  step 'I click the Sign Out link'
end

When(/^I click the (.*) link$/) do |link|
  click_link "#{link}"
end

When(/^I enter my (.*) credentials$/) do |user|
  if user == 'new user'
    @username = Time.new.to_i.to_s
    @email = "#{@username}@qa.com"

    fill_in 'userName', with: @username
    fill_in 'passwordConf', with: ENV['PASSWORD']
  end

  fill_in 'email', :with => @email
  fill_in 'password', :with => ENV['PASSWORD']
end

When(/^I click to (.*)$/) do |button|
  click_button "#{button}"
end

Then('I should be signed in') do
  expect(page).to have_current_path('/dashboard')
  expect(page).to have_content('Sign Out')
end

Then('I should be signed out') do
  expect(page).to have_current_path('/')
  expect(page).to have_content('Sign Up')
  expect(page).to have_content('Sign In')
end
