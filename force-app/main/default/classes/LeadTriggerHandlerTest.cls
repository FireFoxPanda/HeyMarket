@isTest
public class LeadTriggerHandlerTest {
    
    @isTest
    static void testHandleLeadAssignment() {
        // Create test Sales Representative user
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User repUser = new User(
            FirstName = 'Test',
            LastName = 'Rep',
            Email = 'testrep@example.com',
            Phone = '1234567890',
            Alias = 'testrep',
            Username = 'testrep@example.com',
            ProfileId = p.Id,
            IsActive = true,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert repUser;
        
        // Create test leads
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            Lead lead = new Lead(
                FirstName = 'Test' + i,
                LastName = 'Lead' + i,
                Email = 'test' + i + '@example.com',
                Phone = '1234567890',
                Company = 'Test Company' + i,
                Status = 'Open - Not Contacted',
                OwnerId = repUser.Id
            );
            testLeads.add(lead);
        }
        insert testLeads;
        
        // Call handleLeadAssignment method
        Test.startTest();
        LeadTriggerHandler.handleLeadAssignment(testLeads);
        Test.stopTest();
        
        // Verify that leads have been assigned to a sales representative
        for (Lead lead : testLeads) {
            Lead refreshedLead = [SELECT OwnerId FROM Lead WHERE Id = :lead.Id];
            System.assertNotEquals(null, refreshedLead.OwnerId, 'Lead should be assigned to a sales representative');
        }
    } 
    
    @isTest
    static void testValidateLeadConversion() {
        // Create test leads
        List<Lead> testLeads = new List<Lead>();
        
            Lead lead = new Lead(
                FirstName = 'Test1',
                LastName = 'Lead1',
                Email = 'test1' + '@example.com',
                Phone = '1234567890',
                Company = 'Test Company1',
                Status = 'Open - Not Contacted'
            );
        
        insert lead;
        Lead lead2 = new Lead(
                FirstName = 'Test2',
                LastName = 'Lead2',
                Email = 'fff@gg.com',
                Phone = '4444444',
                Company = 'Test Company2',
                Status = 'Open - Not Contacted'
            );
            insert lead2;
         Test.startTest();
        
        Database.LeadConvert lc = new database.LeadConvert();
        lc.setLeadId(lead.id);
        lc.setDoNotCreateOpportunity(false);
        lc.setConvertedStatus('Closed - Converted');
         Database.LeadConvertResult lcr = Database.convertLead(lc);

        Test.stopTest(); 

    
        
    }

}