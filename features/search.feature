Feature: Search
  Users should be able to search within their links

Scenario Outline: Search returns no results
  Given I have an account with two links
  When I search for <term>
  Then I should see <count> results

Examples:
| term  | count |
| bird  | zero  |
| dog   | one   |
| cash  | two   |
