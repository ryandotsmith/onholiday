Feature: Calculating holidays during a one year period
  As a manager
  I want to look at my team's holiday time w.r.t. the current year
  So that I can properly assess their performance

  Background: Authentication
    Given I am signed in
  Scenario: Looking at this years holidays
    Given an employee exists with 10 days of vacation available
    And the employe has taken 4 days off this year
    And the employe had taken 4 days off last year
    When I am on the user index page
    Then I should see "4.0 / 10"
