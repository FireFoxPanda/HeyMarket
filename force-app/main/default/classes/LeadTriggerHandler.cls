public class LeadTriggerHandler {
    public static void handleLeadAssignment(List<Lead> newLeads) {
       LeadAssignmentHandler.assignLeads(newLeads);
    }
    

    public static void validateLeadConversion(List<Lead> leadsToConvert) {
        List<String> validationErrors = new List<String>(); 
        
        
        for (Lead lead : leadsToConvert) {
            if (String.isBlank(lead.Email) || !isValidEmail(lead.Email)) {
                validationErrors.add('Lead must have a valid email address.');
            }
            if (String.isBlank(lead.Phone) || !isValidPhoneNumber(lead.Phone)) {
                validationErrors.add('Lead must have a valid phone number.');
            }
            
            // Check if there are any validation errors
            if (!validationErrors.isEmpty()) {
                lead.addError(String.join(validationErrors, '\n'));
            }
        }
    }
    
    private static Boolean isValidEmail(String email) {
      
        return Pattern.matches('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}', email);
    }
    
    private static Boolean isValidPhoneNumber(String phoneNumber) {
       
        return Pattern.matches('\\d{10}', phoneNumber); 
    }
}