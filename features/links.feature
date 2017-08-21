Feature: Links
  Users should be able to add, delete, and copy a link
  Users should be able to view and hide link details
  Users should see appropriate error messages when validations fail

# Happy path testing
Scenario: Add a link
  Given I am signed in
  When I click the New Link button
    And I enter link info into the form
    And I click the Create button
  Then I should see the link

Scenario: View a link's details
  Given I have an account with a link
  When I click the content arrow icon
  Then I should see link details

Scenario: Hide a link's details
  Given I have an account with a link
  When I click the content arrow icon
    And I click the content arrow icon again
  Then I should not see link details

Scenario: Delete a link
  Given I have an account with a link
  When I click the delete icon
  Then I should not see the link

Scenario: Copy a link's address
  Given I have an account with a link
  When I click the copy icon
  Then The link should be on my clipboard

  # Error testing
  Scenario Outline: Add an invalid link
    Given I am signed in
    When I click the New Link button
      And I enter invalid link <detail> with value <value>
      And I click the Create button
    Then I should see a <error> <detail> message for my link

  Examples:
  | detail      | value                     | error       |
  | destination |                           | required    |
  | destination | imgur.com/gallery/4AiXzf8 | invalid     |
  | destination | http://                   | invalid     |
  | destination | imgur                     | invalid     |
  | destination | www.google.com            | incomplete  |
  | title       |                           | required    |
  | title       | 1                         | invalid     |
  | title       | very_long_string          | invalid     |
  | slashtag    |                           | required    |
  | slashtag    | -hyphen                   | invalid     |
  | slashtag    | two words                 | invalid     |
  | slashtag    | special!@#$%^&*()chars    | invalid     |
  | slashtag    | very_long_string          | lengthy     |
