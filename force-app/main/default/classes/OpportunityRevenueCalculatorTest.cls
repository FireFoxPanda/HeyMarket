@isTest
public class OpportunityRevenueCalculatorTest {

    // Test setup method to create data
    @testSetup
    static void setupTestData() {
        // Create test Product
        Product2 testProduct = new Product2(Name = 'Test Product', IsActive = true);
        insert testProduct;
        
       		 Id pricebookId = Test.getStandardPricebookId();
			Pricebook2 standardPricebook = new Pricebook2(
    			Id = pricebookId,
    			IsActive = true
			);
				update standardPricebook;
        
            PricebookEntry standardPriceEntry = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = testProduct.Id,
            UnitPrice = 100, 
            IsActive = true
        );
        insert standardPriceEntry;
        
        // Create test Pricebook
        Pricebook2 testPricebook = new Pricebook2(Name = 'Test Pricebook', IsActive = true);
        insert testPricebook;
        
    }

    // Test case for verifying revenue calculation and update
    @isTest
    static void testCalculateAndUpdateRevenue() {
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Pricebook2Id = [SELECT Id FROM Pricebook2 LIMIT 1].Id,
            TotalOpportunityQuantity = 5  
        );
        insert testOpportunity;
        
        Test.startTest();
        OpportunityRevenueCalculator.calculateAndUpdateRevenue(new List<Opportunity>{testOpportunity});
        Test.stopTest();
        
   
        Opportunity updatedOpportunity = [SELECT Amount FROM Opportunity WHERE Id = :testOpportunity.Id];

        System.assertEquals(500, updatedOpportunity.Amount, 'Expected revenue should be 500');
    }
}