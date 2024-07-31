public with sharing class MapMethods 
{
  
    public static decimal DistanceHaversine(decimal Lat1, decimal Long1, decimal Lat2, decimal Long2)
    {
        decimal R = 6371;
        decimal dLon = ToRadians(Long2 - Long1);
        decimal dLat = ToRadians(Lat2 - Lat1);

        decimal a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) + Math.Cos(ToRadians(Lat1)) * Math.Cos(ToRadians(Lat2)) * Math.Sin(dLon / 2) * Math.Sin(dLon / 2);
        decimal c = 2 * Math.Asin(Math.Min(1, Math.Sqrt(a)));
        decimal d = R * c;
        
        //return d;       
        return d * 0.621371;
    }
    
    public static decimal ToRadians(decimal d)
    {
        decimal Pi = 3.141592653589793238462643383279502884197169399375;
        return (Pi / 180) * d;  
    }
    
    public static Coordinate FindDestinationPoint(Coordinate pStartingPoint, decimal pDistanceInMiles, decimal pBearing)
    {
        decimal radiusEarth= 3963.1663751;
        decimal PI = 3.141592653589793238462643383279502884197169399375;
                    
        //for bearing formula you must convert start point and bearing to radians 
        decimal CenterLat = pStartingPoint.Latitude;
        decimal CenterLong = pStartingPoint.Longitude;
                        
        //converts start latitude and longitude 
        decimal lat1 = CenterLat  * PI/180;
        decimal lon1 = CenterLong * PI/180;
        
        //converts bearing
        decimal brg = pBearing  * PI/180;
        
        //converts distance ****MILES**** 
        decimal dist = pDistanceInMiles/radiusEarth;

        //calculate second location
        decimal Lat2 = Math.asin( Math.sin( lat1 )*Math.cos( dist ) + Math.cos( lat1 )*Math.sin( dist )*Math.cos( brg ) );
        decimal Lon2 = lon1 + Math.atan2(Math.sin( brg  )*Math.sin(dist )*Math.cos(lat1 ), Math.cos(dist )-Math.sin(lat1 )*Math.sin(lat2));

        //converts second latitude and longitude 
        decimal degreelat2 = lat2 * 180/PI;
        decimal degreelon2 = lon2 * 180/PI;
        
        Coordinate out = new Coordinate();
        out.Latitude = degreelat2;
        out.Longitude = degreelon2;
        
        return out;
    }
    
  public class Coordinate
  {
    public decimal Latitude;
    public decimal Longitude;
  
    public Coordinate() 
    {
      
    }
      
    public Coordinate(decimal Lat, decimal Lon) 
    {
      this.Latitude = Lat;
      this.Longitude = Lon;
    }
  }  
}