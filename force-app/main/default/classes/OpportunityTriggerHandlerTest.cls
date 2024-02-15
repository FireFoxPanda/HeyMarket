@isTest
public class OpportunityTriggerHandlerTest {
    @testSetup
    static void setupTestData() {
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();

        for(Integer i=0; i<2; i++) {
            Account acc = new Account(Name='Test Account ' + i);
            accList.add(acc);
        }
        insert accList;

        for(Integer i=0; i<2; i++) {
            Opportunity opp = new Opportunity(
                Name='Test Opportunity ' + i,
                StageName='Prospecting',
                CloseDate=Date.today().addDays(20),
                Amount=15000,
                AccountId=accList[i].Id
            );
            oppList.add(opp);
        }
        insert oppList;
    }

    static testMethod void testUpdateOpportunityStage() {
        // Retrieve test opportunities with CloseDate field queried
        List<Opportunity> opps = [SELECT Id, StageName,Amount,Name, CloseDate,AccountId FROM Opportunity WHERE Name LIKE 'Test Opportunity%'];

        Test.startTest();
        OpportunityTriggerHandler.updateOpportunityStage(opps);
        Test.stopTest();

        List<Opportunity> updatedOpps = [SELECT StageName FROM Opportunity WHERE Id IN :opps];
        for(Opportunity opp : updatedOpps) {
            System.assertEquals('Closing', opp.StageName, 'Stage should be updated to Closing');
        }
    }
}