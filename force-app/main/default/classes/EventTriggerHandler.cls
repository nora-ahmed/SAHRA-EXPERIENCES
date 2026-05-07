public with sharing class EventTriggerHandler {
    
    public static void handleBeforeUpdate(List<Event__c> newEvents, Map<Id, Event__c> oldEventsMap) {
        for (Event__c evt : newEvents) {
            Event__c oldEvt = oldEventsMap.get(evt.Id);
            
            // Capture Prior Status when submitting for approval
            if (evt.Status__c == 'Pending Approval' && oldEvt.Status__c != 'Pending Approval') {
                evt.Prior_Status__c = oldEvt.Status__c;
            }
            
            // Handle Rejection to revert status
            if (evt.Approval_Rejected__c == true && oldEvt.Approval_Rejected__c == false) {
                if (evt.Prior_Status__c != null) {
                    evt.Status__c = evt.Prior_Status__c;
                }
                evt.Approval_Rejected__c = false; // Reset the flag
            }
        }
    }
    
    public static void handleAfterUpdate(List<Event__c> newEvents, Map<Id, Event__c> oldEventsMap) {
        List<Payment_Milestone__c> milestonesToInsert = new List<Payment_Milestone__c>();
        Set<Id> cancelledEventIds = new Set<Id>();
        Map<Id, Schema.RecordTypeInfo> rtInfos = Schema.SObjectType.Event__c.getRecordTypeInfosById();
        
        for (Event__c evt : newEvents) {
            Event__c oldEvt = oldEventsMap.get(evt.Id);
            String rtDevName = '';
            if (evt.RecordTypeId != null && rtInfos.containsKey(evt.RecordTypeId)) {
                rtDevName = rtInfos.get(evt.RecordTypeId).getDeveloperName();
            }
            
            // Handle Cancellation
            if (evt.Status__c == 'Cancelled' && oldEvt.Status__c != 'Cancelled') {
                cancelledEventIds.add(evt.Id);
            }
        }
        
        if (!milestonesToInsert.isEmpty()) {
            insert milestonesToInsert;
        }
        
        if (!cancelledEventIds.isEmpty()) {
            List<Payment_Milestone__c> milestonesToCancel = [SELECT Id, Status__c FROM Payment_Milestone__c WHERE Event__c IN :cancelledEventIds AND Status__c != 'Paid'];
            for (Payment_Milestone__c pm : milestonesToCancel) {
                pm.Status__c = 'Voided';
            }
            if (!milestonesToCancel.isEmpty()) {
                update milestonesToCancel;
            }
        }
    }
    
    private static Payment_Milestone__c createMilestone(Id eventId, String milestoneName, Decimal percentage, Decimal amount, Date dueDate) {
        return new Payment_Milestone__c(
            Event__c = eventId,
            Name = milestoneName,
            Due_Date__c = dueDate,
            Percentage__c = percentage,
            Amount__c = amount,
            Status__c = 'Pending' // Assuming Pending is the default status
        );
    }
}