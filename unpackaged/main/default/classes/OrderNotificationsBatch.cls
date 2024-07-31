public class OrderNotificationsBatch implements Database.Batchable<sObject>, Schedulable {
    
    public static final Set<String> ORDER_STATUS = new Set<String>{
        'Activated', 'Credit', 'Paid by Terms', 'Invoiced'
    };
	public static final String ORDER_STATUS_CODE = 'Activated';

    public List<Order> start(Database.BatchableContext bc) {
        // query orders Activated in the last 30 days 
        return [
            select Id, Status, StatusCode, Service_Status__c, 
            (select Id from Maps_Waypoints__r), Contact__r.Email 
            from Order 
            where  CreatedDate = last_n_days:30 
            	and Service_Status__c = null 
            	and Status IN :ORDER_STATUS 
            	and StatusCode = :ORDER_STATUS_CODE order by CreatedDate desc
        ];
    }
    
    public void execute(Database.BatchableContext bc, List<sObject> scope) {
        EmailHelper mailHelper = new EmailHelper();
        for (Order odr : (List<Order>) scope) {
            // Order has no waypoint means it's not scheduled yet
            if (odr.Maps_Waypoints__r == null || odr.Maps_Waypoints__r.isEmpty()) {
                mailHelper.addEmailToQueue(
                    new List<String>{odr.Contact__r.Email}, 
                    null, 
                    'Daily_Customer_Order_Update', 
                    null, 
                    odr.Id
                );
            }
        }
        // send emails
        mailHelper.send();
    }
    
    public void finish(Database.BatchableContext bc) {
        // do nothing
    }
    
    public void execute(SchedulableContext sc) {
        OrderNotificationsBatch obj = new OrderNotificationsBatch();
        Database.executeBatch(obj, Test.isRunningTest() ? 1 : 200);
    }
}