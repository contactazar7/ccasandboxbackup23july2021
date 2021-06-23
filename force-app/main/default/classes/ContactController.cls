public with sharing class ContactController
{
 //
    @AuraEnabled
    public static List<Contact> getUserName()
    {
        List<Contact> lst=([Select Id,Name,Email from Contact where Id =:'0035g000001dmTxAAI'
                           ]); 
        return lst;
    }
    @AuraEnabled
public static void updateRelatedList(List<Roaster__c> Conlist)
  
     {
           system.debug('ss'+Conlist);
          if(Conlist!= null && Conlist.size()>0)
          {
               system.debug('ss'+Conlist);
               update Conlist;
          }
         } 
     
    @AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) {
        // check if fileId id ''(Always blank in first chunk), then call the saveTheFile method,
        //  which is save the check data and return the attachemnt Id after insert, 
        //  next time (in else) we are call the appentTOFile() method
        //   for update the attachment with reamins chunks   
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
        
        return Id.valueOf(fileId);
    }
    
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId;
        
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName;
        oAttachment.ContentType = contentType;
        
        insert oAttachment;
        
        return oAttachment.Id;
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id =: fileId
        ];
        
        String existingBody = EncodingUtil.base64Encode(a.Body);
        
        a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
        
        update a;
    }
    
    @AuraEnabled
    public static list<SFDC_Class__c> getContactList(Id acid)
    {
        List<SFDC_Class__c> Conlist = [Select id,(select id,Class_Name__r.Name,Class_Scheduled_Date__c,Students_RSVP__c,Class_Names__c,End_Date__c,End_Time__c,Start_Date__c,Name,Start_Time__c,Status__c from Roasters__r) from SFDC_Class__c where Id =: acid ];
        return Conlist;
    }
    @AuraEnabled
    public static list<SFDC_Class__c> getProgramsList()
    {
        List<SFDC_Class__c> Conlist = [Select id,Name,Class_ID__c,Instructor_ID__c,Instructor_ID_2__c,Instructor_1__c,Class_Status__c,Start_Date__c,Start_Time__c,End_Date__c,End_Time__c from SFDC_Class__c ];
        return Conlist;
    }
     @AuraEnabled 
    public static Map<String, String> getIndustryFieldValue(){
        Map<String, String> options = new Map<String, String>();
        
        Schema.DescribeFieldResult fieldResult = Roaster__c.Students_RSVP__c.getDescribe();
        
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
       @AuraEnabled
    public static Roaster__c saveOpp(Roaster__c op) {
        system.debug('siva'+op);
        update op;
        return op;
    }
    
  // @AuraEnabled 
   // public static user fetchUser(){
     // query current user information  
     // User oUser = [select id,Name,TimeZoneSidKey,Username,Alias,Country,Email,FirstName,LastName,IsActive,IsPortalEnabled,SmallPhotoUrl, FullPhotoUrl,Phone 
           //      FROM User Where id =: userInfo.getUserId()];
       // return oUser;
   // }
}