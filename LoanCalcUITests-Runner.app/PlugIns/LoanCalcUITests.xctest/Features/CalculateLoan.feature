Feature: Calculate Loan Amount

Scenario: Calculate Loan Amount
 
    Given the app is running
    When I enter "15550" in "LoanAmount"
    Then I take a screenshot called "LoanAmount Entered"
    When I enter "2" in "Interest"
    When I enter "2" in "SalesTax"
    When I enter "60" in "Term"
    When I enter "20" in "DownPayment"
    Then I take a screenshot called "DownPayment Entered"
    When I enter "20" in "TradeIn"
    When I enter "10" in "Fees"
    Then I take a screenshot called "Test Complete"
    Then I should see "16688.50" in the "TotalLoanAmount" label
    

