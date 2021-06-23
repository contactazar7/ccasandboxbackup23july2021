public class Attendance_for_roster {
    
    public List<Attendance__c > attendancelist {get;set;}
    
    public Id recId {get;set;}
    public Attendance_for_roster(Apexpages.StandardController controller){
        recId = controller.getId();
        system.debug('recId =='+recId);
    }
    
    public PageReference createAttendance(){
        createAttendance(recId);
        pageReference pageRef = new PageReference('/'+recId);
        pageRef.setRedirect(true);
        return PageRef;
    } 
    
    public void createAttendance(Id recId){
        
        system.debug('recId '+recId);
        
        //Roaster__c roster_rec = [select id,Class_Name__c,Class_Name__r.id,Start_Time__c,End_Time__c,Class_Scheduled_Date__c,Status__c From Roaster__c where id=:recId];
        
        List<Roaster__c> roasterLists = [select id,Class_Name__c,Class_Name__r.id,Start_Time__c,End_Time__c,Class_Scheduled_Date__c,Status__c From Roaster__c where Id=:recId];
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
        
        attendancelist = new List<Attendance__c>();
        
        
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
                system.debug('Exception '+ ex);
            }
        }
    }
}