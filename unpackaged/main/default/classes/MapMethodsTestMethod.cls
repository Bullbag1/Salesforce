@isTest
public class MapMethodsTestMethod {

    public static testMethod void test1()
    {
        User usr = [Select id from User where Id = :UserInfo.getUserId()];
        
        MapMethods.DistanceHaversine(35.312,-80.012,35.000,-80.000);
        MapMethods.Coordinate c = new MapMethods.Coordinate();
        MapMethods.Coordinate c2 = new MapMethods.Coordinate(35.312,-80.012);
        MapMethods.FindDestinationPoint(c2,1.4,3.1);
    }
}