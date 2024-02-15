public class OpportunityTriggerHandler {
    public static void updateOpportunityStage(List<Opportunity> oppsToUpdate) {
        List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
        
        for(Opportunity opp : oppsToUpdate) {
            if(opp.StageName != 'Closed Won' && opp.StageName != 'Closed Lost') {
                if(opp.CloseDate != null && opp.Amount > 10000 
                   && opp.CloseDate >= Date.today() && 
                   opp.CloseDate <= Date.today().addDays(30)) {
                    opp.StageName = 'Closing';
                    opportunitiesToUpdate.add(opp);
                }
            }
        }
        
       
    }
}