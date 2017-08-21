Given('I have an account with a link') do
  step 'I am signed in'
  step 'I click the New Link button'
  step 'I enter link info into the form'
  step 'I click the Create button'
end

Given('I have an account with two links') do
  step 'I have an account with a link'
  step 'I click the New Link button'
  step 'I enter dog info into the form'
  step 'I click the Create button'
end

When('I enter dog info into the form') do
  fill_in 'destination', with: 'http://imgur.com/gallery/znQXt'
  fill_in 'title', with: 'cash dog'
  fill_in 'slashtag', with: 'cash-dog'
end

When('I enter link info into the form') do
  step 'I enter a valid destination detail'
  step 'I enter a valid title detail'
  step 'I enter a valid slashtag detail'
end

When(/^I enter invalid link (.*) with value (.*)$/) do |invalid_type, value|
  link_inputs = ['destination', 'title', 'slashtag']
  link_inputs.delete(invalid_type)

  value = Array.new(256, 'a').join if value == 'very_long_string'

  fill_in invalid_type, with: value

  link_inputs.each do |link_input|
    step "I enter a valid #{link_input} detail"
  end
end

When(/^I enter a valid (.*) detail$/) do |type|
  case type
  when 'destination'
    fill_in 'destination', with: 'http://imgur.com/gallery/4AiXzf8'
  when 'title'
    fill_in 'title', with: 'cash cat'
  when 'slashtag'
    fill_in 'slashtag', with: 'cash-cat'
  end
end

When(/^I click the (.*) icon/) do |type|
  case type
  when 'content arrow'
    find('.icon.angle-icon').click
  when 'delete'
    find(:xpath, "//span[@aria-label='Delete']").click
  when 'copy'
    find(:xpath, "//span[@aria-label='Copy to clipboard']").click
  end
end

Then('I should see the link') do
  expect(page)
    .to have_content("http://junk-drawer.link/#{@unique_user}-cash-cat")
end

Then('I should not see the link') do
  expect(page)
    .to have_no_content("http://junk-drawer.link/#{@unique_user}-cash-cat")
end

Then('I should see link details') do
  expect(page).to have_content('cash cat')
  expect(page).to have_content('http://imgur.com/gallery/4AiXzf8')
end

Then('I should not see link details') do
  expect(page).to have_no_content('cash cat')
  expect(page).to have_no_content('http://imgur.com/gallery/4AiXzf8')
end

Then('The link should be on my clipboard') do
  clip = Clipboard.paste
  expect(page).to have_content(clip)
end

Then(/^I should see a (.*) message for my link$/) do |type|
  case type
  when 'required destination'
    expect(page).to have_content('URL is required.')
  when 'invalid destination'
    expect(page)
      .to have_content('You must use a valid URL. "http(s)://" should be included.')
  when 'incomplete destination'
    expect(page).to have_content('Destination: Url is not valid')
  when 'required title'
    expect(page).to have_content('Title is required.')
  when 'invalid title'
    expect(page).to have_content('Titles must be 3 - 255 characters.')
  when 'required slashtag'
    expect(page).to have_content('Slashtag is required.')
  when 'invalid slashtag'
    expect(page)
      .to have_content('Slashtags may only contain alphanumeric characters, hyphens and underscores.')
  when 'lengthy slashtag'
    expect(page)
      .to have_content('Slashtag: Value cannot be greater than 50 characters')
  else
    raise StandardError, "Error of type '#{type}' was not handled"
  end
end
