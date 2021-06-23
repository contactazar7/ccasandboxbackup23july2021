public class Mark_Attendance_ros {
    
    @AuraEnabled
    public static List<Attendance__c> fetchAttendance(string recId){
        string attendId = recId;
        system.debug('attendId '+attendId);
        List < Attendance__c > returnList = new List < Attendance__c >();
        string attendanceRecs = 'select id,Students_RSVP__c,CNA_Class_Type__c,CNA_Modules_Covered__c,CNA_Total_Time_in_Hours__c,Hours__c,Minutes__c,createdDate,name,Class_Name__c, Makeup_Class_status__c , Enrollment_No__c, Roaster_No__c, Contact_Name__c,Roaster__r.Ratio__c,Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c,Roaster__r.id, Status__c, Has_Make_Up_Class__c from Attendance__c where Roaster__r.id=:attendId and Has_Make_Up_Class__c = false ';
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
    public static Map<String,String> getPicklistValues(String objectAPIName, String fieldAPIName){
        Map<String,String> pickListValuesMap = new Map<String,String>();
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
        return pickListValuesMap;
    }
    
    @AuraEnabled        
    public static Map<String,String> getPicklistValues_hours(String objectAPIName, String fieldAPIName){
        Map<String,String> pickListValuesMap = new Map<String,String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectAPIName);
        Schema.DescribeSObjectResult descResult = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = descResult.fields.getMap().get(fieldAPIName).getDescribe();
        Boolean isFieldNotRequired = fieldResult.isNillable();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            if(isFieldNotRequired)
                //pickListValuesMap.put('--None--', '');
            if(pickListVal.isActive())
                pickListValuesMap.put(pickListVal.getLabel(), pickListVal.getValue());
        }
        return pickListValuesMap ;
    }
    
    @AuraEnabled        
    public static Map<String,String> getPicklistValues_mins(String objectAPIName, String fieldAPIName){
        Map<String,String> pickListValuesMap = new Map<String,String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectAPIName);
        Schema.DescribeSObjectResult descResult = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = descResult.fields.getMap().get(fieldAPIName).getDescribe();
        Boolean isFieldNotRequired = fieldResult.isNillable();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for(Schema.PicklistEntry pickListVal : ple){
            if(isFieldNotRequired)
                //pickListValuesMap.put('--None--', '');
            if(pickListVal.isActive())
                pickListValuesMap.put(pickListVal.getLabel(), pickListVal.getValue());
        }
        return pickListValuesMap ;
    }
    
     @AuraEnabled        
    public static Map<String,String> getPicklistValues_multiselect(String objectAPIName, String fieldAPIName){
        Map<String,String> pickListValuesMap = new Map<String,String>();
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
    public static Map<String,String> getPicklistValues_CNAType(String objectAPIName, String fieldAPIName){
        Map<String,String> pickListValuesMap = new Map<String,String>();
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
        return pickListValuesMap;
    }
    
    @AuraEnabled
    public static List <String> getPiklistValues() {
        List<String> plValues = new List<String>();
         
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Attendance__c');
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get('CNA_Modules_Covered__c').getDescribe();
        List<Schema.PicklistEntry> picklistvalues = objFieldInfo.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues) {
            if(plv.isActive()){plValues.add(plv.getValue());}
        }
        plValues.sort();
        return plValues;
    }
    
    @AuraEnabled
    public static List <String> getPiklistValuesMods() {
        List<String> plValues = new List<String>();
        Schema.SObjectType objType = Schema.getGlobalDescribe().get('Attendance__c');
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        Schema.DescribeFieldResult objFieldInfo = objDescribe.fields.getMap().get('Modules__c').getDescribe();
        List<Schema.PicklistEntry> picklistvalues = objFieldInfo.getPicklistValues();
        for(Schema.PicklistEntry plv: picklistvalues) {
            if(plv.isActive()){plValues.add(plv.getValue());}
        }
        plValues.sort();
        return plValues;
    }
    
    @AuraEnabled
    public static void updateRecords(String jsonString){
        try{
            if(string.isNotEmpty(jsonString) || string.isNotBlank(jsonString)){
                set<Id> rosterid = new set<Id>();
                system.debug('jsonString=='+jsonString);
                List<Attendance__c> records = (List<Attendance__c>) JSON.deserialize(jsonString, List<Attendance__c>.class);
                update records;
                system.debug('records '+records);
                List<Attendance__c> recordslist = [select id,Students_RSVP__c,CNA_Modules_Covered__c,CNA_Total_Time_in_Hours__c,Hours__c,Minutes__c,Makeup_Class_status__c,createdDate,name, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c,Roaster__r.id, Status__c, Has_Make_Up_Class__c from Attendance__c where id=:records];
                system.debug('recordslist '+recordslist);
                system.debug('recordslist Id'+recordslist[0].id);
                for(Attendance__c a: recordslist){
                    rosterid.add(a.Roaster__c);
                    if( a.Status__c == 'Present'){
                        a.Makeup_Class_status__c = 'Attended regular class';
                    }
                    if(a.Status__c == 'Absent'){
                        a.Makeup_Class_status__c = 'Need to attend make-up class';
                    }
                }
                update recordslist; 
                List<Roaster__c> rosterlist= [select id,CNA_Status__c,Total_Present_For_Regular__c,Total_Absent_For_Regular__c,Count_Of_Regular_Attendance__c,Class_Name__c,Make_Up_Count__c,Status__c,Count_of_Enrollment__c,Total_Present__c from Roaster__c where Id IN:rosterid];
                for(Roaster__c r: rosterlist){
                    if(r.Count_of_Enrollment__c == r.Total_Present__c){
                        r.Status__c = 'Completed';
                        r.CNA_Status__c = 'Closed';
                    }else if(r.Total_Present_For_Regular__c + r.Total_Absent_For_Regular__c  <> r.Count_Of_Regular_Attendance__c){
                    //else if(r.Count_of_Enrollment__c <> r.Total_Present__c){
                        system.debug(' Open ');
                        r.Status__c = 'Open';
                    }else if(r.Total_Present_For_Regular__c + r.Total_Absent_For_Regular__c  == r.Count_Of_Regular_Attendance__c){
                    //else if(r.Count_of_Enrollment__c <> r.Total_Present__c){
                        system.debug(' Need to Create Make Up ');
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
            set<Id> rosterid = new set<Id>();
            List<Attendance__c> recordslist = [select id,Students_RSVP__c,CNA_Modules_Covered__c,CNA_Total_Time_in_Hours__c,Hours__c,Minutes__c,Makeup_Class_status__c,createdDate,name, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c,Roaster__r.id, Status__c, Has_Make_Up_Class__c from Attendance__c where id=:attIds];
            for(Attendance__c a: recordslist){
                rosterid.add(a.Roaster__c);
                if(selectedMenu == 'markaspresent'){
                    a.Status__c = 'Present';
                    a.Makeup_Class_status__c = 'Attended regular class';
                }
                if(selectedMenu == 'markasabsent'){
                    a.Status__c = 'Absent';
                    a.Makeup_Class_status__c = 'Need to attend make-up class';
                }
            }
            update recordslist; 
            List<Roaster__c> rosterlist= [select id,CNA_Status__c,Total_Present_For_Regular__c,Total_Absent_For_Regular__c,Count_Of_Regular_Attendance__c,Class_Name__c,Make_Up_Count__c,Status__c,Count_of_Enrollment__c,Total_Present__c from Roaster__c where Id IN:rosterid];
            for(Roaster__c r: rosterlist){
                if(r.Count_of_Enrollment__c == r.Total_Present__c){
                        r.Status__c = 'Completed';
                        r.CNA_Status__c = 'Closed';
                    }else if(r.Total_Present_For_Regular__c + r.Total_Absent_For_Regular__c  <> r.Count_Of_Regular_Attendance__c){
                    //else if(r.Count_of_Enrollment__c <> r.Total_Present__c){
                        system.debug(' Open ');
                        r.Status__c = 'Open';
                    }else if(r.Total_Present_For_Regular__c + r.Total_Absent_For_Regular__c  == r.Count_Of_Regular_Attendance__c){
                    //else if(r.Count_of_Enrollment__c <> r.Total_Present__c){
                        system.debug(' Need to Create Make Up ');
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
    
     @AuraEnabled
    public static void updateModulesRecs(List<String> selectedValues ,List<Id> attIds){
        try{
            set<Id> rosterid = new set<Id>();
            system.debug(' selectedValues ' + selectedValues);
            system.debug(' attIds ' + attIds);
            List<Attendance__c> recordslist = [select id,Students_RSVP__c,Modules__c,CNA_Modules_Covered__c,CNA_Total_Time_in_Hours__c,Hours__c,Minutes__c,Makeup_Class_status__c,createdDate,name, Class_Name__c, Enrollment_No__c, Roaster_No__c, Contact_Name__c, Class__c,Class__r.id,Class__r.Name, Contact__c, Contact__r.id, Contact__r.Name,Date__c, Enrollment__c, Roaster__c,Roaster__r.id, Status__c, Has_Make_Up_Class__c from Attendance__c where id=:attIds];
            system.debug(' recordslist after '+ recordslist);
            for(Attendance__c a: recordslist){
                rosterid.add(a.Roaster__c);
                if(string.isBlank(a.CNA_Modules_Covered__c))
                {a.CNA_Modules_Covered__c = '';}
                for(string s: selectedValues){
                    system.debug(' Module values as string ' + s);
                    a.CNA_Modules_Covered__c += s+';';
                } 
            }
            system.debug(' recordslist before DML  '+ recordslist);
            update recordslist; 
            //List<Roaster__c> rosterlist= [select id,CNA_Status__c,Is_it_a_CNA_CPR_class__c,Class_Name__c,Make_Up_Count__c,Status__c,Count_of_Enrollment__c,Total_Present__c from Roaster__c where Id IN:rosterid];
            //for(Roaster__c r: rosterlist){
               
            //} 
          	//update rosterlist; 
            //system.debug('rosterlist after'+rosterlist);
            
        }catch(Exception e){
            system.debug('Following=='+e);
            system.debug('Line number ====> '+e.getLineNumber() + 'Exception Message =====> '+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}