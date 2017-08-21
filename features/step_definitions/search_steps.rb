When(/^I search for (.*)$/) do |term|
  fill_in 'Search', with: term
end

Then(/^I should see (.*) results$/) do |count|
  case count
  when 'zero'
    expect(page)
      .to have_no_content("http://junk-drawer.link/#{@unique_user}-cash-cat")
    expect(page)
      .to have_no_content("http://junk-drawer.link/#{@unique_user}-cash-dog")
  when 'one'
    expect(page)
      .to have_no_content("http://junk-drawer.link/#{@unique_user}-cash-cat")
    expect(page)
      .to have_content("http://junk-drawer.link/#{@unique_user}-cash-dog")
  when 'two'
    expect(page)
      .to have_content("http://junk-drawer.link/#{@unique_user}-cash-cat")
    expect(page)
      .to have_content("http://junk-drawer.link/#{@unique_user}-cash-dog")
  end
end
