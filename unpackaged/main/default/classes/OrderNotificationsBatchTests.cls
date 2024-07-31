@isTest(SeeAllData=false)
public class OrderNotificationsBatchTests {

    @testSetup
    static void setupTestData() {
        OrderItemTriggerTest.testData();
    }
    
    @isTest
    static void integrationTest() {
        List<Order> orders = [
            select Id, Status 
            from Order
            limit 1
        ];
        orders.get(0).Status = 'Activated';
        update orders;
        Test.startTest();
        OrderNotificationsBatch obj = new OrderNotificationsBatch();
        obj.execute(null);
        Test.stopTest();
    }
    
    @isTest
    static void shouldPopulateRouteDateLabel() {
        List<Order> orders = [
            select Id, Status 
            from Order
            limit 1
        ];
        maps__Route__c route = new maps__Route__c(
            maps__Date__c=Date.today(),
            maps__User__c=UserInfo.getUserId(),
            Order__c=orders.get(0).Id
        );
        insert route;
        maps__Waypoint__c waypoint = new maps__Waypoint__c(
            maps__Route__c=route.Id
        );
        insert waypoint;
        waypoint.maps__LinkId__c = orders.get(0).Id;
        update waypoint;
        waypoint = [select Route_Date_Label__c from maps__Waypoint__c where Id = :waypoint.Id];
        System.assert(waypoint.Route_Date_Label__c != null);
    }
}