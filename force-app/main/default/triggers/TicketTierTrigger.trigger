trigger TicketTierTrigger on Ticket_Tier__c (before insert, before update) {
    TicketTierHandler.validateCapacity(Trigger.new, Trigger.oldMap);
}