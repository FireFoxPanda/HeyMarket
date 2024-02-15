# Salesforce Lead Management Triggers and Solutions , Opportunity Revenue Calculator , Opportunity Stage Update

1. This repository contains Apex triggers and corresponding solutions for Salesforce lead management, including lead assignment automation and lead qualification validation. These triggers and solutions are designed to optimize lead handling processes within Salesforce.

2. Repo includes an Apex class and a corresponding test class to calculate and update the potential revenue for new opportunities based on selected products or services.

3. Includes an opportunity trigger that automatically updates the Opportunity stage to "Closing" if certain criteria are met. 

## Lead Assignment Automation

The `LeadAssignmentHandler` trigger automates the assignment of incoming leads to the appropriate sales representatives based on predefined criteria such as lead location, industry, and source. The trigger ensures that leads are distributed evenly among the sales team to optimize workload balance.

### Components Used

| Component                   | Description                                  |
|-----------------------------|----------------------------------------------|
|`LeadValidationTrigger`             |    Apex Trigger                         |
| `LeadTriggerHandler `  |            Apex Trigger Handler Class               | 
| `LeadAssignmentHandler `    |           Apex Class for Assigment Logic        |

## Lead Qualification Validation

The `LeadValidationTrigger` trigger validates leads before they are converted to opportunities. It enforces criteria for lead qualification, such as ensuring that the lead has a valid email address and phone number, and that key fields are not left blank.

### Components Used

| Component                   | Description                                  |
|-----------------------------|----------------------------------------------|
| `LeadValidationTrigger ` |         Apex Trigger                            |
| `LeadAssignmentHandler`   | Apex Trigger Handler Class                               |

## Opportunity Revenue Calculator
The Opportunity Revenue Calculator class automates the calculation and update of potential revenue for new opportunities. It consists of an Apex class `OpportunityRevenueCalculator` and a test class `OpportunityRevenueCalculatorTest`.

### Components

| Component | Description |
| --------- | ----------- |
| `OpportunityRevenueCalculator.cls` | Apex class that calculates and updates potential revenue for opportunities. |
| `OpportunityRevenueCalculatorTest.cls` | Test class for the Opportunity Revenue Calculator. |

## Opportunity Stage Update
The Apex trigger (`OpportunityTrigger`) 
The criteria include:
- The expected close date is within the next 30 days.
- The opportunity amount exceeds a certain threshold.

## Components Used

| Component                | Description                                        |
|--------------------------|----------------------------------------------------|
| `OpportunityTrigger`         |         Apex Trigger                             |
| `OpportunityTriggerHandler`    |  Contains the logic for updating Opportunity stages.Updates the Opportunity stage to "Closing" based on predefined criteria.  |
| `OpportunityTriggerHandlerTest`          |           Test class for the Opportunity Stage Update        |

