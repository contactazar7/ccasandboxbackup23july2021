public class Mark_Enrollment_CPR {
    
    @AuraEnabled
    public static List<SFDC_Enrollment__c> fetchEnrollmentCNA(string recId){
        system.debug('Roster recId '+ recId);
        
        List <SFDC_Enrollment__c> returnList = new List <SFDC_Enrollment__c>();
        
        set<Id> classId = new set<Id>();
        set<Id> enrol_ids = new set<Id>();
        
        for(Roaster__c r: [Select Id, Name, Class_Name__c, Class_Name__r.id  From Roaster__c where id=:recId]){
            classId.add(r.Class_Name__c);
        }
        
        for(Attendance__c ea: [select id,name,Class__c,Makeup_Class_status__c,Class__r.id,Contact__c,Contact__r.id,Date__c,Enrollment__c,Enrollment__r.id,Roaster__c,Roaster__r.id,Status__c From Attendance__c where Roaster__c=:recId]){
            enrol_ids.add(ea.Enrollment__c);
        }
        string enrolStatus = 'Enrolled';
        string EnrollmentRecs = 'select id,Name,Edfund_Facility__c,Provider_Name__c,Class__c,Class_Name__c,Status__c,Enrollment__c,Contact__c,Consumer_Name__c from SFDC_Enrollment__c where Class__c IN:classId and Status__c=:enrolStatus';
        
        List<SFDC_Enrollment__c> listofEnrollment = Database.query(EnrollmentRecs);
        system.debug('List of Enrollment records from the Class ID '+listofEnrollment);
        system.debug('listofEnrollment size ' + listofEnrollment.size());
        
        if(enrol_ids.isEmpty()){
            for(SFDC_Enrollment__c  a: listofEnrollment){
                returnList.add(a);
             }
        }else if(!enrol_ids.isEmpty()){
            for(SFDC_Enrollment__c  a: listofEnrollment){
                if(!enrol_ids.contains(a.id)){
                    returnList.add(a);
                 }
            }   
        }
        
        system.debug('returnList  '+returnList);
        system.debug('returnList size  '+returnList.size());
        return returnList;
    }
    
    
    @AuraEnabled
    public static List<SFDC_Enrollment__c> fetchEnrollment(string recId){
        system.debug('Class recId '+recId);
        
        List <SFDC_Enrollment__c> returnList = new List <SFDC_Enrollment__c>();
        string enrolStatus = 'Enrolled';
        string EnrollmentRecs = 'select id,Name,Provider_Name__c,Edfund_Facility__c,EdFundVendor_formula__c,Total_Hours_Classroom_Theory__c,Total_Hours_Clinical_Preceptor__c,CPR_Valid_Till__c,Days_to_Expire__c,CPR_Certificate_Uploaded__c,Class__c,Class_Name__c,Status__c,Enrollment__c,CPR_Status__c,CPR_Valid_From__c,Contact__c,Consumer_Name__c from SFDC_Enrollment__c where Class__c=:recId and Status__c=:enrolStatus';
        
        List<SFDC_Enrollment__c> listofEnrollment = Database.query(EnrollmentRecs);
        system.debug('List of Enrollment records from the Class ID '+listofEnrollment);
        
        for(SFDC_Enrollment__c  a: listofEnrollment){
            returnList.add(a);
        }
        system.debug('returnList  '+returnList);
        system.debug('returnList size  '+returnList.size());
        return returnList;
    }
    
    @AuraEnabled        
    public static Map<String,String> getPicklistValues(String objectAPIName, String fieldAPIName){
        Map<String,String> pickListValuesMap = new Map<String,String>();
        Map<String,String> pickListValuesMap2 = new Map<String,String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectAPIName);
        Schema.DescribeSObjectResult descResult = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = descResult.fields.getMap().get(fieldAPIName).getDescribe();
        Boolean isFieldNotRequired = fieldResult.isNillable();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            if(isFieldNotRequired)
                pickListValuesMap.put('--None--', '');
            if(pickListVal.isActive())
                pickListValuesMap.put(pickListVal.getLabel(), pickListVal.getValue());
        }
        return pickListValuesMap ;
    }
    
    @AuraEnabled
    public static List<Attendance__c> createCNAattendance(string jsonstring, string rosterId){
        system.debug('jsonstring '+jsonstring);
        system.debug('rosterId '+rosterId);
        List<Attendance__c> Inserted_Attd = new List<Attendance__c>();
        
        try{
            system.debug('jsonString=='+jsonString);
            List<SFDC_Enrollment__c> enr_reocrds = (List<SFDC_Enrollment__c>)JSON.deserialize(jsonString, List<SFDC_Enrollment__c>.class);
            system.debug('enr_reocrds '+enr_reocrds);
            
            List<Roaster__c> roasterLists = [select id,Class_Name__c,Class_Name__r.id,Start_Time__c,End_Time__c,Class_Scheduled_Date__c,Status__c From Roaster__c where Id=:rosterId];
            system.debug('roasterLists ' + roasterLists);
            
            for(SFDC_Enrollment__c en: [select id,Name,Provider_Name__c,CPR_Valid_Till__c,Days_to_Expire__c,CPR_Certificate_Uploaded__c,Class__c,Class_Name__c,Status__c,Enrollment__c,CPR_Status__c,CPR_Valid_From__c,Contact__c,Consumer_Name__c from SFDC_Enrollment__c where id=:enr_reocrds]){
                for(Roaster__c c: roasterLists){
                    Attendance__c a = new Attendance__c();
                    a.Roaster__c = c.Id;
                    a.Date__c = c.Class_Scheduled_Date__c;
                    a.Contact__c = en.Contact__c;
                    a.Enrollment__c = en.id;
                    a.Class__c = c.Class_Name__c;
                    a.Status__c = 'Present';
                    a.Students_RSVP__c = 'Awaiting RSVP';
                    a.Class_Type__c = 'Regular';
                    Inserted_Attd.add(a);
                } 
            }   
            
            Insert Inserted_Attd;
            system.debug('Inserted_Attd are '+Inserted_Attd);
            
        }catch(Exception e){
            system.debug('Following=='+e);
            system.debug('Line number ====> '+e.getLineNumber() + 'Exception Message =====> '+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
        
        return Inserted_Attd;
    }
    
    @AuraEnabled
    public static void updateRecords(String jsonString){
        try{
            if(string.isNotEmpty(jsonString) || string.isNotBlank(jsonString)){
                system.debug('jsonString=='+jsonString);
                List<SFDC_Enrollment__c> enr_reocrds = (List<SFDC_Enrollment__c>)JSON.deserialize(jsonString, List<SFDC_Enrollment__c>.class);
                update enr_reocrds;
                system.debug('enr_reocrds '+enr_reocrds);
                
                //This below cont_recsUpd update the Contact records CPR status from the Enrollments.
                List<Contact> cont_recsUpd = new List<Contact>();
                set<Id> ContactId = new set<Id>();
                
                for(SFDC_Enrollment__c en: [select id,Name,Provider_Name__c,CPR_Valid_Till__c,Days_to_Expire__c,CPR_Certificate_Uploaded__c,Class__c,Class_Name__c,Status__c,Enrollment__c,CPR_Status__c,CPR_Valid_From__c,Contact__c,Consumer_Name__c from SFDC_Enrollment__c where id=:enr_reocrds]){
                    ContactId.add(en.Contact__c);
                    for(contact c: [select Id, Name, FirstName, Lastname, CPR_Status__c, CPR_Valid_From__c From Contact Where id=:en.Contact__c]){
                        //  if(c.CPR_Status__c == null || c.CPR_Status__c == ''){
                        // system.debug('Provider Names are '+c.Name);  
                        c.CPR_Status__c = en.CPR_Status__c;
                        c.CPR_Valid_From__c = en.CPR_Valid_From__c;
                        cont_recsUpd.add(c);
                        //  }
                    }
                }
                update cont_recsUpd;
                system.debug('Updated Providers are '+cont_recsUpd);
                system.debug('Provider Ids are '+ContactId);
            }
        }catch(Exception e){
            system.debug('Following=='+e);
            system.debug('Line number ====> '+e.getLineNumber() + 'Exception Message =====> '+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}