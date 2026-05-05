@isTest
private class CCOApprovalTest {
    @isTest
    static void testCCOValidation() {
        // Create an Event that meets all criteria and has >1,500,000 Quoted Price
        Event__c testEvent = new Event__c(
            Event_Type__c = 'Conference',
            Expected_Headcount__c = 100,
            Quoted_Price__c = 1600000,
            Event_Start_Date__c = Date.today().addDays(30),
            Status__c = 'Inquiry',
            Manager_Approved__c = true,
            CCO_Approved__c = false
        );
        insert testEvent;

        // Attempt to move to Proposal Sent without CCO approval
        testEvent.Status__c = 'Proposal Sent';
        
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            update testEvent;
        } catch(DmlException e) {
            exceptionThrown = true;
            System.assert(e.getMessage().contains('This event requires Chief Commercial Officer approval'));
        }
        System.assert(exceptionThrown, 'Expected validation rule to fire');
        
        // Approve it and update
        testEvent.CCO_Approved__c = true;
        update testEvent;
        System.assertEquals('Proposal Sent', testEvent.Status__c);
        
        Test.stopTest();
    }
}