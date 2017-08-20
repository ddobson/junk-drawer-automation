Given(/^I am on the (.*) page$/) do |page|
  case page
  when 'home'
    visit Capybara.app_host
  when 'sign up'
    visit "#{Capybara.app_host}/signup"
  end
end

When(/^I click the (.*) link$/) do |link|
  click_link "#{link}"
end

When(/^I click to (.*)$/) do |button|
  click_button "#{button}"
end
