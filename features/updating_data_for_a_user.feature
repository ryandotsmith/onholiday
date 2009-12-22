Feature: Updating data for a user
  As a manager
  I want to update the data on my users
  So that I can keep accurate HR records

  Background: Authentication
    Given I am signed in

  Scenario: Editing the hired date of a user
    Given a user exists
    When I am on the edit user page
    And I select "April 26, 2009" as the "Date of Hire" date
    And I press "update"
    Then "2009" should be selected for "user[date_of_hire(1i)]"
    And "April" should be selected for "user[date_of_hire(2i)]"
    And "26" should be selected for "user[date_of_hire(3i)]"
