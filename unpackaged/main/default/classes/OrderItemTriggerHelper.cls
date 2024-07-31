public with sharing class OrderItemTriggerHelper {

    /**
     * Used apex instead of flow because when trying a flow, they were very unreliable  
     */
    public static void addFuelSurcharge (List<OrderItem> newList) {
        // making local set because max of 2 sub-joins allowed
        Set<Id> orderIds = new Set<Id>();
        for (OrderItem oi : newList) {
            orderIds.add(oi.OrderId);
        }
		Map<Id, Order> ordersNeededFuelSurcharge = new Map<Id, Order>([
            select Id, Pricebook2Id
            from Order
            where Id in :orderIds
            and CreatedDate >= 2022-03-03T00:00:00.000Z
            and Id in (
            	select OrderId
                from OrderItem
                where Product2.Family = 'Disposal'
            )
            and Id not in (
            	select OrderId
                from OrderItem
                where Product2.ProductCode = 'FUEL_SURCHARGE'
            )
        ]);
        Set<Id> pricebookIds = new Set<Id>();
        for (Order o : ordersNeededFuelSurcharge.values()) {
            pricebookIds.add(o.Pricebook2Id);
        }
        Map<Id, PricebookEntry> pricebookToFuelSurchangePricebookEntry = new Map<Id, PricebookEntry>();
        for (PricebookEntry pbe : [
            select Id, Pricebook2Id, UnitPrice
            from PricebookEntry
            where ProductCode = 'FUEL_SURCHARGE'
            and IsActive = true
            and Pricebook2Id in :pricebookIds
        ]) {
            pricebookToFuelSurchangePricebookEntry.put(pbe.Pricebook2Id, pbe);
        }
        List<OrderItem> toInsert = new List<OrderItem>();
        for (Order o : ordersNeededFuelSurcharge.values()) {
			PricebookEntry pbe = pricebookToFuelSurchangePricebookEntry.get(o.Pricebook2Id);
            // skip if fuel surcharge not in order's pricebook
            if (pbe == null) continue;
            toInsert.add(
                new OrderItem(
                    OrderId = o.Id,
                	PricebookEntryId = pbe.Id,
                    UnitPrice = pbe.UnitPrice,
                    Quantity = 1
                )
            );
        }
        insert toInsert;
    }
    
    public static void updateRelatedOrder(List<OrderItem> newList){

        Set<Id> orderIds = new Set<Id>();
        List<Order> ordersToUpsert = new List<Order>();

        try {

            for(OrderItem oItem  : newList){
                orderIds.add(oItem.OrderId);
            }
            
            String query = 'SELECT Id,Name,Order_Products__c,(SELECT Id,Product2.Name,Quantity FROM OrderItems) FROM Order WHERE Id IN :orderIds';

            for(Order ord : Database.query(query)){
                String orderProducts = '';
                Integer i = 1;

                for (OrderItem oItem : ord.OrderItems){
                    orderProducts += i++ + '. ' + oItem.Product2.Name + ' - ' + 'Quantity : ' + oItem.Quantity + '\n';
                }
                ord.put('Order_Products__c',orderProducts);
                ordersToUpsert.add(ord);
            }

            upsert (ordersToUpsert);

        } catch (Exception e) {
            System.debug(e.getMessage() + ' line number:' + e.getLineNumber() );
        }
    }
}