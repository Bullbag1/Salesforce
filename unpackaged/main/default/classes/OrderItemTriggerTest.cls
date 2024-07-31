@IsTest
public class OrderItemTriggerTest {

    private static final Integer NUMBER_RECORDS = 3;
    private static final String EXPECTED_STRING = '1. Test Product 0 - Quantity : 5.00\n2. Test Product 1 - Quantity : 5.00\n3. Test Product 2 - Quantity : 5.00';


    @TestSetup
    public static void testData() {

        ID standardPBID = Test.getStandardPricebookId();

        Account acc = new Account();
        acc.Name = 'Test Acc';
        acc.RecordTypeId = [Select Id,SobjectType,Name From RecordType WHERE DeveloperName ='Business' limit 1].Id;
        acc.Type = 'Consumer';
        insert acc;

        Pricebook2 pricebook2 = new Pricebook2();
        pricebook2.Name = 'Test PriceBook';
        pricebook2.IsActive = true;
        insert pricebook2;

        List<Product2> product2s = new List<Product2>();
        for(Integer i = 0; i < NUMBER_RECORDS; i++) {
            Product2 product2 = new Product2();
            product2.Name = 'Test Product ' + i;
            product2.Family = 'Disposal';
            product2.IsActive = true;
            product2s.add(product2);
        }
        
        product2s.add(
        	new Product2(
            	Name = 'Fuel Surcharge',
                ProductCode = 'FUEL_SURCHARGE',
                IsActive = true
            )
        );
        
        insert product2s;


        List<PricebookEntry> pricebookEntries = new List<PricebookEntry>();
        List<PricebookEntry> standardPricebookEntries = new List<PricebookEntry>();
        for(Integer i = 0; i < product2s.size(); i++) {
            PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = standardPBID, Product2Id = product2s.get(i).Id, UnitPrice = 20, IsActive = true, UseStandardPrice = false);

            PricebookEntry pricebookEntry = new PricebookEntry();
            pricebookEntry.IsActive = true;
            pricebookEntry.UseStandardPrice = false;
            pricebookEntry.Pricebook2Id = pricebook2.Id;
            pricebookEntry.UnitPrice = 20;
            pricebookEntry.Product2Id = product2s.get(i).Id;
            standardPricebookEntries.add(standardPrice);
            pricebookEntries.add(pricebookEntry);
        }
        insert standardPricebookEntries;
        insert pricebookEntries;

        Order order = new Order();
        order.RecordTypeId = [Select Id,SobjectType,Name From RecordType WHERE DeveloperName ='Buy_a_Bag' limit 1].Id;
        order.AccountId = acc.Id;
        order.EffectiveDate = System.today();
        order.Status = 'Draft';
        order.Pricebook2Id = pricebook2.Id;
        insert order;


        List<OrderItem> orderItems = new List<OrderItem>();
        for(Integer i = 0; i < NUMBER_RECORDS; i++) {
            OrderItem orderItem = new OrderItem();
            orderItem.Quantity = 5;
            orderItem.UnitPrice = 20;
            orderItem.OrderId = order.Id;
            orderItem.PricebookEntryId = pricebookEntries.get(i).Id;
            orderItem.Product2Id = product2s.get(i).Id;
            orderItems.add(orderItem);
        }
        insert orderItems;
    }

    @IsTest
    static void testOrderProductsFieldOnUpdate(){
        Order ord = Database.query('SELECT Id, Order_Products__c FROM Order');

        System.assert(ord.Order_Products__c.contains(EXPECTED_STRING));

        OrderItem orderItem = [SELECT Id, Quantity FROM OrderItem WHERE Product2.Name = 'Test Product 2'];
        orderItem.Quantity = 15;

        Test.StartTest();
        update orderItem;
        Test.StopTest();

        Order orderAfterUpdate = Database.query('SELECT Id, Order_Products__c FROM Order');
        System.assert(orderAfterUpdate.Order_Products__c.contains('Test Product 2'), orderAfterUpdate.Order_Products__c);
    }

    @IsTest
    static void testOrderProductsFieldOnDelete(){
        Order ord = Database.query('SELECT Id, Order_Products__c FROM Order');
        OrderItem orderItem = [SELECT Id, Quantity FROM OrderItem WHERE Product2.Name = 'Test Product 2'];

        Test.StartTest();
        delete orderItem;
        Test.StopTest();

        Order orderAfterUpdate = Database.query('SELECT Id, Order_Products__c FROM Order');
        System.assert(!(((String)orderAfterUpdate.get('Order_Products__c')).contains('Test Product 2')));
    }
    
    @IsTest
    static void test_OrderItemTriggerHelper () {
        Id orderId = [
            select Id 
            from Order 
            where Id in (
            	select OrderId 
                from OrderItem
                where Product2.Family = 'Disposal'
            )
            limit 1
        ].Id;
        

        Test.startTest();

        // clean existing fuel surcharge items so a new one will be made
        delete [select id from orderitem where Id = :orderId and Product2.ProductCode = 'FUEL_SURCHARGE'];
        
        // run the logic multiple times to make sure only one fuel surcharge is attached
        OrderItemTriggerHelper.addFuelSurcharge([select Id, OrderId from OrderItem where OrderId = :orderId]);
        OrderItemTriggerHelper.addFuelSurcharge([select Id, OrderId from OrderItem where OrderId = :orderId]);
        Test.stopTest();

        System.assertEquals(1, [
            select Id 
            from OrderItem
            where OrderId = :orderId
            and Product2.ProductCode = 'FUEL_SURCHARGE'
        ].size());
    }
}