public class OpportunityRevenueCalculator {
    
    // Method to calculate potential revenue and update Opportunity records
    public static void calculateAndUpdateRevenue(List<Opportunity> opportunities) {
        Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>(opportunities);
        
        Map<Id, PricebookEntry> pbeMap = getPricebookEntries(oppMap);
        
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        for (Opportunity opp : opportunities) {
            PricebookEntry pbe = pbeMap.get(opp.Pricebook2Id);
            if (pbe != null) {
                Decimal calculatedRevenue = calculateRevenue(pbe.UnitPrice, opp.TotalOpportunityQuantity);
                oppsToUpdate.add(updateOpportunityAmount(opp, calculatedRevenue));
            }
        }
        update oppsToUpdate;
    }
    
    // Method to retrieve PricebookEntries for the opportunities
    private static Map<Id, PricebookEntry> getPricebookEntries(Map<Id, Opportunity> opportunities) {
        Set<Id> pricebookIds = new Set<Id>();
        for (Opportunity opp : opportunities.values()) {
            pricebookIds.add(opp.Pricebook2Id);
        }
        
        Map<Id, PricebookEntry> pbeMap = new Map<Id, PricebookEntry>();
        for (PricebookEntry pbe : [SELECT Id, Product2Id, UnitPrice, Pricebook2Id 
                                   FROM PricebookEntry 
                                   WHERE Pricebook2Id IN :pricebookIds]) {
            pbeMap.put(pbe.Pricebook2Id, pbe);
        }
        return pbeMap;
    }
    
    // Method to calculate potential revenue
    private static Decimal calculateRevenue(Decimal unitPrice, Decimal quantity) {
        return unitPrice * quantity;
    }
    
    // Method to update Opportunity Amount
    private static Opportunity updateOpportunityAmount(Opportunity opp, Decimal amount) {
        opp.Amount = amount;
        return opp;
    }
}