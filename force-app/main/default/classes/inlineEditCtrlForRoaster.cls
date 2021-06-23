public class inlineEditCtrlForRoaster {
    
    @AuraEnabled
    public static list<SFDC_Class__c> getRelatedList(Id AccId)
    {
        List<SFDC_Class__c> Conlist = [Select id,(select id,Class_Name__r.Name,Class_Scheduled_Date__c,End_Date__c,End_Time__c,Start_Date__c,Name,Start_Time__c,Status__c,Module__r.Name from Roasters__r) from SFDC_Class__c where Id =: AccId ];
        return Conlist;
    }
    
 // method for fetch account records list  
    @AuraEnabled
    public static List < account > fetchAccount() {
        
        List < Account > returnList = new List < Account > ();
        List < Account > lstOfAccount = [select id, Name, Rating, website from account LIMIT 5];
        
        for (Account acc: lstOfAccount) {
            returnList.add(acc);
        }
        return returnList;
    }
    
  // method for update records after inline editing  
    @AuraEnabled
    public static List < account > saveAccount(List<Account> lstAccount) {
        update lstAccount;
        return lstAccount;
    }
    
  // method for fetch picklist values dynamic  
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
    @AuraEnabled
    public static List<Attendance__c> createAttendancefromViewRoster(Id recId){
        
        system.debug('recId '+recId);
        //Roaster__c roster_rec = [select id,Class_Name__c,Class_Name__r.id,Start_Time__c,End_Time__c,Class_Scheduled_Date__c,Status__c From Roaster__c where id=:recId];
        
        List<Roaster__c> roasterLists = [select id,Count_of_Make_up_Attendance__c,Total_Present__c,Total_Absent__c,Count_of_Enrollment__c,Count_Of_Regular_Attendance__c,Make_Up_Count__c,Total_Present_For_Regular__c,Total_Present_For_Make_Up__c,Total_Absent_For_Regular__c,Total_Absent_For_Make_Up__c,CNA_Status__c,Class_Name__r.Name,Class_Name__r.Start_Date__c,Class_Name__r.End_Date__c,Class_Name__r.Class_Status__c,Class_Name__r.Language__c,Class_Name__r.Students_Enrolled__c,Class_Scheduled_Date__c,End_Date__c,End_Time__c,Start_Date__c,Name,Start_Time__c,Status__c,Module__r.Name,Class_Name__c from Roaster__c where Id=:recId];
        system.debug('roasterLists '+roasterLists);
        system.debug('roasterLists '+roasterLists.size());
        
        SFDC_Class__c cls = [select id,name,Days__c,Class_Days__c,Start_Date__c,End_Date__c,Start_Time__c, End_Time__c From SFDC_Class__c where id=:roasterLists[0].Class_Name__r.id];
        system.debug('classes  '+cls);
        
        List<SFDC_Enrollment__c > enrollmentlist = [select id,name,Class__c, Class__r.id,Contact__c, Contact__r.Name, Contact__r.id, Status__c From SFDC_Enrollment__c where Class__r.id=:cls.Id and Status__c = 'Enrolled'];
        system.debug('enrollmentlist  '+enrollmentlist);
        system.debug('enrollmentlist '+enrollmentlist.size());
        
        List<Attendance__c > attendancelistExist = [select id,name,Class__c,Makeup_Class_status__c,Class__r.id,Contact__c,Contact__r.id,Date__c,Enrollment__c,Enrollment__r.id,Roaster__c,Roaster__r.id,Status__c From Attendance__c where Roaster__r.id=:recId];
        system.debug('attendancelistExist  '+attendancelistExist);
        system.debug('attendancelistExist  '+attendancelistExist.size());
        
        List<Attendance__c> attendancelist = new List<Attendance__c>();
        
        if(!roasterLists.isEmpty()){
            if(attendancelistExist.isEmpty()){
                for(SFDC_Enrollment__c en: enrollmentlist){
                    if(en.id <> null){
                        system.debug('show this ');
                        for(Roaster__c ros: roasterLists){
                            system.debug('roster Class_Scheduled_Date '+ros.Class_Scheduled_Date__c);
                            Attendance__c a = new Attendance__c();
                            a.Roaster__c = ros.id;
                            a.Date__c = ros.Class_Scheduled_Date__c;
                            system.debug('the id is'+en.Contact__r.id);
                            a.Contact__c = en.Contact__r.id;
                            a.Enrollment__c = en.id;
                            a.Class__c = cls.id;
                            a.Status__c = 'Scheduled';
                            a.Students_RSVP__c = 'Awaiting RSVP';
                            a.Class_Type__c = 'Regular';
                            a.Makeup_Class_status__c = 'Open';
                            attendancelist.add(a);
                        }  
                    }
                }  
            }
        }
        if(!attendancelist.isEmpty()){
            try{
                Database.saveResult [] srlist = Database.insert(attendancelist, false);
                for(Database.saveResult  sr: srlist){
                    if(sr.isSuccess()){
                        System.debug('Successfully inserted Attendance Ids : ' + sr.getId());
                    } else {
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.');                    
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Attendance fields that affected this error: ' + err.getFields());
                        }
                    }
                }
            }catch(Exception ex){
                throw new AuraHandledException(ex.getMessage());
            }
        }
        return attendancelist;

    }
    @AuraEnabled
    public static List<Roaster__c> checkRegularAttendance( string rosId){

        system.debug('  rosId  '+rosId);
        List<Roaster__c> roasterLists = [select id,Count_of_Make_up_Attendance__c,Total_Present__c,Total_Absent__c,Count_of_Enrollment__c,Count_Of_Regular_Attendance__c,Make_Up_Count__c,Total_Present_For_Regular__c,Total_Present_For_Make_Up__c,Total_Absent_For_Regular__c,Total_Absent_For_Make_Up__c,CNA_Status__c,Class_Name__r.Name,Class_Name__r.Start_Date__c,Class_Name__r.End_Date__c,Class_Name__r.Class_Status__c,Class_Name__r.Language__c,Class_Name__r.Students_Enrolled__c,Class_Scheduled_Date__c,End_Date__c,End_Time__c,Start_Date__c,Name,Start_Time__c,Status__c,Module__r.Name,Class_Name__c from Roaster__c where Id=:rosId];
        system.debug('roasterLists '+roasterLists);
        system.debug('roasterLists '+roasterLists.size());
        
        SFDC_Class__c cls = [select id,name,Days__c,Class_Days__c,Start_Date__c,End_Date__c,Start_Time__c, End_Time__c From SFDC_Class__c where id=:roasterLists[0].Class_Name__r.id];
        system.debug('classes  '+cls);
        
        List<Attendance__c > attendancelistExist = [select id,name,Class__c,Class_Type__c,Makeup_Class_status__c,Class__r.id,Contact__c,Contact__r.id,Date__c,Enrollment__c,Enrollment__r.id,Roaster__c,Roaster__r.id,Status__c From Attendance__c where Roaster__r.id=:rosId];
        system.debug('attendancelistExist  '+attendancelistExist);
        system.debug('attendancelistExist  '+attendancelistExist.size());
        
        return roasterLists;
    }
    @AuraEnabled
    public static string createMakeupAttendance( string rosId, string classId, string scheduledDate, string startTime, string endTime){
        List<Make_Up_Class__c> Makeup = new List<Make_Up_Class__c>();
        string MakeUpId = '';
        try{
        List<Make_Up_Class__c> mList = [select id, Name, Class__c, Roster_Name__c,Status__c from Make_Up_Class__c where Roster_Name__c=:rosId and Status__c='Open'];
        system.debug( ' mList ' + mList.size());
        if(mList.isEmpty()){
            string[] startClassTime = startTime.split(':');
            Time sTime = Time.newInstance(Integer.valueOf(startClassTime[0]) 
                                            ,Integer.valueOf(startClassTime[1]) 
                                            ,Integer.valueOf(startClassTime[2])                               
                                            ,0);  
            string[] endClassTime = endTime.split(':');
            Time eTime = Time.newInstance(Integer.valueOf(endClassTime[0]) 
                                            ,Integer.valueOf(endClassTime[1]) 
                                            ,Integer.valueOf(endClassTime[2])                               
                                            ,0);   
            Make_Up_Class__c m = new Make_Up_Class__c();
            m.Class__c = classId;
            m.Status__c = 'Open';
            m.Roster_Name__c = rosId;
            m.Class_Scheduled_Date__c = Date.valueOf(scheduledDate);
            m.Start_Time__c = sTime;
            m.End_Time__c = eTime;
            Makeup.add(m);
            Insert Makeup;

            MakeUpId = Makeup[0].Id;
            system.debug( 'MakeUpId  ' + MakeUpId);
        }else {
            
        }
    }
        catch(Exception ex){
        throw new AuraHandledException(ex.getMessage());
        }
        
        return MakeUpId;
    }  
}