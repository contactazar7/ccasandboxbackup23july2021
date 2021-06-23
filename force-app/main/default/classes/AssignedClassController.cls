public class AssignedClassController {
    
    @AuraEnabled
    public static List < SFDC_Enrollment__c > fetchEnrollmentDetails(String contactId) {
        // System.debug('classId--'+classId);
        List<SFDC_Enrollment__c> enrollmentList = new List<SFDC_Enrollment__c>();
        enrollmentList= [SELECT Id,Name,Class__c, Class__r.Class_Course__r.Name, Class__r.Start_Date__c,Class__r.End_Date__c,Contact__c, Class__r.Name, Class__r.Class_Status__c , Status__c FROM SFDC_Enrollment__c Where Contact__c = :contactId ];
        return enrollmentList;
    }
    
    @AuraEnabled
    public static List < SFDC_Class__c > fetchClassDetails(String contactId) {
        
        List<SFDC_Class__c> trasferClassList = new List<SFDC_Class__c>();
        trasferClassList= [SELECT Id,Name,Class_Schedule__c,Class_Category__c,Class_Status__c,Language__c,End_Date__c,Start_Date__c,Class_Course__r.Name FROM SFDC_Class__c where Class_Status__c='Upcoming' AND Id Not IN (Select Class__c From SFDC_Enrollment__c Where Contact__c = :contactId)];
        return trasferClassList;
    }
    
    @AuraEnabled
    public static List < Contact > fetchContacts(String classId) {
        
        return [SELECT Id,Student_ID__c,Rolodex_ID__c,EdFund_Facility_Primary__r.Name, EdFund_Facility_Secondary__r.Name,CPR_Status__c,CPR_Valid_From__c, Name, Status__c,MailingPostalCode,MailingCity, Training_status__c,CCA_Provider_ID__c, Qualified__c FROM Contact Where Contact.Count_of_Affiliated_Consumer__c > 0 AND  Id Not IN(Select Contact__c From SFDC_Enrollment__c Where Class__c = :classId)];
        
    }
    
    @AuraEnabled
    public static Boolean studentTransfer(String enrollmentId, String newClassId) {
        
        Boolean recordUpdated = true;
        //String newClassId = selectedIds[0];
        SFDC_Enrollment__c classMngmnt = [SELECT Id, Status__c FROM SFDC_Enrollment__c Where Id = :enrollmentId];
        classMngmnt.Status__c = 'Student Requested for Transfer';
        classMngmnt.Transfer_To_Class__c = newClassId;
        Class_Transfer_Approvel__c transfer = new Class_Transfer_Approvel__c();
        transfer.Enrollment__c = enrollmentId;
        transfer.Status__c = 'Pending Approval';
        try{
            update classMngmnt;
            Insert transfer;
        }
        Catch(Exception ex){
            recordUpdated = false;
            throw new AuraHandledException(ex.getMessage());
        }
        return recordUpdated;
    }
    
    
    @AuraEnabled
    public static Boolean createEnrollments(String classId,String contactId){ 
        
        Boolean recordsCreated = true;
        String tempString = '';
        List<SFDC_Enrollment__c> enrollmentList = new List<SFDC_Enrollment__c>(); 
        List<Provider_Consumer_Affiliation__c> ConsumerList = new List <Provider_Consumer_Affiliation__c>();
        ConsumerList = [SELECT Id,Home_Care_Consumer__c FROM Provider_Consumer_Affiliation__c Where Provider__c = :contactId];
        List<Consumer_Enrollment__c> consumerEnvList = new List<Consumer_Enrollment__c>();
        SFDC_Enrollment__c enrollment = new SFDC_Enrollment__c();           
        enrollment.Class__c = classId;
        enrollment.Contact__c = contactId;
        enrollment.Status__c = 'Enrolled';
        enrollmentList.add(enrollment);
        
        if(!enrollmentList.isEmpty()){
            try{
                Insert enrollmentList;
                for(Provider_Consumer_Affiliation__c ce :ConsumerList){
                    
                    Consumer_Enrollment__c conumerEnt= New Consumer_Enrollment__c();
                    conumerEnt.Home_Care_Consumer__c = ce.Home_Care_Consumer__c;
                    conumerEnt.Enrollment__c = enrollmentList[0].Id;
                    conumerEnt.Class__c = classId;
                    consumerEnvList.add(conumerEnt);
                }
                if(!consumerEnvList.isEmpty()){
                    Insert consumerEnvList;
                }
            }
            Catch(Exception ex){
                recordsCreated = false;
                throw new AuraHandledException(ex.getMessage());
            }
        }
        return recordsCreated;
    }
        
        @AuraEnabled
        public static List < SFDC_Class__c > classValues(String searchClassNameText, String searchClassCourseText, String searchClassCategoryText, String searchClassPreferredDayText, String searchLanguageText, String ClassRecLimits, String contactId) {
            
            String searchClassNameKey = searchClassNameText + '%';
            String searchCourseKey = searchClassCourseText + '%';
            String searchClassCategoryKey = searchClassCategoryText + '%';
            String searchClassPreferredDayKey = searchClassPreferredDayText + '%';
            String searchLanguageKey = searchLanguageText + '%';
          
            //List < SFDC_Class__c > returnList = new List < SFDC_Class__c > ();
            List < SFDC_Class__c > lstOfClass = new List<SFDC_Class__c>();
            String query = 'SELECT Id,Name,Class_Status__c,Class_Schedule__c,Class_Category__c,RecordType.Name,Language__c,End_Date__c,Start_Date__c,Class_Course__r.Name FROM SFDC_Class__c where Id Not IN (Select Class__c From SFDC_Enrollment__c Where Contact__c = :contactId) AND Class_Status__c= \'Upcoming\'';
           
            if(searchClassNameText != null){
                query = query + ' AND Name LIKE: searchClassNameKey';
            }
            if(searchClassCourseText != null){
                query = query + ' AND Class_Course__r.Name LIKE: searchCourseKey';
            }
            if(searchClassCategoryText != null){
                query = query + ' AND Class_Category__c LIKE: searchClassCategoryKey';
            }
            if(searchClassPreferredDayText != null){
                query = query + ' AND Class_Schedule__c LIKE: searchClassPreferredDayKey';
            }
            if(searchLanguageText != null){
                query = query + ' AND Language__c LIKE: searchLanguageKey';
            }
            
            if(String.isNotBlank(ClassRecLimits)){
            //system.debug(' ClassRecLimits ' + ClassRecLimits);
            Integer limits = Integer.valueOf(ClassRecLimits);
            query = query + '  Limit ' + limits;
        }
            
            System.debug('Query--'+query);
            
            lstOfClass = Database.query(query);
            /*for (SFDC_Class__c class: lstOfClass) {
                      returnList.add(class);
            }*/
            return lstOfClass ;
        }
   
}