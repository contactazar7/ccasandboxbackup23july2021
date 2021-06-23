public with sharing class Mark_Attendance_makeup {
    @AuraEnabled
    public static List<Attendance__c> fetchAttendance(string recId){
        string attendId = recId;
        system.debug('Roster ID '+attendId);
        string status = 'Scheduled';
        List < Attendance__c > returnList = new List < Attendance__c >();
        set<string> makeup_id = new set<string>();
        
        for(Make_Up_Class__c m: [select id, Roster_Name__c, Roster_Name__r.id, Class__c from Make_Up_Class__c where Roster_Name__r.id=:attendId]){
            makeup_id.add(m.id);
        }
        system.debug('makeup_id '+makeup_id);
        //string attendanceRecs = 'select id,Students_RSVP__c,Makeup_Class_status__c,createdDate,name, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c, Status__c, Make_Up_Class__c, Has_Make_Up_Class__c from Attendance__c where Make_Up_Class__r.id IN:makeup_id and Has_Make_Up_Class__c = true and Status__c =:status  ';
        string attendanceRecs = 'select id,Class_Type__c,Students_RSVP__c,Makeup_Class_status__c,createdDate,name, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c, Status__c, Make_Up_Class__c, Has_Make_Up_Class__c from Attendance__c where Make_Up_Class__r.id IN:makeup_id and Has_Make_Up_Class__c = true and Status__c =:status ';
        
        system.debug('attendanceRecs '+attendanceRecs);
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
    try{
        if(string.isNotEmpty(jsonString) || string.isNotBlank(jsonString)){
            system.debug('jsonString=='+jsonString);
            List<Attendance__c> records = (List<Attendance__c>) JSON.deserialize(jsonString, List<Attendance__c>.class);
            update records;
            system.debug('records '+records);
            List<Attendance__c> recordslist = [select id,Students_RSVP__c,Make_Up_Class__c,Class_Type__c,Makeup_Class_status__c,createdDate,name, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c,Roaster__r.id, Status__c, Has_Make_Up_Class__c from Attendance__c where id=:records];
            system.debug('recordslist '+recordslist);
            system.debug('recordslist Id'+recordslist[0].id);
            
            set<Id> makeUpId = new set<Id>();
            set<Id> rosterid = new set<Id>();
        
            for(Attendance__c a: recordslist){
            rosterid.add(a.Roaster__c);
            if(a.Class_Type__c == 'Make-up'){makeUpId.add(a.Make_Up_Class__c);}
            
                if( a.Status__c == 'Present'){
                    a.Makeup_Class_status__c = 'Attended make-up class';
                }
                if(a.Status__c == 'Absent'){
                    a.Makeup_Class_status__c = 'Need to attend make-up class';
                }
            
            
            }
            
            update recordslist; 
        system.debug('makeUp record Id is'+ makeUpId);
        
        List<Make_Up_Class__c> makeUpList = [select id, Roster_Name__c, Roster_Name__r.id, Class__c,Class_Scheduled_Date__c from Make_Up_Class__c where id IN:makeUpId];
        for(Make_Up_Class__c m : makeUpList){
            m.Status__c = 'Completed';
        }
        update makeUpList; 
        system.debug('Updated makeUp record Id is'+ makeUpList);
        
        List<Roaster__c> rosterlist= [select id,Class_Name__c,Make_Up_Count__c,Status__c,Count_of_Enrollment__c,Total_Present__c from Roaster__c where Id IN:rosterid];
        
        for(Roaster__c r: rosterlist){
            if(r.Count_of_Enrollment__c == r.Total_Present__c){
                r.Status__c = 'Completed';
            }else if(r.Count_of_Enrollment__c <> r.Total_Present__c){
                r.Status__c = 'Need to create Make-Up';
            }
        } 
        
        update rosterlist; 
        system.debug('rosterlist after'+rosterlist);
            
            
        }
    }catch(Exception e){
        system.debug('Following=='+e);
        system.debug('Line number ====> '+e.getLineNumber() + 'Exception Message =====> '+e.getMessage());
        throw new AuraHandledException(e.getMessage());
    }
}
    
    @AuraEnabled
    public static void updateMassRecords(String selectedMenu,List<Id> attIds){
        try{
            List<Attendance__c> recordslist = [select id,Students_RSVP__c,Makeup_Class_status__c,createdDate,name, Class_Type__c, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c,Roaster__r.id, Status__c,Make_Up_Class__c, Has_Make_Up_Class__c from Attendance__c where id=:attIds];
            set<Id> makeUpId = new set<Id>();
            set<Id> rosterid = new set<Id>();
            for(Attendance__c a: recordslist){
                rosterid.add(a.Roaster__c);
                if(a.Class_Type__c == 'Make-up'){makeUpId.add(a.Make_Up_Class__c);}
                if(selectedMenu == 'markaspresent'){
                    a.Status__c = 'Present';
                    a.Makeup_Class_status__c = 'Attended make-up class';
                }
                if(selectedMenu == 'markasabsent'){
                    a.Status__c = 'Absent';
                    a.Makeup_Class_status__c = 'Need to attend make-up class';
                }
            }
            update recordslist; 
            system.debug('makeUp record Id is'+ makeUpId);
            
            List<Make_Up_Class__c> makeUpList = [select id, Roster_Name__c, Roster_Name__r.id, Class__c,Class_Scheduled_Date__c from Make_Up_Class__c where id IN:makeUpId];
            for(Make_Up_Class__c m : makeUpList){
                m.Status__c = 'Completed';
            }
            update makeUpList; 
            system.debug('Updated makeUp record Id is'+ makeUpList);
            
            List<Roaster__c> rosterlist= [select id,Class_Name__c,Make_Up_Count__c,Status__c,Count_of_Enrollment__c,Total_Present__c from Roaster__c where Id IN:rosterid];
            
            for(Roaster__c r: rosterlist){
                if(r.Count_of_Enrollment__c == r.Total_Present__c){
                    r.Status__c = 'Completed';
                }else if(r.Count_of_Enrollment__c <> r.Total_Present__c){
                    r.Status__c = 'Need to create Make-Up';
                }
            } 
            
            update rosterlist; 
            system.debug('rosterlist after'+rosterlist);
            
        }catch(Exception e){
            system.debug('Following=='+e);
            system.debug('Line number ====> '+e.getLineNumber() + 'Exception Message =====> '+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}