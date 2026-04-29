// Script to schedule the Payment Milestone Overdue Scheduler
// Run this in Developer Console or Anonymous Apex

// Schedule to run daily at midnight (00:00:00)
String cronExp = '0 0 0 * * ?';
String jobName = 'Payment Milestone Overdue Job';

// Check if job already exists
List<CronTrigger> existingJobs = [
    SELECT Id, CronExpression, State, CronJobDetail.Name
    FROM CronTrigger
    WHERE CronJobDetail.Name = :jobName
];

if (existingJobs.size() > 0) {
    System.debug('Job already exists: ' + existingJobs[0].Id);
    System.debug('Current state: ' + existingJobs[0].State);
    System.debug('Cron expression: ' + existingJobs[0].CronExpression);
} else {
    // Schedule the job
    System.schedule(jobName, cronExp, new PaymentMilestoneOverdueScheduler());
    System.debug('Job scheduled successfully: ' + jobName);
    System.debug('Cron expression: ' + cronExp);
    System.debug('Job will run daily at midnight');
}

// Alternative cron expressions for different schedules:
// Every 6 hours: '0 0 */6 * * ?'
// Every hour: '0 0 * * * ?'
// Every 30 minutes: '0 */30 * * * ?'
// Weekly on Sunday at midnight: '0 0 0 ? * SUN'
