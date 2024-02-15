trigger LeadValidationTrigger on Lead (before update,after insert , before insert) {
    if (Trigger.isUpdate && Trigger.isBefore) {
        List<Lead> leadsToConvert = new List<Lead>();
        for (Lead lead : Trigger.new) {
            if (lead.IsConverted && !Trigger.oldMap.get(lead.Id).IsConverted) {
                leadsToConvert.add(lead);
            }
        }
        if (!leadsToConvert.isEmpty()) {
            LeadTriggerHandler.validateLeadConversion(leadsToConvert);
        }
        
    }
    
    if (Trigger.isinsert && Trigger.isBefore) {
        LeadTriggerHandler.handleLeadAssignment(Trigger.new);
        
    }
   
}