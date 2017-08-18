require 'selenium-webdriver'
require 'dotenv/load'

browser = (ENV['BROWSER'] || 'chrome').downcase.to_sym

browser_capabilities = {
  'chromeOptions' => {
    'args' => ['incognito']
  }
}

Capybara.register_driver :selenium do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.send(browser, browser_capabilities)

  Capybara::Selenium::Driver.new(
    app,
    browser: browser,
    desired_capabilities: capabilities
  )
end

Capybara.default_driver = :selenium

Capybara.app_host = 'https://junk-drawer-app.herokuapp.com'
