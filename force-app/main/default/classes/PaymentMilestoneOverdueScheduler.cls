public with sharing class PaymentMilestoneOverdueScheduler implements Schedulable {
    
    public void execute(SchedulableContext ctx) {
        // SAH-ARC-CE-006: A milestone whose Due Date has passed without being marked Paid must be flagged as Overdue
        List<Payment_Milestone__c> overdueMilestones = [
            SELECT Id, Status__c 
            FROM Payment_Milestone__c 
            WHERE Due_Date__c < TODAY 
            AND Status__c IN ('Pending', 'Invoiced')
        ];
        
        for (Payment_Milestone__c milestone : overdueMilestones) {
            milestone.Status__c = 'Overdue';
        }
        
        if (!overdueMilestones.isEmpty()) {
            update overdueMilestones;
        }
    }
}