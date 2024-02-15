trigger OpportunityTrigger on Opportunity (before update , before insert) {
    
    if(Trigger.isBefore ) {
        OpportunityTriggerHandler.updateOpportunityStage(Trigger.new);
    }

}