@focus
Feature: Manage Users
  In order to manage sotaca
  As a security enthusiast
  I want to be able to edit shop data only when authorized
  
  Scenario: See edit link as admin
    Given the following user records
    | username | password | admin |
    | bob      | secret   | false |
    | admin    | secret   | true  |
    And I am logged in as "admin" with password "secret"
    And I visit profile for "bob"
    Then I should see "edit profile" 
  
  Scenario: Do not show edit links to guest user
    Given the following user records
    | username   | password| admin |
    | bob        | secret  | false |
    | admin      | secret  | true  |
    When I visit profile for "bob"
    Then I should not see "Edit Profile"
    
  Scenario: Show edit link as owner
    Given the following user records
      | username | password | admin |
      | bob      | secret   | false |
      | admin    | secret   | true  |
      And I am logged in as "bob" with password "secret"
      When I visit profile for "bob"
      Then I should see "Edit Profile"
  
  Scenario: Hide edit to not admin or owner
    Given the following user records
      | username | password | admin |
      | bob      | secret   | false |
      | admin    | secret   | true  |
      And I am logged in as "bob" with password "secret"
      When I visit profile for "admin"
      Then I should not see "Edit Profile"
  
  
  Scenario: Raise exception when accessing the edit url directly
  
  
  
  