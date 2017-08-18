Feature: Authentication

Scenario: User login
  Given I am on the homepage
  When I click the login button
    And I enter my user credentials
    And I click to log in
  Then I should be logged in
