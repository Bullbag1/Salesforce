global class AdvancedRouteSummaryBatch implements Database.Batchable<sObject>,Database.AllowsCallouts, Schedulable, Database.Stateful
{
    //database.executebatch(new AdvancedRouteSummaryBatch(),1);
    //database.executebatch(new AdvancedRouteSummaryBatch(date.newinstance(2016, 3, 10)),1);

    //AdvancedRouteSummaryBatch rsb = new AdvancedRouteSummaryBatch();
    //String sch = '0 0 1/2 * * ?';
    //system.schedule('Advanced Daily Vehicle Summary', sch, rsb);

    /*global Date SelectedDay {get; set;}
    global list<User> users {get; set;}
    global decimal StopDistanceCriteria {get; set;}
    global decimal StopTimeCriteria {get; set;}
    global decimal GeofenceDistanceToStop {get; set;}
    
    global datetime AlertStartDateTimeRange {get; set;}
    global datetime AlertEndDateTimeRange {get; set;}
    
    global class MapAnythingLiveAPIException extends Exception {}*/
    
    global AdvancedRouteSummaryBatch()
    {
        /*SelectedDay = date.today();
        AlertEndDateTimeRange = datetime.now();
        AlertStartDateTimeRange = AlertEndDateTimeRange.addHours(-2);*/
    }
    
    /*global AdvancedRouteSummaryBatch (Date day)
    {
        SelectedDay = day;
        AlertEndDateTimeRange = null;
        AlertStartDateTimeRange = null;
    }*/

    global void execute(SchedulableContext SC)
    {
        //database.executeBatch(new AdvancedRouteSummaryBatch(),1);
    }

    global Database.QueryLocator start (Database.BatchableContext BC)
    {
        /*users = [SELECT Email FROM User WHERE ReceiveVehicleEmailAlerts__c = true];
        
        for (MALiveStopCriteria__c MALSC : [SELECT StopDistanceCriteria__c, StopTimeCriteria__c, GeofenceDistanceToStop__c FROM MALiveStopCriteria__c])
        {
            StopDistanceCriteria = MALSC.StopDistanceCriteria__c/5280;  // Feet
            StopTimeCriteria = MALSC.StopTimeCriteria__c*60; // Convert from Minutes to Seconds
            GeofenceDistanceToStop = MALSC.GeofenceDistanceToStop__c; // Feet
        }
        
        if (!Test.isRunningTest())
        {
            return Database.getQueryLocator ([SELECT Id, Name, MA_Live_IoT_Device__r.malive__DeviceId__c, MA_Live_IoT_Device__r.malive__Vendor__c, MA_Live_IoT_Device__r.VIN_Number__c, Driver__c, Max_Speed_Threshold__c, Vehicle_Type__c
                                              FROM Vehicle__c
                                              WHERE MA_Live_IoT_Device__r.malive__DeviceId__c != null
                                              AND MA_Live_IoT_Device__r.malive__Vendor__c != null
                                              ]);
        }
        else
        {
            return Database.getQueryLocator ([SELECT Id, Name, MA_Live_IoT_Device__r.malive__DeviceId__c, MA_Live_IoT_Device__r.malive__Vendor__c, MA_Live_IoT_Device__r.VIN_Number__c, Driver__c, Max_Speed_Threshold__c, Vehicle_Type__c
                                              FROM Vehicle__c
                                              WHERE MA_Live_IoT_Device__r.malive__DeviceId__c != null
                                              AND MA_Live_IoT_Device__r.malive__Vendor__c != null
                                              LIMIT 1
                                              ]);
        }*/
        return Database.getQueryLocator('SELECT Id FROM User LIMIT 1');
    }

    //global void execute (Database.BatchableContext BC, List<Vehicle__c> scope)
    global void execute (Database.BatchableContext BC, List<sObject> scope)
    {
        /*for(Vehicle__c vehicle : scope)
        {
            system.debug(vehicle.id);
            system.debug(vehicle.Name);
            system.debug(vehicle.MA_Live_IoT_Device__r.malive__DeviceId__c);
            
            try
            {                
                // Grab all the messages from the gateway for this device
                map<string, object> returnData;
                
                if (!Test.isRunningTest())
                {
                    returnData = sma.MapAnythingLiveAPI.GetDeviceHistory(new map<string,object> {
                       'version' => '1',
                       'deviceid' => vehicle.MA_Live_IoT_Device__r.malive__Vendor__c+'-'+vehicle.MA_Live_IoT_Device__r.malive__DeviceId__c,
                       'from' => string.valueOf(DateTime.newInstance(SelectedDay.year(), SelectedDay.month(), SelectedDay.day(), 0, 0, 0).getTime()),
                       'to' => string.valueOf(DateTime.newInstance(SelectedDay.year(), SelectedDay.month(), SelectedDay.day(), 23, 59, 59).getTime())
                    });
                }
                else
                {
                    // First AVL MSG    
                    string test =  '{';
                        test += ' "success": true,';
                        test += ' "positions": [';
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 5.07,';
                        test += ' "odometer": 11684.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "IGON",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689101010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "IGON",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 4,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 5.07,';
                        test += ' "odometer": 11684.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';
                        
                        // Second AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "DECEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218639301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "DECEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';
                        
                        // Second AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "DECEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218639301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "DECEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },'; 
                        
                        // Second AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "DECEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218639301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "DECEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },'; 
                        
                        // Second AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "DECEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218639301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "DECEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },'; 
                        
                        // Second AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "DECEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218639301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "DECEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },'; 
                        
                        // Second AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "DECEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218639301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "DECEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 6.07,';
                        test += ' "odometer": 11784.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },'; 
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Third AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "ACCEL",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305454218689301010122041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "ACCEL",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 7.07,';
                        test += ' "odometer": 11884.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Fourth AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 8.07,';
                        test += ' "odometer": 11984.92,';
                        test += ' "speed": 0';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498541393000,';
                        test += ' "eventType": "IGOFF",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305450218689301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "IGOFF",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 8.07,';
                        test += ' "odometer": 11984.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },'; 
                        
                        // Fifth AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 9.07,';
                        test += ' "odometer": 12490.92,';
                        test += ' "speed": 100';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498657382479,';
                        test += ' "eventType": "IGON",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8301450218689301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "IGON",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.8263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 0,';
                        test += ' "longitude": -73.0581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 9.07,';
                        test += ' "odometer": 12490.92,';
                        test += ' "speed": 100';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' },';  
                        
                        // Sixth AVL MSG   
                        test += ' {';
                        test += ' "metadata": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 9.07,';
                        test += ' "odometer": 13684.92,';
                        test += ' "speed": 100';
                        test += ' },';
                        test += ' "deviceId": "CalAmp-4542186891-location",';
                        test += ' "messageType": "CalAmp-AVL",';
                        test += ' "timestamp": 1498660159265,';
                        test += ' "eventType": "IGOFF",';
                        test += ' "position": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' },';
                        test += ' "lng": -73.9581756,';
                        test += ' "heading": 0,';
                        test += ' "lat": 40.7263116';
                        test += ' },';
                        test += ' "deviceMessage": {';
                        test += ' "rawDeviceHexMessage": "8305450218689301010102041f5951ed515951ed511846578cd3eae0c40000040f00000016000004210000ff8f001c0000630910000002108400000000000000000000000000000000000000000000000000004aea011ef1418f15211f183ca97ad3e6353100000000000000000000000000001d1a",';
                        test += ' "extendedAccumulatorValues": {},';
                        test += ' "deviceMessageSequenceNumber": 1055,';
                        test += ' "deviceEsn": "4542186891",';
                        test += ' "eventType": "IGOFF",';
                        test += ' "gps": {';
                        test += ' "gps": {';
                        test += ' "satellites": 5,';
                        test += ' "carrier": 0,';
                        test += ' "rssi": -113,';
                        test += ' "address": {';
                        test += ' "address": {';
                        test += ' "country": "US",';
                        test += ' "postedSpeedLimit": 25,';
                        test += ' "city": "Brooklyn",';
                        test += ' "stateProvinceCd": "NY",';
                        test += ' "postalCode": "11222",';
                        test += ' "county": "Kings",';
                        test += ' "addressLatitude": 40.72634,';
                        test += ' "speedLimitUnits": "mph",';
                        test += ' "roadTypeCode": "Paved",';
                        test += ' "addressLongitude": -73.95805,';
                        test += ' "street": "81 Quay St",';
                        test += ' "tollRoadFlag": "false",';
                        test += ' "state": "New York",';
                        test += ' "crossStreet": "Franklin St"';
                        test += ' }';
                        test += ' },';
                        test += ' "odometer": 84.07,';
                        test += ' "heading": 0,';
                        test += ' "latitude": 40.7263116,';
                        test += ' "gpsValidity": false,';
                        test += ' "hdop": 2.8,';
                        test += ' "speed": 100,';
                        test += ' "longitude": -73.9581756';
                        test += ' }';
                        test += ' },';
                        test += ' "deviceId": 3334,';
                        test += ' "commState": {';
                        test += ' "connected": false,';
                        test += ' "networkService": false,';
                        test += ' "dataService": false,';
                        test += ' "roaming": false,';
                        test += ' "voiceCallActive": false,';
                        test += ' "available": false,';
                        test += ' "threeGNetwork": false';
                        test += ' },';
                        test += ' "eventCode": 9,';
                        test += ' "deviceAirId": "U-2459-5F2J",';
                        test += ' "messageUuid": "bb5ab5b7-5af9-11e7-9ec4-6ba4e8fbce3d",';
                        test += ' "eventTime": "2017-06-27T05:29:53.000Z",';
                        test += ' "telemetry": {';
                        test += ' "telemetry": {';
                        test += ' "altitude": 0,';
                        test += ' "fuelUsage": 9.07,';
                        test += ' "odometer": 13684.92,';
                        test += ' "speed": 0';
                        test += ' }';
                        test += ' },';
                        test += ' "lmdirectMessageType": 2,';
                        test += ' "account": {';
                        test += ' "rel": "account",';
                        test += ' "href": "https://connect.calamp.com:443/connect/services/accounts/869",';
                        test += ' "title": "Venture Solar",';
                        test += ' "status": "Enabled"';
                        test += ' }';
                        test += ' },';
                        test += ' "timeInserted": 1498541441378';
                        test += ' }';  
                        
                        test += ' ]';
                        test += ' }';
                    
                    map<string,object> returnDataTEST = (map<string, object>)JSON.deserializeUntyped(test);
                    returnData = returnDataTEST;
                }
                
                list<object> positions = (list<object>)returnData.get('positions');
                
                List<avlEvent> AVLEvents = new List<avlEvent>();
                List<avlEvent> tempAVLEvents = new List<avlEvent>();
                List<avlEvent> DisconnectEvents = new List<avlEvent>();
                
                set<string> invalidEventCodes = new set<string>{'ALIVE', 'CGAIN', 'CLOSS', 'GPSY', 'GPSN'};
                
                for (object msg: positions) 
                {
                    avlevent avlEvent = new avlevent();
                    map<string, object> tempMessage = (map<string, object>)msg;
                    
                    map<string, object> position    = (map<string, object>)tempMessage.get('position');
                    
                    map<string, object> metaData    = (map<string, object>)tempMessage.get('metadata');
                    
                    map<string, object> speedLimit = (map<string, object>)metaData.get('speedLimit');
                    
                    map<string, object> address = new map<string, object>();
                    boolean addressAvailable = true;
                    if (position.get('address') != 'Not Available')
                    {
                        address = (map<string, object>)position.get('address');
                    }
                    else
                    {
                        addressAvailable = false;
                    }
                    
                    //map<string, object> devMessage  = (map<string, object>)tempMessage.get('deviceMessage');
                    
                    if (!invalidEventCodes.contains((string)tempMessage.get('eventType'))){
                        avlevent.eventType          = (string)tempMessage.get('eventType');
                        avlevent.deviceId           = (string)tempMessage.get('deviceId');
                        avlevent.deviceTimeStamp    = (long)tempMessage.get('timestamp');
                        avlevent.eventTime          = (long)tempMessage.get('timestamp');
                    
                        avlevent.latitude           = (decimal)position.get('lat');
                        avlevent.longitude          = (decimal)position.get('lng');
                        //avlevent.heading            = (decimal)position.get('heading');
                        
                        if (metaData.get('speed') != 'Not Available')
                        {
                            avlevent.speed              = (decimal)metaData.get('speed');
                        }
                        else
                        {
                            avlevent.speed = null;
                        }
                        //}
                        
                        if (metaData.get('odometer') != 'Not Available')
                        {
                            avlevent.odometer       = (decimal)metaData.get('odometer');
                        }
                        else
                        {
                            avlevent.odometer       = null;
                        }    
                        
                        if (metaData.get('fuelUsage') != 'Not Available')
                        {
                            avlevent.fuelUsage      = (decimal)metaData.get('fuelUsage');
                        }
                        else
                        {
                            avlevent.fuelUsage      = 0.0;
                        }
                        
                        if (metaData.get('fuelAmount') != 'Not Available')
                        {
                            try
                            {
                                avlevent.fuelAmount      = (decimal)metaData.get('fuelAmount');
                            }
                            catch (Exception e)
                            {
                                avlevent.fuelAmount      = Decimal.valueOf((string)metaData.get('fuelAmount'));
                            }
                        }
                        else
                        {
                            avlevent.fuelAmount      = null;
                        }

                        if (metaData.get('vin') != 'Not Available')
                        {
                           avlevent.vinNumber      = (string)metaData.get('vin');
                        }
                        else
                        {
                           avlevent.vinNumber      = null;
                        }
                        
                        if(vehicle.MA_Live_IoT_Device__r.malive__Vendor__c != 'CalAmp')
                        {
                            if (speedLimit.isEmpty() == false)
                            {
                                if (speedLimit.get('value') != 'Not Available')
                                {
                                    try
                                    {
                                        avlevent.postedSpeedLimit = (integer)speedLimit.get('value');
                                    }
                                    catch (Exception e)
                                    {
                                        avlevent.postedSpeedLimit = Integer.valueOf((string)speedLimit.get('value'));
                                    }
                                }
                            }
                        }

                        if (addressAvailable == true)
                        {
                            avlevent.country            = (string)address.get('country');
                            avlevent.city               = (string)address.get('city');
                            avlevent.postalCode         = (string)address.get('postalCode');
                            avlevent.county             = (string)address.get('county');
                            avlevent.crossStreet        = (string)address.get('crossStreet');
                            avlevent.state              = (string)address.get('state');
                            avlevent.street             = (string)address.get('street');
                            avlevent.tollRoadFlag       = (string)address.get('tollRoadFlag');
                            avlevent.roadTypeCode       = (string)address.get('roadTypeCode');
                            
                            if(vehicle.MA_Live_IoT_Device__r.malive__Vendor__c == 'CalAmp')
                            {
                                avlevent.postedSpeedLimit   = (integer)address.get('postedSpeedLimit');
                            }
                        }
                        
                        //avlEvent.deviceEsn          = (string)devMessage.get('deviceEsn');
                        
                        tempAVLEvents.add(avlEvent);
                    }
                    
                }
                
                for(integer i = 0; i < tempAVLEvents.size(); i++)
                {
                    system.debug('Printout tempAVLEvents');
                    system.debug(tempAVLEvents[i]);
                    
                    // capthure and store battery up events
                    if(tempAVLEvents[i].eventtype == 'POWER_CUT')
                    {
                        DisconnectEvents.add(tempAVLEvents[i]);
                    }
                }
                

                if (tempAVLEvents.size() > 0)
                {
                    AVLEvents = new list<avlEvent>();
                    AVLEvents = tempAVLEvents;
                }
                
                // Used for testing
                for(integer i = 0; i < AVLEvents.size(); i++)
                {
                    system.debug('Printout events');
                    system.debug(AVLEvents[i]);
                }
                    
                if (AVLEvents.size() > 0)
                {
                    decimal MaxSpeed;
                    List<avlEvent> HardBrakeEvents = new List<avlEvent>();
                    List<avlEvent> HardAccelerationEvents = new List<avlEvent>();
                    Long HardBrakeTimeStamp = null;
                    Long HardAccelerationTimeStamp = null;
                    Decimal LastOdometerReading;

                    for (integer i = 0; i < AVLEvents.size(); i++)
                    {
                        if(vehicle.MA_Live_IoT_Device__r.malive__Vendor__c == 'CalAmp')
                        {
                            // get hard breaks
                            if(avlevents[i].eventtype == 'DECEL')
                            {
                                HardBrakeEvents.add(avlEvents[i]);
                            }
                            
                            // get hard accelerations
                            if(avlevents[i].eventtype == 'ACCEL')
                            {
                                HardAccelerationEvents.add(avlEvents[i]);
                            }
                        }
                        else if(vehicle.MA_Live_IoT_Device__r.malive__Vendor__c == 'GM')
                        {
                            // get hard accelerations
                            if (avlevents[i].eventtype =='ACCEL')
                            {
                                if (HardAccelerationTimeStamp != null)
                                {
                                    if(avlevents[i].eventTime - HardAccelerationTimeStamp > 60000)
                                    {
                                        HardAccelerationEvents.add(avlEvents[i]);
                                    }
                                }
                                else
                                {
                                    HardAccelerationEvents.add(avlEvents[i]);
                                }
                                HardAccelerationTimeStamp = avlevents[i].eventTime;
                            }
                               
                            // get hard breaks
                            if (avlevents[i].eventtype == 'DECEL')
                            {
                                if (HardBrakeTimeStamp != null)
                                {
                                    if(avlevents[i].eventTime - HardBrakeTimeStamp > 60000)
                                    {
                                        HardBrakeEvents.add(avlEvents[i]);
                                    }
                                }
                                else
                                {
                                    HardBrakeEvents.add(avlEvents[i]);
                                }
                                HardBrakeTimeStamp = avlevents[i].eventTime;
                            }
                        }
                        else if(vehicle.MA_Live_IoT_Device__r.malive__Vendor__c == 'Geometris')
                        {
                            // get hard breaks
                            if(avlevents[i].eventtype == 'HARDBRAKE')
                            {
                                HardBrakeEvents.add(avlEvents[i]);
                            }
                            
                            // get hard accelerations
                            if(avlevents[i].eventtype == 'HARDACCEL')
                            {
                                HardAccelerationEvents.add(avlEvents[i]);
                            }
                        }
                        
                        if(AVLEvents[i].odometer > LastOdometerReading || LastOdometerReading == null)
                        {
                            LastOdometerReading = AVLEvents[i].odometer;
                        }
                        
                        if (AVLEvents[i].speed > MaxSpeed || MaxSpeed == null)
                        {
                            MaxSpeed = AVLEvents[i].speed;
                        }
                    }

                    
                    decimal RegularFuelUsage;
                    decimal fuelAmount;
                    
                    if(vehicle.MA_Live_IoT_Device__r.malive__Vendor__c == 'CalAmp')
                    {
                        // call method to return map Fuel Usage by state
                        RegularFuelUsage = fuelUsage(AVLEvents);
                    }
                    else
                    {
                        // call method to calculate the fuel usage based off the fuel amount
                        fuelAmount = calculatedFuelUsage(AVLEvents);
                    }
                            
                    // call method to return OBD2 Mileage by state
                    decimal TotalOBD2Distance = OBD2Mileage(AVLEvents);
                    
                    map<string,decimal> stateMileage = OBD2StateMileage(AVLEvents);
                    
                    //map<string,decimal> stateFuelUsage = StateFuelUsage(AVLEvents);
                    
                    // call method to return stops
                    list<StoppingPoint> StoppingPointList = calculateStops(AVLEvents);
                    
                    // call method to return list of max speed events and send alert emails
                    list<SpeedingEvent> MaxSpeedingEventList = maxSpeedMethod(AVLEvents, vehicle.Max_Speed_Threshold__c, vehicle.Name, vehicle.MA_Live_IoT_Device__r.malive__DeviceId__c);
                    
                    // call method to return list of posted speed events and send alert emails
                    list<SpeedingEvent> PostedSpeedingEventList = PostedSpeedMethod(AVLEvents, vehicle.Name, vehicle.MA_Live_IoT_Device__r.malive__DeviceId__c);
                    
                    decimal TotalFuelUsage = 0;
                    decimal FuelEconomy = 0;
                    Long StartTimeLong;
                    Long EndTimeLong;
                    Long StopTime = 0;
                    Decimal stopTimeM = 0;
                    Decimal stopTimeH = 0;
                    Integer NumberOfStops = 0;
                    Long totalTimeMS = 0;
                    Decimal totalTimeM = 0;
                    Decimal totalTimeH = 0;
                    Decimal driveTimeM = 0;
                    Decimal driveTimeH = 0;
                    Decimal avgTimeS = 0.0;
                    Decimal avgTimeM = 0.0;
                    
                    datetime firstPointOfDay = datetime.newInstance(AVLEvents[0].eventTime);
                    datetime lastPointOfDay = datetime.newInstance(AVLEvents[AVLEvents.size()-1].eventTime);

                    if (firstPointOfDay != null)
                    {
                        StartTimeLong = firstPointOfDay.getTime();
                    }

                    if (lastPointOfDay != null)
                    {
                        EndTimeLong = lastPointOfDay.getTime();
                    }
                    
                    if (StartTimeLong != null && EndTimeLong != null)
                    {
                        totalTimeMS = EndTimeLong - StartTimeLong;
                        Long totalTimeS = totalTimeMS / 1000;
                        totalTimeH = totalTimeS / 3600;
                        totalTimeM = totalTimeS / 60;

                        for (StoppingPoint SP : StoppingPointList)
                        {
                            NumberOfStops++;
                            if (SP.StopTime != null)
                            {
                                StopTime += SP.StopTime;
                            }
                        }
                        
                        stopTimeH = StopTime / 3600;
                        stopTimeM = StopTime / 60;

                        Long driveTimeS = totalTimeS - StopTime;
                        driveTimeH = driveTimeS / 3600;
                        driveTimeM = driveTimeS / 60;
                    }
                            
                    // Calculate Fuel Usage
                    if(vehicle.MA_Live_IoT_Device__r.malive__Vendor__c == 'CalAmp')
                    {
                        TotalFuelUsage += RegularFuelUsage;
                    }
                    else
                    {
                       TotalFuelUsage = fuelAmount;
                    }
                    
                    // Calculate Fuel Economy
                    if (TotalFuelUsage != 0)
                    {
                        FuelEconomy = TotalOBD2Distance / TotalFuelUsage;
                    }
                    
                    if (NumberOfStops > 0 && StopTime > 0)
                    {
                        avgTimeS = StopTime / NumberOfStops;
                        avgTimeM = avgTimeS / 60;
                    }
                    
                    list<VehicleDailySummary__c> SummariesToDelete = new list<VehicleDailySummary__c>();
                            
                    for (VehicleDailySummary__c vds : [SELECT Id FROM VehicleDailySummary__c WHERE vehicle__c = :vehicle.Id AND Day__c=:SelectedDay])
                    {
                        SummariesToDelete.add(vds);
                    }
                    system.debug('SummariesToDelete.size '+SummariesToDelete.size());  
                    system.debug('SummariesToDelete '+SummariesToDelete);  
                    delete SummariesToDelete;
                                                    
                    VehicleDailySummary__c Summary = new VehicleDailySummary__c();
                    Summary.vehicle__c = vehicle.Id;
                    Summary.Day__c = SelectedDay;

                    Summary.NumberofStops__c = NumberOfStops;
                    Summary.TotalDistance__c = TotalOBD2Distance;
                    Summary.Fuel_Economy__c = FuelEconomy;
                    Summary.StopTimeHours__c = stopTimeH;
                    Summary.StopTimeMinutes__c = stopTimeM;
                    Summary.TotalTimeHours__c = totalTimeH;
                    Summary.TotalTimeMinutes__c = totalTimeM;
                    Summary.DriveTimeHours__c = driveTimeH;
                    Summary.DriveTimeMinutes__c = driveTimeM;
                    Summary.FirstPointoftheDay__c = firstPointOfDay;
                    Summary.LastPointoftheDay__c = lastPointOfDay;
                    Summary.AverageStopTimeMinutes__c = avgTimeM;
                    Summary.AverageStopTimeSeconds__c = avgTimeS;
                    Summary.Disconnect_Alert__c = DisconnectEvents.size();
                    if (maxSpeed > 0)
                    {
                        Summary.MaxSpeed__c = maxSpeed;
                    }
                    if (LastOdometerReading > 0)
                    {
                        Summary.Last_Odometer_Reading__c = LastOdometerReading;
                    }
                    if(HardAccelerationEvents.size() > 0)
                    {
                        Summary.Total_Number_of_Hard_Acceleration_Events__c = HardAccelerationEvents.size();
                    }
                    if(HardBrakeEvents.size() > 0)
                    {
                        Summary.Total_Number_of_Hard_Braking_Events__c = HardBrakeEvents.size();
                    }
                    if(MaxSpeedingEventList.size() > 0)
                    {
                        Summary.Total_Number_of_Max_Speed_Events__c = MaxSpeedingEventList.size();
                    }
                    if(PostedSpeedingEventList.size() > 0)
                    {
                        Summary.Total_Number_of_Posted_Speed_Events__c = PostedSpeedingEventList.size();
                    }

                    Summary.Driver__c = vehicle.Driver__c;

                    Database.SaveResult sr = Database.insert(Summary);
                    if(sr.isSuccess()) 
                    {
                        system.debug('Success ');
                        system.debug(Summary);
                        
                        list<VehicleStop__c> StopsToInsert = new list<VehicleStop__c>();
    
                        integer StopOrder = 0;
    
                        for (integer x = 0; x < StoppingPointList.size(); x++)
                        {
                            //system.debug('ArrivalDT '+StoppingPointList[x].ArrivalDT);
                            //system.debug('DepartDT '+StoppingPointList[x].DepartDT);
                                    
                            StopOrder++;
        
                            VehicleStop__c VS = new VehicleStop__c();
                            VS.VehicleDailySummary__c = sr.getId();
                            VS.Vehicle__c = vehicle.Id;
                            VS.Order__c = StopOrder;
                            VS.ArrivalTime__c = StoppingPointList[x].ArrivalDT;
                            VS.DepartTime__c = StoppingPointList[x].DepartDT;
                            VS.Address__c = StoppingPointList[x].Address;
                            VS.Odometer__c = StoppingPointList[x].Odometer;
                            VS.Latitude__c = StoppingPointList[x].latitude;
                            VS.Longitude__c = StoppingPointList[x].longitude;
                            if (StoppingPointList[x].ArrivalDT != null && StoppingPointList[x].DepartDT != null)
                            {
                                Long StartTimeStop = StoppingPointList[x].ArrivalDT.getTime();
                                Long EndTimeStop = StoppingPointList[x].DepartDT.getTime();
    
                                decimal totalSTimeMS = EndTimeStop - StartTimeStop;
                                decimal totalSTimeS = totalSTimeMS / 1000;
                                decimal totalSTimeM = 0;
        
                                totalSTimeM = totalSTimeS / 60;
            
                                if (totalSTimeM != null)
                                {
                                    VS.StopTime__c = totalSTimeM.setScale(2);
                                }
                            }

                            if (vehicle.Vehicle_Type__c != null)
                            {
                                if (vehicle.Vehicle_Type__c == 'Sales Vehicle')
                                {
                                    distanceResults stopResults = GetRecordResults('Account', StoppingPointList[x].latitude, StoppingPointList[x].longitude);
                                
                                    if (stopResults.recordDistance != null && stopResults.recordID != null && stopResults.recordID != '')
                                    {
                                        VS.Account__c = stopResults.recordID;
                                    }                                        
                                }
                                else
                                {
                                    distanceResults stopResults = GetRecordResults('Order', StoppingPointList[x].latitude, StoppingPointList[x].longitude);
                                    
                                    if (stopResults.recordDistance != null && stopResults.recordID != null && stopResults.recordID != '')
                                    {
                                        VS.Service_Order__c = stopResults.recordID;
                                    }                                      
                                }
                            }
                            else
                            {
                                distanceResults stopResults = GetRecordResults('Account', StoppingPointList[x].latitude, StoppingPointList[x].longitude);
                                
                                if (stopResults.recordDistance != null && stopResults.recordID != null && stopResults.recordID != '')
                                {
                                    VS.Account__c = stopResults.recordID;
                                }                            
                            }
                            
                            StopsToInsert.add(VS);
                        }
                        Database.SaveResult[] SaveStopsResults = Database.insert(StopsToInsert);
                            
                        list<VehicleDriveTime__c    > VehicleDriveTimesToInsert = new list<VehicleDriveTime__c  >();
        
                        for (integer x = 1; x < StopsToInsert.size(); x++)
                        {
                            VehicleDriveTime__c  VDT = new VehicleDriveTime__c  ();
                            VDT.VehicleDailySummary__c = StopsToInsert[x].VehicleDailySummary__c;
                            VDT.ArrivalAddress__c = StopsToInsert[x].Address__c;
                            VDT.DepartureAddress__c = StopsToInsert[x-1].Address__c;
                            VDT.ArrivalTime__c = StopsToInsert[x].ArrivalTime__c;
                            VDT.DepartTime__c = StopsToInsert[x-1].DepartTime__c;
                            VDT.CurrentStop__c = StopsToInsert[x].Id;
                            VDT.PreviousStop__c = StopsToInsert[x-1].Id;
                            VDT.Odometer__c = StopsToInsert[x].Odometer__c;
                            if(StopsToInsert[x].Odometer__c != null && StopsToInsert[x-1].Odometer__c != null)
                            {
                                VDT.Distance_From_Previous_Stop__c = StopsToInsert[x].Odometer__c - StopsToInsert[x-1].Odometer__c;
                            }
                            VDT.Order__c = x;
                                    
                            if (StopsToInsert[x-1].DepartTime__c != null && StopsToInsert[x].ArrivalTime__c != null)
                            {
                                Long StartTimeStop = StopsToInsert[x-1].DepartTime__c.getTime();
                                Long EndTimeStop = StopsToInsert[x].ArrivalTime__c.getTime();
    
                                decimal totalSTimeMS = EndTimeStop - StartTimeStop;
                                decimal totalSTimeS = totalSTimeMS / 1000;
                                decimal totalSTimeM = 0;
    
                                totalSTimeM = totalSTimeS / 60;
                                if (totalSTimeM != null)
                                {
                                    VDT.Windshield_Time_Minutes__c = totalSTimeM;
                                }
                            }
                                    
                            if (StopsToInsert[x].DepartTime__c != null && StopsToInsert[x].ArrivalTime__c != null)
                            {
                                Long EndTimeStop = StopsToInsert[x].DepartTime__c.getTime();
                                Long StartTimeStop = StopsToInsert[x].ArrivalTime__c.getTime();
    
                                decimal totalSTimeMS = EndTimeStop - StartTimeStop;
                                decimal totalSTimeS = totalSTimeMS / 1000;
                                decimal totalSTimeM = 0;
    
                                totalSTimeM = totalSTimeS / 60;
    
                                if (totalSTimeM != null)
                                {
                                    VDT.LengthOfTimeAtDestinationMinutes__c = totalSTimeM;
                                }
                            }
                                
                            VehicleDriveTimesToInsert.add(VDT);
                        }

                        Database.SaveResult[] SaveDriveTimesResults = Database.insert(VehicleDriveTimesToInsert);
                        
                        list<VehicleStateDriveTime__c> VehicleStateDriveTimesToInsert = new list<VehicleStateDriveTime__c>();
                        
                        for(string key :StateMileage.keySet())
                        {
                            VehicleStateDriveTime__c VSDT = new VehicleStateDriveTime__c();
                            VSDT.Vehicle_Daily_Summary__c = sr.getId();
                            VSDT.State__c = key;
                            VSDT.Mileage__c = StateMileage.get(key);
                            VehicleStateDriveTimesToInsert.add(VSDT);
                        }
                        Database.SaveResult[] SaveVehicleStateDriveTimesResults = Database.insert(VehicleStateDriveTimesToInsert);
                    }
                    else
                    {
                        // Operation failed, so get all errors               
                        for(Database.Error err : sr.getErrors()) 
                        {
                            System.debug('The following error has occurred.');                   
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Daily Vehicle Summary fields that affected this error: ' + err.getFields());
                        }
                    }
                    
                    
                    // VIN Number update
                    
                    for (malive__IoTDevice__c iot : [SELECT Id, malive__DeviceId__c, VIN_Number__c FROM malive__IoTDevice__c WHERE Id =:vehicle.MA_Live_IoT_Device__c])
                    {
                        for (integer i = 0; i < AVLEvents.size(); i++)
                        {
                            if (iot.malive__DeviceId__c == AVLEvents[i].deviceId)
                            {
                                if(AVLEvents[i].vinNumber != null)
                                {
                                    iot.VIN_Number__c = AVLEvents[i].vinNumber;
                                    iot.Last_VIN_Captured_DateTime__c = DateTime.newInstance(AVLEvents[i].eventTime);
                                }                                
                            }
                        }
                        
                        if (iot.VIN_Number__c != null)
                        {
                            update iot;
                        }
                    }
                    
                    
                }
            }
            catch (Exception e)
            {
                system.debug('ERROR: ' + e.getMessage());
                system.debug('ERROR: line number: ' + e.getLineNumber());
            }
        }*/
    }

    global void finish(Database.BatchableContext BC)
    {

    }
    
    /*public class distanceResults
    {
        public string recordID;
        public decimal recordDistance;
    }*/
    
    // find closest account to stop
    /*public distanceResults GetRecordResults(string objectType, decimal Lat, decimal Lng)
    {
        decimal ClosestDistance;
        string ClosestRecordID;

        if (Lat != null && Lng != null)
        {
            decimal CenterLat = Lat;
            decimal CenterLng = Lng;
            
            decimal radiusEarth= 3963.1663751;
            decimal PI = 3.141592653589793238462643383279502884197169399375;
            
            //create an area search
            List<decimal> bearinglist = new decimal[4];
            bearinglist[0] = 360;
            bearinglist[1] = 90;
            bearinglist[2] = 180;
            bearinglist[3] = 270;
            
            MapMethods.Coordinate CenterPoint = new MapMethods.Coordinate();
            CenterPoint.Latitude = CenterLat;
            CenterPoint.Longitude = CenterLng;
            
            decimal toplat;
            decimal bottomlat;
            decimal rightlng;
            decimal leftlng;
            
            //Create Boundry Box
            for(Decimal bearingloop : bearinglist)
            {
                MapMethods.Coordinate ReturnedCoordinate = MapMethods.FindDestinationPoint(CenterPoint, decimal.valueOf(1), bearingloop);
                
                if(bearingloop == 360)
                {
                    toplat = ReturnedCoordinate.Latitude;
                }
                if(bearingloop == 90)
                { 
                    rightlng = ReturnedCoordinate.Longitude;
                }
                if(bearingloop  == 180)
                {
                    bottomlat = ReturnedCoordinate.Latitude;
                }
                if(bearingloop  == 270)
                {
                    leftlng = ReturnedCoordinate.Longitude;
                }
            }

            if (objectType == 'Account')
            {
                string DynamicQry = 'SELECT Id, Name, BillingLatitude, BillingLongitude';
                DynamicQry += ' FROM Account';
                DynamicQry += ' WHERE (BillingLatitude <= '+toplat+' AND BillingLatitude >= '+bottomlat+') AND (BillingLongitude >= '+leftlng+' AND BillingLongitude <= '+rightlng+')';
                
                // Go through all Accounts within Boundary Box and find closest one that is also < 200 feet away
                for (Account acc : Database.query(DynamicQry))
                {
                    decimal accDistance = MapMethods.DistanceHaversine(CenterLat, CenterLng, acc.BillingLatitude, acc.BillingLongitude);
                    
                    accDistance *= 5280; //convert mile to feet
                    
                    // 1320 feet = quarter mile                
                    // 660 feet = half of a quarter mile
                    
                    system.debug('accDistance: ' + accDistance);
                    
                    if (ClosestDistance == null && accDistance <= GeofenceDistanceToStop)
                    {
                        ClosestDistance = accDistance;
                        ClosestRecordID = acc.Id;
                    }
                    else
                    {
                        if (accDistance < ClosestDistance && accDistance <= GeofenceDistanceToStop)
                        {
                            ClosestDistance = accDistance;
                            ClosestRecordID = acc.Id;
                        }
                    }
                }                
            }
            else
            {
                string DynamicQry = 'SELECT Id, BillingLatitude, BillingLongitude';
                DynamicQry += ' FROM Order WHERE Service_Status__c != \'Shipped\' AND Service_Status__c != \'Serviced\'';
                DynamicQry += ' AND (BillingLatitude <= '+toplat+' AND BillingLatitude >= '+bottomlat+') AND (BillingLongitude >= '+leftlng+' AND BillingLongitude <= '+rightlng+')';

                // Go through all Accounts within Boundary Box and find closest one that is also < 200 feet away
                for (Order o : Database.query(DynamicQry))
                {
                    decimal oDistance = MapMethods.DistanceHaversine(CenterLat, CenterLng, o.BillingLatitude, o.BillingLongitude);
                    
                    oDistance *= 5280; //convert mile to feet
                    
                    // 1320 feet = quarter mile                
                    // 660 feet = half of a quarter mile
                    
                    system.debug('oDistance: ' + oDistance);
                    
                    if (ClosestDistance == null && oDistance <= GeofenceDistanceToStop)
                    {
                        ClosestDistance = oDistance;
                        ClosestRecordID = o.Id;
                    }
                    else
                    {
                        if (oDistance < ClosestDistance && oDistance <= GeofenceDistanceToStop)
                        {
                            ClosestDistance = oDistance;
                            ClosestRecordID = o.Id;
                        }
                    }
                }                
            }
        }
        
        distanceResults dr = new distanceResults();
        dr.recordID = ClosestRecordID;
        dr.recordDistance = ClosestDistance;
        return dr;
    }*/

    // Method calculates, error handles and returns OBD2 Mileage
    /*public decimal OBD2Mileage (list<AvlEvent> AVLEvents)
    {
        decimal distance = 0;
        // iterate over all of the events
        for(integer i = 0; i < AVlEvents.size()-1; i++)
        {
            // Declare variable to get mileage
            if (avlEvents[i].odometer != null && avlEvents[i+1].odometer != null)
            {
                if((avlEvents[i+1].odometer - avlEvents[i].odometer) > 0)
                {
                  distance += (avlEvents[i+1].odometer - avlEvents[i].odometer);
                  system.debug('new distance '+distance+' i = '+i);
                }
            }
        }
        
        return distance;
    }*/
    
    /*public map<string,decimal> OBD2StateMileage (list<AvlEvent> AVLEvents)
    {
        Map<String, String> StateCodeToStateNameMap = New Map<String, String>{
            'AL'=>'Alabama', 'AK'=>'Alaska', 'AZ'=>'Arizona', 'AR'=>'Arkansas', 'CA'=>'California', 'CO'=>'Colorado', 'CT'=>'Connecticut', 'DE'=>'Delaware', 
            'DC'=>'District of Columbia', 'FL'=>'Florida', 'GA'=>'Georgia', 'HI'=>'Hawaii', 'ID'=>'Idaho', 'IL'=>'Illinois', 'IN'=>'Indiana', 'IA'=>'Iowa', 
            'KS'=>'Kansas', 'KY'=>'Kentucky', 'LA'=>'Louisiana', 'ME'=>'Maine', 'MD'=>'Maryland', 'MA'=>'Massachusetts', 'MI'=>'Michigan', 'MN'=>'Minnesota', 
            'MS'=>'Mississippi', 'MO'=>'Missouri', 'MT'=>'Montana', 'NE'=>'Nebraska', 'NV'=>'Nevada', 'NH'=>'New Hampshire', 'NJ'=>'New Jersey', 'NM'=>'New Mexico', 
            'NY'=>'New York', 'NC'=>'North Carolina', 'ND'=>'North Dakota', 'OH'=>'Ohio', 'OK'=>'Oklahoma', 'OR'=>'Oregon', 'PA'=>'Pennsylvania', 'RI'=>'Rhode Island', 
            'SC'=>'South Carolina', 'SD'=>'South Dakota', 'TN'=>'Tennessee', 'TX'=>'Texas', 'UT'=>'Utah', 'VT'=>'Vermont', 'VA'=>'Virginia', 'WA'=>'Washington', 
            'WV'=>'West Virginia', 'WI'=>'Wisconsin', 'WY'=>'Wyoming' 
        };

        decimal distance = 0;
        string state = null;
        string lastStateVar = null;
        map<string,decimal> stateMileageMap = new map<string,decimal>();
        // iterate over all of the events
        for(integer i = 0; i < AVlEvents.size(); i++)
        {
            // assign the last state var
            lastStateVar = state;
            if(state != AVLEvents[i].state && AVLEvents[i].state != null) 
            {
                state = AVLEvents[i].state;
            }
            else if (AVLEvents[i].state == null)
            {
                state = 'Not Available'; 
            }
            else
            {
                state = AVLEvents[i].state;
            }
            
            // state has changed
            if((lastStateVar != state && distance > 0) || i == AVlEvents.size()-1)
            {
                if(stateMileageMap.containsKey(lastStateVar))
                {
                    decimal oldDistance = stateMileageMap.Remove(lastStateVar);
                    stateMileageMap.put(lastStateVar,oldDistance+distance);
                }
                else
                {
                    stateMileageMap.put(lastStateVar,distance);
                }
                distance = 0;
                
                if(i != AVlEvents.size()-1)
                {
                    if (avlEvents[i].odometer != null && avlEvents[i+1].odometer != null)
                    {
                        if((avlEvents[i+1].odometer - avlEvents[i].odometer) > 0)
                        {
                            distance += (avlEvents[i+1].odometer - avlEvents[i].odometer);
                        }
                    }
                }
            }
            else
            {
                if (avlEvents[i].odometer != null && avlEvents[i+1].odometer != null)
                {
                    if((avlEvents[i+1].odometer - avlEvents[i].odometer) > 0)
                    {
                        distance += (avlEvents[i+1].odometer - avlEvents[i].odometer);
                    }
                }
            }
        }
        
        system.debug('stateMileageMap');
        system.debug(stateMileageMap);
        
        // iterate over map 
        for(String key: stateMileageMap.keySet())
        {
            // if state less than equal to two chars
            if(key.length() <= 2)
            {
                // if there is a matching state name in StateCodeToStateNameMap
                if(StateCodeToStateNameMap.get(key) != null)
                {
                    // save the vlaue from stateMileageMap and remove the data
                    decimal oldDistance = stateMileageMap.remove(key);
                    // create a new element with state name and value
                    stateMileageMap.put(StateCodeToStateNameMap.get(key),oldDistance);
                }
            }
        }

        return stateMileageMap;
    }*/

    // Method calculates, error handles and returns Fuel Usage
    /*public decimal fuelUsage (list<AvlEvent> AVLEvents)
    {
        decimal fuel = 0;
        // iterate over all of the events
        for(integer i = 0; i < AVlEvents.size()-1; i++)
        {
            // Declare variable to get mileage
            if (avlEvents[i].fuelUsage != null)
            {
                fuel += (avlEvents[i+1].fuelUsage - avlEvents[i].fuelUsage);
            }
        }
        
        return fuel;
    }*/
    
    // used for non-calamp devices
    /*public decimal calculatedFuelUsage (list<AvlEvent> AVLEvents)
    {
        decimal lowestFuelLevel;
        decimal firstFuelLevel;
        list<decimal> fuelDifferenceArray = new list<decimal>();
        
        // to store all AVL events where the fuel is != null
        list<AVlEvent> AVLEventsWithFuelAmount = new list<AVLEvent>();
        
        // iterate through all of the events to remove nulls
        for(integer i = 0; i < AVlEvents.size(); i++)
        {
            if (AVlEvents[i].fuelAmount != null)
            {
                system.debug('fuelAmount Insert (Remove Nulls)');
                system.debug(AVlEvents[i].fuelAmount);
                AVLEventsWithFuelAmount.add(AVlEvents[i]);
            }
        }
        
        for (integer i = 0; i < AVLEventsWithFuelAmount.size(); i++)
        {
            if(i == 0 )
            {
                firstFuellevel = AVLEventsWithFuelAmount[i].fuelAmount;
                lowestFuelLevel = AVLEventsWithFuelAmount[i].fuelAmount;
            }
            else if(AVLEventsWithFuelAmount[i].fuelAmount < lowestFuelLevel)
            {
                lowestFuelLevel = AVLEventsWithFuelAmount[i].fuelAmount;
                system.debug('new lowest fuel level '+lowestFuelLevel);
            }
            
            if (((AVLEventsWithFuelAmount[i].fuelAmount - lowestFuelLevel)  > 2) || (i == AVLEventsWithFuelAmount.size()-1))
            {
                system.debug('add fuel changes to fuelDifferenceArray');
                decimal fuelchange = firstFuelLevel - lowestFuelLevel;
                fuelDifferenceArray.add(fuelChange);
                firstFuelLevel = AVLEventsWithFuelAmount[i].fuelAmount;
                lowestFuelLevel = AVLEventsWithFuelAmount[i].fuelAmount;
            }
        }
        
        decimal totalFuelUsed = 0;
        
        system.debug('fuelDifferenceArray');
        system.debug(fuelDifferenceArray);
        system.debug(fuelDifferenceArray.size());
        
        for (integer i = 0; i < fuelDifferenceArray.size(); i ++)
        {
            totalFuelUsed += fuelDifferenceArray[i];
        }

        
        return totalFuelUsed;
    }*/
    
    // used to send email to client
    /*global void sendClientEmail(string body, string subject)
    {
        list<string> emailAddresses = new list<string>();
        for(User u :users)
        {
            if(u.Email != null)
            {
                emailAddresses.add(u.Email);
            }
        }
    
        //EmailAddresses.add('jhoneycutt@mapanything.com');
        
        if(emailAddresses.size() > 0)
        {
            string resBody = body;
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.ToAddresses = EmailAddresses;
            message.Subject = subject;
            message.htmlBody = resBody;
                
            Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] rslts = Messaging.sendEmail(messages);
                
            if (rslts[0].success) {
                System.debug('The email was sent successfully.');
            } else {
                System.debug('The email failed to send: ' + rslts[0].errors[0].message);
            }
        }
    }*/

    // Stopping point class used by calculateStops Method
    /*public class StoppingPoint
    {
        public datetime ArrivalDT;
        public datetime DepartDT;
        public integer Order;
        public long StopTime;
        public decimal latitude;
        public decimal longitude;
        public string Address;
        public decimal Odometer;
    }*/

    // Method Calculates Vehicle Stop and Returns List of Vehicle Stops
    /*public list<StoppingPoint> calculateStops(List<AVLEvent> AVLEvents)
    {
        boolean CurrentlyStopped = false;
        datetime StopArrivalTime;
        datetime StopDepartTime;
        integer NumOfStops = 0;
        
        integer StartIndex;
        //decimal StartOdometer;
        decimal StartLat;
        decimal StartLng;
    
        map<integer, StoppingPoint> StoppingPointGroups = new map<integer, StoppingPoint>();
        list<StoppingPoint> StoppingPointList = new list<StoppingPoint>();
        list<list<integer>> AllStops = new list<list<integer>>();
        list<integer> StoppedPointsArray = new list<integer>();
        list<integer> AllStoppingPoints = new list<integer>();
    
        NumOfStops++;
        StoppingPoint SP1 = new StoppingPoint();
        SP1.DepartDT = datetime.newInstance(AVLEvents[0].deviceTimeStamp);
        SP1.Order = NumOfStops;
        SP1.latitude = AVLEvents[0].latitude;
        SP1.longitude = AVLEvents[0].longitude;
        SP1.Odometer = AVLEvents[0].odometer;
        string tempAddress1 = '';
            tempAddress1 += (AVLEvents[0].street != null ? AVLEvents[0].street + ', ' : '');
            tempAddress1 += (AVLEvents[0].city != null ? AVLEvents[0].city + ', ' : '');
            tempAddress1 += (AVLEvents[0].state != null ? AVLEvents[0].state + ', ' : '');
            tempAddress1 += (AVLEvents[0].postalCode != null ? AVLEvents[0].postalCode : '');
    
        SP1.Address = tempAddress1;
        StoppingPointGroups.put(0,SP1);
        StoppingPointList.add(SP1);
    
        for(integer i = 0; i < AVLEvents.size(); i++)
        {
            if (AVLEvents[i].latitude != null && AVLEvents[i].longitude != null)
            {
                if (StartIndex == null)
                {
                    StartIndex = i;
                    //StartOdometer = AVLEvents[i].odometer;
                    StartLat = AVLEvents[i].latitude;
                    StartLng = AVLEvents[i].longitude;
                }
                else if (MapMethods.DistanceHaversine(StartLat, StartLng, AVLEvents[i].latitude, AVLEvents[i].longitude) > StopDistanceCriteria)
                {
                    datetime StartTime = datetime.newInstance(AVLEvents[StartIndex].eventTime);
                    datetime EndTime = datetime.newInstance(AVLEvents[i].eventTime);
                                
                    long StartTimeLong = StartTime.getTime();
                    long endTimeLong = EndTime.getTime();
                                
                    Long MS = EndTimeLong - StartTimeLong;
                    Long stopTime = MS / 1000;

                    if (stopTime >= StopTimeCriteria)                                
                    {
                        // Odometer moved less than 0.25 for 10+ minutes
                        NumOfStops++;
                        StartIndex = null;
                        //StartOdometer = null;
                                    
                        StoppingPoint SP = new StoppingPoint();
                        SP.ArrivalDT = StartTime;
                        SP.DepartDT = EndTime;
                                    
                        SP.Order = NumOfStops;
                        SP.StopTime = stopTime;
                                    
                        string tempAddress = '';

                        if (i > 0)
                        {
                            SP.latitude = AVLEvents[i-1].latitude;
                            SP.longitude = AVLEvents[i-1].longitude;
                            SP.Odometer = AVLEvents[i-1].odometer;
                            tempAddress += (AVLEvents[i-1].street != null ? AVLEvents[i-1].street + ', ' : '');
                            tempAddress += (AVLEvents[i-1].city != null ? AVLEvents[i-1].city + ', ' : '');
                            tempAddress += (AVLEvents[i-1].state != null ? AVLEvents[i-1].state + ', ' : '');
                            tempAddress += (AVLEvents[i-1].postalCode != null ? AVLEvents[i-1].postalCode : '');
                        }
                        else
                        {
                            SP.latitude = AVLEvents[i].latitude;
                            SP.longitude = AVLEvents[i].longitude;
                            SP.Odometer = AVLEvents[i].odometer;
                            tempAddress += (AVLEvents[i].street != null ? AVLEvents[i].street + ', ' : '');
                            tempAddress += (AVLEvents[i].city != null ? AVLEvents[i].city + ', ' : '');
                            tempAddress += (AVLEvents[i].state != null ? AVLEvents[i].state + ', ' : '');
                            tempAddress += (AVLEvents[i].postalCode != null ? AVLEvents[i].postalCode : '');
                        }

                        SP.Address = tempAddress;
                        StoppingPointList.add(SP);
                    }
                    else
                    {
                        i = StartIndex;
                        StartIndex = null;
                        //StartOdometer = null;
                    }
                }
            }
        }
    
        NumOfStops++;
        StoppingPoint SP2 = new StoppingPoint();
        SP2.ArrivalDT = DateTime.newInstance(AVLEvents[AVLEvents.size() - 1].deviceTimeStamp);
        SP2.Order = NumOfStops;
        SP2.latitude = AVLEvents[AVLEvents.size() - 1].latitude;
        SP2.longitude = AVLEvents[AVLEvents.size() - 1].longitude;
        SP2.Odometer = AVLEvents[AVLEvents.size() - 1].odometer;
    
        string tempAddress2 = '';
            tempAddress2 += (AVLEvents[AVLEvents.size() - 1].street != null ? AVLEvents[AVLEvents.size() - 1].street + ', ' : '');
            tempAddress2 += (AVLEvents[AVLEvents.size() - 1].city != null ? AVLEvents[AVLEvents.size() - 1].city + ', ' : '');
            tempAddress2 += (AVLEvents[AVLEvents.size() - 1].state != null ? AVLEvents[AVLEvents.size() - 1].state + ', ' : '');
            tempAddress2 += (AVLEvents[AVLEvents.size() - 1].postalCode != null ? AVLEvents[AVLEvents.size() - 1].postalCode : '');
    
        SP2.Address = tempAddress2;
        StoppingPointGroups.put(AVLEvents.size() - 1,SP2);
        StoppingPointList.add(SP2);
    
        return StoppingPointList;
    }*/
    
    // used to calculate and return list of maxSpeedingEvents
    /*public list<SpeedingEvent> maxSpeedMethod(list<AvlEvent> AVLEvents,Decimal MaxSpeedThreshold, string eqName, string eqdevice)
    {
        datetime startTimeSpeedingEvent = null;
        datetime endTimeSpeedingEvent = null;
        string startSpeedingEventAddress = null;
        string endSpeedingEventAddress = null;
        Decimal startSpeedingEventLatitude = null;
        Decimal endSpeedingEventLatitude = null;
        Decimal startSpeedingEventLongitude = null;
        Decimal endSpeedingEventLongitude = null;
        Decimal startSpeedingEventOdometer = null;
        Decimal endSpeedingEventOdometer = null;
        Decimal startSpeedingEventSpeed = null;
        Decimal endSpeedingEventSpeed = null;
        boolean OverSpeedLimit = false;
        datetime overSpeedLimitTimeStamp = null;
        list<SpeedingEvent> MaxSpeedingEventList = new list<SpeedingEvent>();
                        
        for(integer i = 0; i < AVlEvents.size(); i++)
        {
            /// Max Speed Code
            if (MaxSpeedThreshold != null)
            {
                // if vehicle is speeding
                if (AVLEvents[i].speed > MaxSpeedThreshold)
                {
                    system.debug('vehicle is speeding');
                    // if eqal to null then first loop so set else
                    if (startTimeSpeedingEvent == null)
                    {
                        startTimeSpeedingEvent = datetime.newInstance(AVLEvents[i].eventTime);
                        startSpeedingEventLatitude = AVLEvents[i].latitude;
                        startSpeedingEventLongitude = AVLEvents[i].longitude;
                        startSpeedingEventOdometer = AVLEvents[i].odometer;
                                        
                        string startSpeedingAddress = '';
                        startSpeedingAddress += (AVLEvents[i].street != null ? AVLEvents[i].street + ', ' : '');
                        startSpeedingAddress += (AVLEvents[i].city != null ? AVLEvents[i].city + ', ' : '');
                        startSpeedingAddress += (AVLEvents[i].state != null ? AVLEvents[i].state + ', ' : '');
                        startSpeedingAddress += (AVLEvents[i].postalCode != null ? AVLEvents[i].postalCode : '');
                        startSpeedingEventAddress = startSpeedingAddress;
                        
                        startSpeedingEventSpeed = AVLEvents[i].speed;

                    }

                    if (AVLEvents[i].speed > MaxSpeedThreshold)
                    {
                        // for email notification
                        system.debug('Speed Alert Email');
                        OverSpeedLimit = true;
                        overSpeedLimitTimeStamp = datetime.newInstance(AVLEvents[i].eventTime);
                    }
                }
                // not speeding check to see if it was speeding
                else if (startTimeSpeedingEvent != null)
                {
                    system.debug('Not Speeding Anymore');
                    endTimeSpeedingEvent = datetime.newInstance(AVLEvents[i].eventTime);
                    endSpeedingEventLatitude = AVLEvents[i].latitude;
                    endSpeedingEventLongitude = AVLEvents[i].longitude;
                    endSpeedingEventOdometer = AVLEvents[i].odometer;
                                    
                    string endSpeedingAddress = '';
                    endSpeedingAddress += (AVLEvents[i].street != null ? AVLEvents[i].street + ', ' : '');
                    endSpeedingAddress += (AVLEvents[i].city != null ? AVLEvents[i].city + ', ' : '');
                    endSpeedingAddress += (AVLEvents[i].state != null ? AVLEvents[i].state + ', ' : '');
                    endSpeedingAddress += (AVLEvents[i].postalCode != null ? AVLEvents[i].postalCode : '');
                    endSpeedingEventAddress = endSpeedingAddress;
                    
                    endSpeedingEventSpeed = AVLEvents[i].speed;
                }
            }
            // else if not speeding check to see if driver had been speeding
            else if (startTimeSpeedingEvent != null)
            {
                system.debug('Not Speeding Anymore');
                endTimeSpeedingEvent = datetime.newInstance(AVLEvents[i].eventTime);
                endSpeedingEventLatitude = AVLEvents[i].latitude;
                endSpeedingEventLongitude = AVLEvents[i].longitude;
                endSpeedingEventOdometer = AVLEvents[i].odometer;
                                
                string endSpeedingAddress = '';
                endSpeedingAddress += (AVLEvents[i].street != null ? AVLEvents[i].street + ', ' : '');
                endSpeedingAddress += (AVLEvents[i].city != null ? AVLEvents[i].city + ', ' : '');
                endSpeedingAddress += (AVLEvents[i].state != null ? AVLEvents[i].state + ', ' : '');
                endSpeedingAddress += (AVLEvents[i].postalCode != null ? AVLEvents[i].postalCode : '');
                endSpeedingEventAddress = endSpeedingAddress;
                
                endSpeedingEventSpeed = AVLEvents[i].speed;
            }
                            
            // check to see if a speeding event has occured
            if (startTimeSpeedingEvent != null && endTimeSpeedingEvent != null)
            {
                system.debug('Create Speeding Point Object');
                SpeedingEvent SpeedingEvent = new SpeedingEvent();
                SpeedingEvent.ArrivalDT = startTimeSpeedingEvent;
                SpeedingEvent.DepartDT = endTimeSpeedingEvent;
                SpeedingEvent.startAddress = startSpeedingEventAddress;
                SpeedingEvent.endAddress = endSpeedingEventAddress;
                SpeedingEvent.startLatitude = startSpeedingEventLatitude;
                SpeedingEvent.endLatitude = endSpeedingEventLatitude;
                SpeedingEvent.startLongitude = startSpeedingEventLongitude;
                SpeedingEvent.endLongitude = endSpeedingEventLongitude;
                SpeedingEvent.startOdometer = startSpeedingEventOdometer;
                SpeedingEvent.endOdometer = endSpeedingEventOdometer;
                SpeedingEvent.startSpeed = startSpeedingEventSpeed;
                SpeedingEvent.endSpeed = endSpeedingEventSpeed;
                
                SpeedingEvent.eventType = 'Max Speed';
                                
                MaxSpeedingEventList.add(SpeedingEvent);
                                
                startTimeSpeedingEvent = null;
                endTimeSpeedingEvent = null;
                startSpeedingEventAddress = null;
                endSpeedingEventAddress = null;
                startSpeedingEventLatitude = null;
                endSpeedingEventLatitude = null;
                startSpeedingEventLongitude = null;
                endSpeedingEventLongitude = null;
                startSpeedingEventOdometer = null;
                endSpeedingEventOdometer = null;
            }
        }
        
        if (MaxSpeedingEventList.size() > 0)
        {
            if (AlertStartDateTimeRange != null && AlertEndDateTimeRange != null)
            {
                list<SpeedingEvent> SpeedingEventListToEmail = new list<SpeedingEvent>();

                for(SpeedingEvent sp : MaxSpeedingEventList)
                {
                    if (AlertStartDateTimeRange <= sp.DepartDT && AlertEndDateTimeRange >= sp.ArrivalDT)
                    {
                        SpeedingEventListToEmail.add(sp);
                    }
                }
                
                if (SpeedingEventListToEmail.size() > 0)
                {
                    string subject = 'Max Speed Alert on Vehicle: ' + eqName;
                    string resBody = '<h3>Max Speeding Incidents</h3>';
                           resBody += '<b>Vehicle Name: ' + eqName + '</b><br>';
                           resBody += '<b>Device ESN #: ' + eqDevice + '</b><table>';
                    for(SpeedingEvent sp : SpeedingEventListToEmail)
                    {
                        resBody += '<tr><th>Start Speed</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><th>End Speed</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><th>Speeding Start Time</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>';
                        resbody += '<th>Speeding End Time</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>';
                        resBody += '<tr><td>'+sp.startSpeed+'</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>'+sp.endSpeed+'</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>'+sp.ArrivalDT.format()+'</td>';
                        resBody += '<td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>'+sp.DepartDT.format()+'</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><tr>';
                    }
                    resBody += '</table>';
        
                    sendClientEmail(resBody, subject);                    
                }
            }
        }
        return MaxSpeedingEventList;
    }*/
    
    // Used to calculate list of posted speeding events
    /*public list<SpeedingEvent> postedSpeedMethod(list<AvlEvent> AVLEvents, string eqName, string eqdevice)
    {
        datetime startTimeSpeedingEvent = null;
        datetime endTimeSpeedingEvent = null;
        string startSpeedingEventAddress = null;
        string endSpeedingEventAddress = null;
        Decimal  startSpeedingEventLatitude = null;
        Decimal endSpeedingEventLatitude = null;
        Decimal startSpeedingEventLongitude = null;
        Decimal endSpeedingEventLongitude = null;
        Decimal startSpeedingEventOdometer = null;
        Decimal endSpeedingEventOdometer = null;
        Decimal startSpeedingEventSpeed = null;
        Decimal endSpeedingEventSpeed = null;
        long speedTrackerTimer = null;
        boolean OverSpeedLimit = false;
        integer postedSpeed;
        
        datetime overSpeedLimitTimeStamp = null;
        integer speedLimit = null;
        Decimal vehicleSpeed = null;
        
        list<SpeedingEvent> PostedSpeedingEventList = new list<SpeedingEvent>();
                        
        for(integer i = 0; i < AVlEvents.size(); i++)
        {
            system.debug('vehicle speed '+AVLEvents[i].speed);
            system.debug('posted speed '+AVLEvents[i].postedSpeedlimit);
            system.debug('time '+datetime.newInstance(AVLEvents[i].eventTime));

            if(AVLEvents[i].postedSpeedlimit != null && AVLEvents[i].postedSpeedlimit > 0)
            {
                // if vehicle is speeding
                if (AVLEvents[i].speed >= AVLEvents[i].postedSpeedlimit + 10)
                {
                    system.debug('VEHICLE IS SPEEDING');

                    // if eqal to null then first loop so set else
                    if (speedTrackerTimer == null)
                    {
                        system.debug('Start Tracker Timer');
                        // assign timer to see if driver is speeding
                        speedTrackerTimer = AVLEvents[i].eventTime;
                    }
                    else if (((AVLEvents[i].eventTime - speedTrackerTimer)/1000) > 60 && startTimeSpeedingEvent == null)
                    {
                        // driver is speeding
                        system.debug('vehicle has been speeding for more than 60 seconds');
                        system.debug('Seconds spent speeding');
                        system.debug(((AVLEvents[i].eventTime - speedTrackerTimer)/1000));
                                        
                        startTimeSpeedingEvent = datetime.newInstance(speedTrackerTimer);
                        startSpeedingEventLatitude = AVLEvents[i].latitude;
                        startSpeedingEventLongitude = AVLEvents[i].longitude;
                        startSpeedingEventOdometer = AVLEvents[i].odometer;
                                        
                        string startSpeedingAddress = '';
                        startSpeedingAddress += (AVLEvents[i].street != null ? AVLEvents[i].street + ', ' : '');
                        startSpeedingAddress += (AVLEvents[i].city != null ? AVLEvents[i].city + ', ' : '');
                        startSpeedingAddress += (AVLEvents[i].state != null ? AVLEvents[i].state + ', ' : '');
                        startSpeedingAddress += (AVLEvents[i].postalCode != null ? AVLEvents[i].postalCode : '');
                        startSpeedingEventAddress = startSpeedingAddress;
                        
                        startSpeedingEventSpeed = AVLEvents[i].speed;
                        
                        postedSpeed = AVLEvents[i].postedSpeedlimit;
                                        
                        if (OverSpeedLimit == false)
                        {
                            system.debug('Speed Posted Alert Email');
                            // set values for email alert                 
                            speedLimit = AVLEvents[i].postedSpeedlimit;
                            vehicleSpeed = AVLEvents[i].speed;
                            OverSpeedLimit = true;
                            overSpeedLimitTimeStamp = datetime.newInstance(AVLEvents[i].eventTime);
                        }
                    }
                }
                else 
                {
                    // driver is not speeding at the moment
                    if (speedTrackerTimer != null)
                    {
                        // driver was speeding...
                        if (startTimeSpeedingEvent != null && endTimeSpeedingEvent == null)
                        {
                            // value exists so driver was speeding for more than 60 seconds.
                            system.debug('vehicle was speeding for more than 60 seconds but has now slowed');
                            endTimeSpeedingEvent = datetime.newInstance(AVLEvents[i].eventTime);
                            endSpeedingEventLatitude = AVLEvents[i].latitude;
                            endSpeedingEventLongitude = AVLEvents[i].longitude;
                            endSpeedingEventOdometer = AVLEvents[i].odometer;
                                            
                            string endSpeedingAddress = '';
                            endSpeedingAddress += (AVLEvents[i].street != null ? AVLEvents[i].street + ', ' : '');
                            endSpeedingAddress += (AVLEvents[i].city != null ? AVLEvents[i].city + ', ' : '');
                            endSpeedingAddress += (AVLEvents[i].state != null ? AVLEvents[i].state + ', ' : '');
                            endSpeedingAddress += (AVLEvents[i].postalCode != null ? AVLEvents[i].postalCode : '');
                            endSpeedingEventAddress = endSpeedingAddress;
                            
                            endSpeedingEventSpeed = AVLEvents[i].speed;
                        }
                        else
                        {
                            system.debug('Not Speeding Anymore');
                            speedTrackerTimer = null;
                        }

                    }
                }
            }
            else if (speedTrackerTimer != null)
            {
                system.debug('Posted speed is either null or 0');
                                
                // reset vlaues for next iteration
                startTimeSpeedingEvent = null;
                endTimeSpeedingEvent = null;
                startSpeedingEventAddress = null;
                endSpeedingEventAddress = null;
                startSpeedingEventLatitude = null;
                endSpeedingEventLatitude = null;
                startSpeedingEventLongitude = null;
                endSpeedingEventLongitude = null;
                startSpeedingEventOdometer = null;
                endSpeedingEventOdometer = null;
                speedTrackerTimer = null;
                postedSpeed = null;
            }
                            
            // check to see if a posted speeding event has occured
            if (startTimeSpeedingEvent != null && endTimeSpeedingEvent != null)
            {
                system.debug('Create Speeding Point Object (posted speed)');
                SpeedingEvent SpeedingEvent = new SpeedingEvent();
                SpeedingEvent.ArrivalDT = startTimeSpeedingEvent;
                SpeedingEvent.DepartDT = endTimeSpeedingEvent;
                SpeedingEvent.startAddress = startSpeedingEventAddress;
                SpeedingEvent.endAddress = endSpeedingEventAddress;
                SpeedingEvent.startLatitude = startSpeedingEventLatitude;
                SpeedingEvent.endLatitude = endSpeedingEventLatitude;
                SpeedingEvent.startLongitude = startSpeedingEventLongitude;
                SpeedingEvent.endLongitude = endSpeedingEventLongitude;
                SpeedingEvent.startOdometer = startSpeedingEventOdometer;
                SpeedingEvent.endOdometer = endSpeedingEventOdometer;
                SpeedingEvent.startSpeed = startSpeedingEventSpeed;
                SpeedingEvent.endSpeed = endSpeedingEventSpeed;
                SpeedingEvent.postedSpeed = postedSpeed;
                SpeedingEvent.eventType = 'Posted Speed';

                PostedSpeedingEventList.add(SpeedingEvent);
                            
                // reset vlaues for next iteration
                startTimeSpeedingEvent = null;
                endTimeSpeedingEvent = null;
                startSpeedingEventAddress = null;
                endSpeedingEventAddress = null;
                startSpeedingEventLatitude = null;
                endSpeedingEventLatitude = null;
                startSpeedingEventLongitude = null;
                endSpeedingEventLongitude = null;
                startSpeedingEventOdometer = null;
                endSpeedingEventOdometer = null;
                speedTrackerTimer = null;
                postedSpeed = null;
            }
        }
        
        if (PostedSpeedingEventList.size() > 0)
        {
            if (AlertStartDateTimeRange != null && AlertEndDateTimeRange != null)
            {
                list<SpeedingEvent> SpeedingEventListToEmail = new list<SpeedingEvent>();

                for(SpeedingEvent sp : PostedSpeedingEventList)
                {
                    if (AlertStartDateTimeRange <= sp.DepartDT && AlertEndDateTimeRange >= sp.ArrivalDT)
                    {
                        SpeedingEventListToEmail.add(sp);
                    }
                }
                
                if (SpeedingEventListToEmail.size() > 0)
                {
                    string subject = 'Posted Speed Alert on Vehicle: ' + eqName;
                    string resBody = '<h3>Posted Speeding Incident(s)</h3>';
                           resBody += '<b>Vehicle Name: ' + eqName + '</b><br>';
                           resBody += '<b>Device ESN #: ' + eqDevice + '</b><table>';
                    for(SpeedingEvent sp : SpeedingEventListToEmail)
                    {
                        resBody += '<tr><th>Start Speed</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><th>End Speed</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><th>Posted Speed</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>';
                        resbody += '<th>Speeding Start Time</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><th>Speeding End Time</th><td>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>';
                        resBody += '<tr><td>'+sp.startSpeed+'</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>'+sp.endSpeed+'</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>'+sp.postedSpeed+'</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td>';
                        resBody += '<td>'+sp.ArrivalDT.format()+'</td>';
                        resBody += '<td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>'+sp.DepartDT.format()+'</td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><tr>';
                    }
                    resBody += '</table>';
        
                    sendClientEmail(resBody, subject);                    
                }
            }            
        }
        return PostedSpeedingEventList;
    }*/
    
    // container for storing events from gateway
    /*public class avlEvent
    {
        public string deviceEsn;
        public string deviceId;
        public long eventTime;
        public long deviceTimestamp;
        public string eventType;
        public integer carrier;
        public boolean gpsValidity;
        public decimal hdop;
        public decimal heading;
        public decimal latitude;
        public decimal longitude;
        public decimal odometer;
        public decimal rssi;
        public decimal satellites;
        public decimal speed;
        public string street;
        public string city;
        public string state;
        public string postalCode;
        public string country;
        public string county;
        public string crossStreet;
        public string roadTypeCode;
        public string tollRoadFlag;
        public decimal fuelUsage;
        public integer postedSpeedLimit;
        public decimal fuelAmount;
        public string vinNumber;
        //public decimal InstantFuelEconomy;
    }*/
    
    // Used to identify starting and stopping speediing point
    /*public class SpeedingEvent
    {
        public datetime ArrivalDT;
        public datetime DepartDT;
        public decimal startLatitude;
        public decimal endLatitude;
        public decimal startLongitude;
        public decimal endLongitude;
        public string startAddress;
        public string endAddress;
        public decimal startOdometer;
        public decimal endOdometer;
        public string eventType;
        public decimal startSpeed;
        public decimal endSpeed;
        public decimal postedSpeed;
    }*/
}