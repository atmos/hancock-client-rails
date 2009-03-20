Feature: Signing Up for an SSO Account
  In order to get users involved
  As a new user
  Scenario: Signing Up
    When I request a page on the Site
    And I am redirected to the SSO Server
    Then I should click the signup button
    When the page loads I should see a signup form
    Then I fill out the required information
    And click submit
    Then I should receive a registration URL
    When I click on the registration URL
    Then I should be prompted to enter my new password
    When I provide a new password 
    And click Am I Done Yet?
    Then I should be redirected back to the consumer application
    Then I should know a little bit about myself as a user
