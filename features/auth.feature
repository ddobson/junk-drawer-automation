Feature: User Authentication
  Users should be able to sign up, sign out, sign in
  Users should see appropriate error messages when validations fail
  Users should not proceed to dashboard when validations fail

# Happy path testing
Scenario: User sign up
  Given I am on the home page
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

# Error testing
Scenario Outline: User sign up with invalid value
  Given I am on the sign up page
  When I enter an invalid <type> sign up credential <value>
    And I click to Sign Up
  Then I should see a <error> <type> message

Examples:
| type         | value                 | error    |
| email        |                       | required |
| email        | invalid               | invalid  |
| email        | invalid@              | invalid  |
| email        | invalid.com           | invalid  |
| email        | invalid@.com          | invalid  |
| email        | invalid.gmail.com     | invalid  |
| email        | invalid@gmail         | invalid  |
| email        | @gmail.com            | invalid  |
| email        | !@#$%^&*()@gmail.com  | invalid  |
| email        | taken@email.com       | taken    |
| userName     |                       | required |
| userName     | 12345678901           | length   |
| userName     | B@con                 | invalid  |
| userName     | bad_user              | invalid  |
| userName     | more-bad              | invalid  |
| userName     |                       | required |
| userName     | taken                 | taken    |
| password     | pass                  | length   |
| passwordConf |                       | required |
| passwordConf | mismatch              | mismatch |

Scenario Outline: User sign in with invalid value
  Given I am on the sign in page
  When I enter an invalid <type> sign in credential <value>
    And I click to Sign In
  Then I should see a <error> <type> message

Examples:
| type     | value | error        |
| email    |       | required     |
| password |       | required     |
| password | wrong | unauthorized |
