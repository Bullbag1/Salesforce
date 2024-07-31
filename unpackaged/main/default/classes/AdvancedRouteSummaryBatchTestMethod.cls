@isTest(SeeAllData=true)
global class AdvancedRouteSummaryBatchTestMethod {

    public static testMethod void test1()
    {
        /*User usr = [Select id from User where Id = :UserInfo.getUserId()];
        
        CreateTestData();*/
        
        Test.startTest();
        database.executeBatch(new AdvancedRouteSummaryBatch(),1);
        //database.executeBatch(new AdvancedRouteSummaryBatch(date.newinstance(2017, 6, 27)),1);
        Test.stopTest();
    }
    
    /*private static void CreateTestData()
    {
        malive__IoTDevice__c iotDevice = new malive__IoTDevice__c();
        iotDevice.Name = 'test';
        iotDevice.malive__DeviceId__c = '123456';
        iotDevice.malive__Vendor__c = 'CalAmp';
        insert iotDevice;
        
        Vehicle__c vehicle = new Vehicle__c();
        vehicle.Name = 'test';
        vehicle.MA_Live_IoT_Device__c = iotDevice.Id;
        insert vehicle;
    }*/
}