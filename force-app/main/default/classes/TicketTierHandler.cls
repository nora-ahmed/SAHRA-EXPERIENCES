public class TicketTierHandler {

    public static void validateCapacity(
        List<Ticket_Tier__c> newTiers,
        Map<Id, Ticket_Tier__c> oldMap
    ) {
        Set<Id> eventIds = new Set<Id>();
        for (Ticket_Tier__c t : newTiers) {
            if (t.Status__c == 'Active') eventIds.add(t.Sahra_Event__c);
        }
        if (eventIds.isEmpty()) return;

        // Get parent event capacities
        Map<Id, Event__c> eventsMap = new Map<Id, Event__c>(
            [SELECT Id, Total_Capacity__c FROM Event__c WHERE Id IN :eventIds]
        );

        // Get existing active tier sums excluding current records
        Set<Id> currentIds = new Set<Id>();
        for (Ticket_Tier__c t : newTiers) currentIds.add(t.Id);

        Map<Id, Decimal> existingSums = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT Sahra_Event__c evtId, SUM(Quantity_Available__c) total
            FROM Ticket_Tier__c
            WHERE Sahra_Event__c IN :eventIds
              AND Status__c != 'Closed'
              AND Id NOT IN :currentIds
            GROUP BY Sahra_Event__c
        ]) {
            existingSums.put((Id)ar.get('evtId'), (Decimal)ar.get('total'));
        }

        // Sum quantities from current batch
        Map<Id, Decimal> batchSums = new Map<Id, Decimal>();
        for (Ticket_Tier__c t : newTiers) {
            if (t.Status__c == 'Active') {
                Decimal current = batchSums.containsKey(t.Sahra_Event__c)
                    ? batchSums.get(t.Sahra_Event__c) : 0;
                batchSums.put(t.Sahra_Event__c, current + t.Quantity_Available__c);
            }
        }

        // Validate total vs capacity
        for (Ticket_Tier__c t : newTiers) {
            if (t.Status__c != 'Active') continue;
            Id eid = t.Sahra_Event__c;
            Decimal existing = existingSums.containsKey(eid) ? existingSums.get(eid) : 0;
            Decimal batch = batchSums.containsKey(eid) ? batchSums.get(eid) : 0;
            Decimal totalQty = existing + batch;
            Decimal capacity = eventsMap.get(eid)?.Total_Capacity__c ?? 0;

            if (totalQty > capacity) {
                t.addError(
                    'Activating this tier would exceed the Event\'s Total Capacity of '
                    + capacity + '. Current active tier total: ' + totalQty + '.'
                );
            }
        }
    }
}