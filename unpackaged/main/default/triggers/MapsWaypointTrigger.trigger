trigger MapsWaypointTrigger on maps__Waypoint__c (before update) {

    if (Trigger.isBefore && Trigger.isUpdate) {
        MapsWaypointTriggerHandler.onBeforeUpdate(Trigger.newMap);
    }
}