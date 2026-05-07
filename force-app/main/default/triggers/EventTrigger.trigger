trigger EventTrigger on Event__c (before update, after update) {
    // Follows best practice by keeping the trigger logicless 
    // and delegating to a handler class.
    if (Trigger.isBefore && Trigger.isUpdate) {
        EventTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
    if (Trigger.isAfter && Trigger.isUpdate) {
        EventTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}