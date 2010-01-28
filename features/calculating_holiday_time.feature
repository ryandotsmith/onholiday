Feature: Calculating holiday time for employees
  As a manager
  I want holiday time to be calculated by a computer
  So that I do not have to waste my time doing the calculations

  Scenario: Full-time employee with less than one year of service
    Given an employee exists with a start date of last month
    And I am signed in
    When I am on the edit user page
    And I press calculate holiday time
    Then I should see:
      |vacation|personal|
      |0       |0       |

