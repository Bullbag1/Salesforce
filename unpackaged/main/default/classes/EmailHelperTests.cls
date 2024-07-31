@isTest(SeeAllData=false)
public class EmailHelperTests {
    
    @TestSetup
    static void setupTestData() {
        EmailTemplate et = new EmailTemplate(
            Subject = 'Test Template',
            DeveloperName = 'Test_Template',
            TemplateType= 'visualforce',
            Markup = '<messaging:emailTemplate subject="Order Serviced" recipientType="Contact" relatedToType="Order">'
            	+ '<messaging:htmlEmailBody>This is test template</messaging:htmlEmailBody></messaging:emailTemplate>',
            Name = 'Test Template',
            IsActive = true,
            FolderId = UserInfo.getUserId()
        );
        insert et;
    }

    @isTest
    static void integrationTest() {
        Test.startTest();
        EmailHelper helper = new EmailHelper();
        helper.addEmailToQueue(
            new List<String>{'test1@cloudanswers.com'}, 
            null, 'Test_Template', null, null
        );
        System.assert(!helper.emails.isEmpty());
        helper.send();
        Test.stopTest();
    }
}