Given('I have an account with a link') do
  step 'I am signed in'
  step 'I click the New Link button'
  step 'I enter link info into the form'
  step 'I click the Create button'
end

When('I enter link info into the form') do
  fill_in 'destination', with: 'http://imgur.com/gallery/4AiXzf8'
  fill_in 'title', with: 'cash cat'
  fill_in 'slashtag', with: 'cash-cat'
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
