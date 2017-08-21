Given('I am signed in') do
  step 'I am on the home page'
  step 'I click the Sign Up link'
  step 'I enter my new user credentials'
  step 'I click the Sign Up button'
end

Given('I have a user account') do
  step 'I am signed in'
  step 'I click the Sign Out link'
end

When(/^I enter my (.*) credentials$/) do |user|
  if user == 'new user'
    @unique_user = Time.new.to_i.to_s

    step 'I enter a valid userName credential'
    step 'I enter a valid passwordConf credential'
  end

  step 'I enter a valid email credential'
  step 'I enter a valid password credential'
end

When(/^I enter an invalid (.*) sign (.*) credential (.*)$/) do |invalid_type, page, value|
  @unique_user = Time.new.to_i.to_s

  credential_types = ['email', 'userName', 'password', 'passwordConf']
  credential_types.delete(invalid_type)
  if page == 'in'
    credential_types.delete('userName')
    credential_types.delete('passwordConf')
  end

  fill_in invalid_type, with: value

  credential_types.each do |credential_type|
    step "I enter a valid #{credential_type} credential"
  end
end

When(/^I enter a valid (.*) credential$/) do |type|
  case type
  when 'password'
    fill_in 'password', with: ENV['PASSWORD']
  when 'passwordConf'
    fill_in 'passwordConf', with: ENV['PASSWORD']
  when 'userName'
    fill_in 'userName', with: @unique_user
  when 'email'
    @email = "#{@unique_user}@qa.com"
    fill_in 'email', with: @email
  end
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

Then(/^I should see a (.*) message$/) do |type|
  case type
  when /^required (.*)$/
    expect(page).to have_content('Required')
  when /^taken (.*)$/
    expect(page).to have_selector('div.notification.is-danger')
    expect(page).to have_content('is already in use')
  when 'invalid email'
    expect(page).to have_content('Invalid Email Address')
  when 'length userName'
    expect(page)
      .to have_content('Usernames have a maximum character limit of 10')
  when 'invalid userName'
    expect(page)
      .to have_content('Usernames may only contain alphanumeric characters')
  when 'length password'
    expect(page).to have_content('Password must be at least 8 characters')
  when 'unauthorized password'
    expect(page).to have_content('Unauthorized')
  when 'mismatch passwordConf'
    expect(page).to have_content('Password confirmation must match password')
  else
    raise StandardError, "Error of type '#{type}' was not handled"
  end
end
