Feature: Clear Fields

Scenario: Clear All Fields
 
    Given the app is running
    When I clear the "LoanAmount" field
    When I clear the "Interest" field
    When I clear the "SalesTax" field
    When I clear the "Term" field
    When I clear the "DownPayment" field
    When I clear the "TradeIn" field
    When I clear the "Fees" field
    
    Then I take a screenshot called "Fields Cleared"
    
    When I enter "0" in "LoanAmount"
    When I enter "0" in "Interest"
    When I enter "0" in "SalesTax"
    When I enter "0" in "Term"
    When I enter "0" in "DownPayment"
    When I enter "0" in "TradeIn"
    When I enter "0" in "Fees"
    
    Then I take a screenshot called "Test Complete"
    Then I should see "NaN" in the "TotalLoanAmount" label
    

