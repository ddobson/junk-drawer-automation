Feature: Links
  Users should be able to add, delete, and copy a link
  Users should be able to view and hide link details

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
