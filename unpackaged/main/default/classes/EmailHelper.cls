public class EmailHelper {
    
    private static Map<String, EmailTemplate> templateMap = new Map<String, EmailTemplate>();
    @TestVisible
    private List<Messaging.SingleEmailMessage> emails;
    private OrgWideEmailAddress orgWideAddress;
    
    public EmailHelper() {
        emails = new List<Messaging.SingleEmailMessage>();
        List<OrgWideEmailAddress> addresses = [
            select Id from OrgWideEmailAddress
            where Address = 'service@thebullbag.com'
        ];
        if (!addresses.isEmpty()) orgWideAddress = addresses.get(0);
    }
    
    public Messaging.SingleEmailMessage addEmailToQueue(List<String> toAddresses, List<String> ccAddresses, String emailTemplate, Id targetObjectId, Id whatId) {
        EmailTemplate template = getTemplate(emailTemplate);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        if (String.isNotBlank(targetObjectId)) {
            mail.setTemplateId(template.Id);
            mail.setTargetObjectId(targetObjectId);
        } else {
            Messaging.SingleEmailMessage singleEmail = Messaging.renderStoredEmailTemplate(template.Id, null, whatId);
            if(String.isNotBlank(singleEmail.getHTMLBody())) mail.setHTMLBody(singleEmail.getHTMLBody());
            if(String.isNotBlank(singleEmail.getPlainTextBody())) mail.setPlainTextBody(singleEmail.getPlainTextBody());
            if(String.isNotBlank(singleEmail.getSubject())) mail.setSubject(singleEmail.getSubject());
        }
        mail.setWhatId(whatId);
        mail.setSaveAsActivity(false);
        if(orgWideAddress != null) mail.setOrgWideEmailAddressId(orgWideAddress.Id);
        mail.setToAddresses(toAddresses);
        if (ccAddresses != null && !ccAddresses.isEmpty()) { 
            mail.setCCAddresses(ccAddresses);
        }
        emails.add(mail);
        return mail;
    }
    
    public void send() {
        if (!emails.isEmpty() && !Test.isRunningTest()) {
            Messaging.sendEmail(emails);
            emails.clear();
        }
    }

    public static EmailTemplate getTemplate(String template) {
        if (templateMap.get(template) == null) {
            templateMap.put(template, new EmailTemplate());
            for (EmailTemplate et : [select Id from EmailTemplate where DeveloperName = :template]) {
                templateMap.put(template, et);
            }
        }
        return templateMap.get(template);
    }
}