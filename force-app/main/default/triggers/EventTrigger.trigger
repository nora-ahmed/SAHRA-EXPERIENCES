trigger EventTrigger on Event__c (after update) {
    // Follows best practice by keeping the trigger logicless 
    // and delegating to a handler class.
    if (Trigger.isAfter && Trigger.isUpdate) {
        EventTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
}