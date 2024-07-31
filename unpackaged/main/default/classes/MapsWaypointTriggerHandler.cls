public with sharing class MapsWaypointTriggerHandler {

    public static void onBeforeUpdate(Map<Id, maps__Waypoint__c> waypointsMap) {
        for (maps__Waypoint__c waypoint : waypointsMap.values()) {
            if (waypoint.Route_Date__c != null) {
                waypoint.Route_Date_Label__c = getReadableDate(waypoint.Route_Date__c);
            }
        }
    }
    
    public static String getReadableDate(Date d) {
        DateTime dt = DateTime.newInstance(d, Time.newInstance(0, 0, 0, 0));
        return dt.format('EEEEE, MMMM dd');
    }
}