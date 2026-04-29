public with sharing class EventTriggerHandler {
    
    public static void handleAfterUpdate(List<Event__c> newEvents, Map<Id, Event__c> oldEventsMap) {
        List<Payment_Milestone__c> milestonesToInsert = new List<Payment_Milestone__c>();
        
        for (Event__c evt : newEvents) {
            Event__c oldEvt = oldEventsMap.get(evt.Id);
            
            // SAH-ARC-CE-006: Generate 30/40/30 milestones when status becomes Confirmed
            if (evt.Status__c == 'Confirmed' && oldEvt.Status__c != 'Confirmed') {
                if (evt.Quoted_Price__c != null) {
                    // 1. Deposit (30% on Confirmation)
                    milestonesToInsert.add(createMilestone(evt.Id, 'Deposit', 30, (evt.Quoted_Price__c * 0.30), Date.today()));
                    
                    // 2. Mid-Event (40% two weeks before Event Start Date)
                    Date midEventDate = evt.Event_Start_Date__c != null ? evt.Event_Start_Date__c.addDays(-14) : Date.today().addDays(14);
                    milestonesToInsert.add(createMilestone(evt.Id, 'Mid-Event', 40, (evt.Quoted_Price__c * 0.40), midEventDate));
                    
                    // 3. Final (30% on Event Completion)
                    Date finalDate = evt.Event_End_Date__c != null ? evt.Event_End_Date__c : Date.today().addDays(30);
                    milestonesToInsert.add(createMilestone(evt.Id, 'Final', 30, (evt.Quoted_Price__c * 0.30), finalDate));
                }
            }
        }
        
        if (!milestonesToInsert.isEmpty()) {
            insert milestonesToInsert;
        }
    }
    
    private static Payment_Milestone__c createMilestone(Id eventId, String milestoneName, Decimal percentage, Decimal amount, Date dueDate) {
        return new Payment_Milestone__c(
            Event__c = eventId,
            Name = milestoneName,
            Due_Date__c = dueDate,
            Status__c = 'Pending' // Assuming Pending is the default status
            /* Note: Ensure fields Percentage__c and Amount__c are created on the object */
        );
    }
}