Feature: Updating data for a user
  As a manager
  I want to update the data on my users
  So that I can keep accurate HR records

  Background: Authentication
    Given I am signed in

  Scenario: Editing the hired date of a user
    Given a user exists
    When I am on the edit user page
    And I select "April 26, 1982" as the "Date of Hire" date
    And I press "update"
    Then I should see "Date of Hire" as "12/15/2009"
