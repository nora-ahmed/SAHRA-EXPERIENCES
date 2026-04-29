@isTest
private class EventTriggerHandlerTest {
    
    @testSetup
    static void setupTestData() {
        // Create test Account
        Account testAccount = new Account(
            Name = 'Test Corporate Client',
            Industry = 'Technology',
            AnnualRevenue = 10000000
        );
        insert testAccount;
        
        // Create test User
        User testUser = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];
        
        // Create test Event
        Event__c testEvent = new Event__c(
            Name = 'Test Conference',
            Client_Organization__c = testAccount.Id,
            Event_Type__c = 'Conference',
            Expected_Headcount__c = 100,
            Event_Start_Date__c = Date.today().addDays(30),
            Event_End_Date__c = Date.today().addDays(32),
            Event_Owner__c = testUser.Id,
            Quoted_Price__c = 500000,
            Status__c = 'Inquiry'
        );
        insert testEvent;
    }
    
    @isTest
    static void testPaymentMilestoneGenerationOnConfirmed() {
        // Get test event
        Event__c testEvent = [SELECT Id, Quoted_Price__c, Event_Start_Date__c, Event_End_Date__c 
                               FROM Event__c WHERE Name = 'Test Conference' LIMIT 1];
        
        Test.startTest();
        
        // Update event status to Confirmed
        testEvent.Status__c = 'Confirmed';
        update testEvent;
        
        Test.stopTest();
        
        // Verify payment milestones were created
        List<Payment_Milestone__c> milestones = [
            SELECT Name, Percentage__c, Amount__c, Due_Date__c, Status__c
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
            ORDER BY Due_Date__c ASC
        ];
        
        System.assertEquals(3, milestones.size(), 'Should create 3 payment milestones');
        
        // Verify Deposit milestone (30%)
        System.assertEquals('Deposit', milestones[0].Name);
        System.assertEquals(30, milestones[0].Percentage__c);
        System.assertEquals(150000, milestones[0].Amount__c);
        System.assertEquals('Pending', milestones[0].Status__c);
        
        // Verify Mid-Event milestone (40%)
        System.assertEquals('Mid-Event', milestones[1].Name);
        System.assertEquals(40, milestones[1].Percentage__c);
        System.assertEquals(200000, milestones[1].Amount__c);
        
        // Verify Final milestone (30%)
        System.assertEquals('Final', milestones[2].Name);
        System.assertEquals(30, milestones[2].Percentage__c);
        System.assertEquals(150000, milestones[2].Amount__c);
    }
    
    @isTest
    static void testMilestoneRecalculationOnPriceChange() {
        // Get test event and confirm it to generate milestones
        Event__c testEvent = [SELECT Id, Quoted_Price__c FROM Event__c WHERE Name = 'Test Conference' LIMIT 1];
        testEvent.Status__c = 'Confirmed';
        update testEvent;
        
        // Get the milestones
        List<Payment_Milestone__c> milestones = [
            SELECT Id, Amount__c, Status__c
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
        ];
        
        Test.startTest();
        
        // Update quoted price
        testEvent.Quoted_Price__c = 600000;
        update testEvent;
        
        Test.stopTest();
        
        // Verify milestones were recalculated
        List<Payment_Milestone__c> updatedMilestones = [
            SELECT Id, Amount__c, Status__c
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
            ORDER BY Due_Date__c ASC
        ];
        
        // Verify amounts are recalculated
        System.assertEquals(180000, updatedMilestones[0].Amount__c, 'Deposit should be 30% of 600,000');
        System.assertEquals(240000, updatedMilestones[1].Amount__c, 'Mid-Event should be 40% of 600,000');
        System.assertEquals(180000, updatedMilestones[2].Amount__c, 'Final should be 30% of 600,000');
    }
    
    @isTest
    static void testFinancialRollupCalculation() {
        // Get test event and confirm it to generate milestones
        Event__c testEvent = [SELECT Id, Quoted_Price__c FROM Event__c WHERE Name = 'Test Conference' LIMIT 1];
        testEvent.Status__c = 'Confirmed';
        update testEvent;
        
        // Get the milestones and update some to Paid
        List<Payment_Milestone__c> milestones = [
            SELECT Id, Status__c
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
        ];
        
        milestones[0].Status__c = 'Paid';
        milestones[1].Status__c = 'Invoiced';
        update milestones;
        
        Test.startTest();
        
        // Trigger rollup by updating event
        testEvent.Name = 'Updated Conference';
        update testEvent;
        
        Test.stopTest();
        
        // Verify financial rollups
        Event__c updatedEvent = [SELECT Id, Total_Quoted__c, Total_Invoiced__c, 
                                        Total_Collected__c, Outstanding_Balance__c
                                 FROM Event__c WHERE Id = :testEvent.Id];
        
        System.assertEquals(500000, updatedEvent.Total_Quoted__c);
        System.assertEquals(350000, updatedEvent.Total_Invoiced__c, 'Should sum Invoiced and Paid');
        System.assertEquals(150000, updatedEvent.Total_Collected__c, 'Should sum only Paid');
        System.assertEquals(350000, updatedEvent.Outstanding_Balance__c, 'Should be Quoted - Collected');
    }
    
    @isTest
    static void testConfirmedRequiresQuotedPrice() {
        // Get test event
        Event__c testEvent = [SELECT Id FROM Event__c WHERE Name = 'Test Conference' LIMIT 1];
        
        // Clear quoted price
        testEvent.Quoted_Price__c = null;
        update testEvent;
        
        Test.startTest();
        
        // Try to set status to Confirmed without quoted price
        testEvent.Status__c = 'Confirmed';
        
        try {
            update testEvent;
            System.assert(false, 'Should have thrown an exception');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Quoted Price'), 
                         'Should require Quoted Price for Confirmed status');
        }
        
        Test.stopTest();
    }
    
    @isTest
    static void testNoMilestonesWithoutQuotedPrice() {
        // Get test event
        Event__c testEvent = [SELECT Id FROM Event__c WHERE Name = 'Test Conference' LIMIT 1];
        
        // Clear quoted price
        testEvent.Quoted_Price__c = null;
        update testEvent;
        
        Test.startTest();
        
        // Try to confirm without quoted price
        testEvent.Status__c = 'Confirmed';
        update testEvent;
        
        Test.stopTest();
        
        // Verify no milestones were created
        List<Payment_Milestone__c> milestones = [
            SELECT Id
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
        ];
        
        System.assertEquals(0, milestones.size(), 'Should not create milestones without quoted price');
    }
}
