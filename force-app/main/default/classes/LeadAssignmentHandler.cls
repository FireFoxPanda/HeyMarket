public class LeadAssignmentHandler {
    public static void assignLeads(List<Lead> newLeads) {
        // Query for active sales representatives
        List<User> salesReps = [SELECT Id, Name FROM User WHERE Profile.Name = 'Standard User' AND IsActive = true];
        
        // Map to store sales representatives and their lead counts
        Map<Id, Integer> repWorkload = new Map<Id, Integer>();
        for(User rep : salesReps) {
            repWorkload.put(rep.Id, 0);
        }
        
        // Aggregate query to count leads per sales representative
        for(AggregateResult aggResult : [SELECT OwnerId, COUNT(Id) leadsCount FROM Lead WHERE OwnerId IN :repWorkload.keySet() AND IsConverted = false GROUP BY OwnerId]) {
            Id ownerId = (Id)aggResult.get('OwnerId');
            Integer leadsCount = Integer.valueOf(aggResult.get('leadsCount'));
            repWorkload.put(ownerId, leadsCount);
        }
        
        Integer maxLeadsPerRep = 20;
        
        List<Lead> leadsToUpdate = new List<Lead>();
        
        for(Lead newLead : newLeads) {
            Id assignedRepId = null;
            Integer minLeadsCount = maxLeadsPerRep + 1;
            
            // Find the sales representative with the minimum workload
            for(Id repId : repWorkload.keySet()) {
                Integer leadsCount = repWorkload.get(repId);
                
                if (leadsCount < maxLeadsPerRep && leadsCount < minLeadsCount) {
                    assignedRepId = repId;
                    minLeadsCount = leadsCount;
                }
            }
            
            // Assign the lead to the appropriate representative
            if (assignedRepId != null) {
                newLead.OwnerId = assignedRepId;
                leadsToUpdate.add(newLead);
                repWorkload.put(assignedRepId, repWorkload.get(assignedRepId) + 1);
            } 
        }
    }
}