public class Mark_Attendance {
    
    @AuraEnabled
    public static List<Attendance__c> fetchAttendance(string recId, string classDate){
        string attendId = recId;
        string sDate = classDate;
        system.debug('attendId '+attendId);
        system.debug('sDate '+sDate);
        
        List < Attendance__c > returnList = new List < Attendance__c >();
        
        string attendanceRecs = 'select id,Students_RSVP__c,createdDate,name, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c, Status__c from Attendance__c where Class__r.id=:attendId';
        system.debug('attendanceRecs '+attendanceRecs);
        
        if(string.isNotEmpty(classDate)){
            Date scheduleddate = Date.valueOf(classDate);
            attendanceRecs += ' AND Date__c=:scheduleddate';
        }
        List< Attendance__c > listofAttendances = Database.query(attendanceRecs);
        system.debug('After Schduled date passed listofAttendances '+listofAttendances);
        
        for(Attendance__c a: listofAttendances){
            returnList.add(a);
        }
        system.debug('returnList  '+returnList);
        system.debug('returnList size  '+returnList.size());
        return returnList;
    }
    
    @AuraEnabled
    public static List<string> getPickListValuesIntoList(string objectType, string selectedField){
        List<string> pickListValuesList = new List<string>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectType);
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(selectedField).getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }     
        return pickListValuesList;
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
    public static void updateRecords(String jsonString){
       /**  try{
            if(string.isNotEmpty(jsonString) || string.isNotBlank(jsonString)){
                system.debug('jsonString=='+jsonString);
                List<Attendance__c> records = (List<Attendance__c>) JSON.deserialize(jsonString, List<Attendance__c>.class);
                update records;
                system.debug('records '+records);
                List<Attendance__c> recordslist = [select id,Students_RSVP__c,Makeup_Class_status__c,createdDate,name, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c,Roaster__r.id, Status__c, Has_Make_Up_Class__c from Attendance__c where id=:records];
                system.debug('recordslist '+recordslist);
                system.debug('recordslist Id'+recordslist[0].id);
                
                for(Attendance__c a: recordslist){
                    if( a.Status__c == 'Present'){
                        a.Makeup_Class_status__c = 'Attended regular class';
                    }
                    if(a.Status__c == 'Absent'){
                        a.Makeup_Class_status__c = 'Need to attend make-up class';
                    }
                }
            }
        }catch(Exception e){
            system.debug('Following=='+e);
            system.debug('Line number ====> '+e.getLineNumber() + 'Exception Message =====> '+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }**/
        
        try{
            system.debug('jsonString=='+jsonString);
            List<Attendance__c> records = (List<Attendance__c>) JSON.deserialize(jsonString, List<Attendance__c>.class);
            update records;
        }catch(Exception e){
            system.debug('Following=='+e);
            system.debug('Line number ====> '+e.getLineNumber() + 'Exception Message =====> '+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}