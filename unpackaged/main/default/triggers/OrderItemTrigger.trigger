trigger OrderItemTrigger on OrderItem (after insert, after update, after delete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            OrderItemTriggerHelper.addFuelSurcharge(Trigger.new);
            OrderItemTriggerHelper.updateRelatedOrder(Trigger.new);
        } else if (Trigger.isUpdate) {
            OrderItemTriggerHelper.addFuelSurcharge(Trigger.new);
            OrderItemTriggerHelper.updateRelatedOrder(Trigger.new);
        } else if (Trigger.isDelete) {
            OrderItemTriggerHelper.updateRelatedOrder(Trigger.old);
        }
    }
}