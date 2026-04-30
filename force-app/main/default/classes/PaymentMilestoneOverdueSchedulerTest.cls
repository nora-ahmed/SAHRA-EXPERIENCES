@isTest
private class PaymentMilestoneOverdueSchedulerTest {
    
    @testSetup
    static void setupTestData() {
        // Create test Account
        Account testAccount = new Account(
            Name = 'Test Corporate Client',
            Industry = 'Technology'
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
            Status__c = 'Confirmed'
        );
        insert testEvent;
        
        // Create payment milestones with past due dates
        List<Payment_Milestone__c> milestones = new List<Payment_Milestone__c>();
        
        // Overdue milestone
        milestones.add(new Payment_Milestone__c(
            Name = 'Deposit',
            Event__c = testEvent.Id,
            Percentage__c = 30,
            Amount__c = 150000,
            Due_Date__c = Date.today().addDays(-10),
            Status__c = 'Pending'
        ));
        
        // Another overdue milestone
        milestones.add(new Payment_Milestone__c(
            Name = 'Mid-Event',
            Event__c = testEvent.Id,
            Percentage__c = 40,
            Amount__c = 200000,
            Due_Date__c = Date.today().addDays(-5),
            Status__c = 'Invoiced'
        ));
        
        // Future milestone (should not be marked overdue)
        milestones.add(new Payment_Milestone__c(
            Name = 'Final',
            Event__c = testEvent.Id,
            Percentage__c = 30,
            Amount__c = 150000,
            Due_Date__c = Date.today().addDays(30),
            Status__c = 'Pending'
        ));
        
        insert milestones;
    }
    
    @isTest
    static void testOverdueFlagging() {
        // Get test event
        Event__c testEvent = [SELECT Id FROM Event__c WHERE Name = 'Test Conference' LIMIT 1];
        
        Test.startTest();
        
        // Execute the scheduler
        PaymentMilestoneOverdueScheduler scheduler = new PaymentMilestoneOverdueScheduler();
        scheduler.execute(null);
        
        Test.stopTest();
        
        // Verify overdue milestones were updated
        List<Payment_Milestone__c> overdueMilestones = [
            SELECT Id, Name, Status__c, Due_Date__c
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
            AND Due_Date__c < :System.today()
        ];
        
        System.assertEquals(2, overdueMilestones.size(), 'Should have 2 overdue milestones');
        
        for (Payment_Milestone__c milestone : overdueMilestones) {
            System.assertEquals('Overdue', milestone.Status__c, 
                               'Milestone should be marked as Overdue: ' + milestone.Name);
        }
        
        // Verify future milestone was not changed
        List<Payment_Milestone__c> futureMilestones = [
            SELECT Id, Name, Status__c, Due_Date__c
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
            AND Due_Date__c >= :System.today()
        ];
        
        System.assertEquals(1, futureMilestones.size(), 'Should have 1 future milestone');
        System.assertEquals('Pending', futureMilestones[0].Status__c, 
                          'Future milestone should remain Pending');
    }
    
    @isTest
    static void testPaidMilestonesNotChanged() {
        // Get test event and milestones
        Event__c testEvent = [SELECT Id FROM Event__c WHERE Name = 'Test Conference' LIMIT 1];
        
        // Mark one milestone as Paid
        List<Payment_Milestone__c> milestones = [
            SELECT Id, Status__c
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
            AND Name = 'Deposit'
        ];
        
        if (!milestones.isEmpty()) {
            milestones[0].Status__c = 'Paid';
            update milestones;
        }
        
        Test.startTest();
        
        // Execute the scheduler
        PaymentMilestoneOverdueScheduler scheduler = new PaymentMilestoneOverdueScheduler();
        scheduler.execute(null);
        
        Test.stopTest();
        
        // Verify paid milestone was not changed
        Payment_Milestone__c paidMilestone = [
            SELECT Id, Status__c
            FROM Payment_Milestone__c
            WHERE Event__c = :testEvent.Id
            AND Name = 'Deposit'
        ];
        
        System.assertEquals('Paid', paidMilestone.Status__c, 
                          'Paid milestone should remain Paid');
    }
    
    @isTest
    static void testSchedulerScheduling() {
        Test.startTest();
        
        String cronExp = '0 0 0 * * ?'; // Run daily at midnight
        System.schedule('Test Payment Milestone Overdue Job', cronExp, 
                       new PaymentMilestoneOverdueScheduler());
        
        Test.stopTest();
        
        // Verify job was scheduled
        List<CronTrigger> jobs = [
            SELECT Id, CronExpression, State
            FROM CronTrigger
            WHERE CronExpression = :cronExp
        ];
        
        System.assertEquals(1, jobs.size(), 'Should have scheduled one job');
        System.assertEquals('WAITING', jobs[0].State, 'Job should be in WAITING state');
    }
}