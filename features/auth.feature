Feature: User Authentication
  Users should be able to sign up, sign out, sign in
  Users should see appropriate error messages when validations fail
  Users should not proceed to dashboard when validations fail

# Happy path tests
Scenario: User sign up
  Given I am on the homepage
  When I click the Sign Up link
    And I enter my new user credentials
    And I click to Sign Up
  Then I should be signed in

Scenario: User sign out
  Given I am signed in
  When I click the Sign Out link
  Then I should be signed out

Scenario: User sign in
  Given I have a user account
  When I click the Sign In link
    And I enter my user credentials
    And I click to Sign In
  Then I should be signed in
