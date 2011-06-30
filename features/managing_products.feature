Feature: managing products
  
  In order to run sotaca webshop
  As the shop manager of sotaca
  I want to be able to manage products
  
  Scenario: list of products
    Given I have products titled TShirt, Skirt
    When I go to the list of products
    Then I should see "TShirt"
    And I should see "Skirt"
  
  Scenario: adding a valid product
    Given I have no products
    And I am on the list of products
    When I follow "New Product"
    And I fill in "product_title" with "bacon"
    And I fill in "product_price" with "10"
    And I press "Create"
    Then I should see "Successfully created product."
    And I should see "bacon"
    And I should see "10.00"
    And I should have 1 product
    
    Scenario: adding a invalid product
      Given I have no products
      And I am on the list of products
      When I follow "New Product"
      And I fill in "product_title" with ""
      And I fill in "product_price" with "AB"
      And I press "Create"
      And I should see "error"


  
  
