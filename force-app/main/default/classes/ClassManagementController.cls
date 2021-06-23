public class ClassManagementController { 
    
    @AuraEnabled
    public static Boolean deleteConsumers(List<String> selectedIds, String classId) {
        
        System.debug('classId--'+classId);
        Boolean recordsDeleted = true;
        List<Consumer_Enrollment__c > enrollmentList = new List<Consumer_Enrollment__c >();
        enrollmentList= [SELECT Id FROM Consumer_Enrollment__c Where Id = :selectedIds];
        try{
            delete enrollmentList;
        }
        Catch(Exception ex){
            recordsDeleted  = false;
            throw new AuraHandledException(ex.getMessage());
        }
        return recordsDeleted;
    }
    
    @AuraEnabled
    public static List < SFDC_Enrollment__c > fetchEnrollmentDetails(String classId, String contactId ) {
        
        List<SFDC_Enrollment__c> enrollmentList = new List<SFDC_Enrollment__c>();
        enrollmentList= [SELECT Id,Enrollment__c,Consumer_Count__c, Name,CPR_Status__c,CPR_Valid_From__c, Consumer_Name__c, Consumer_Name__r.Name, Contact__c, Contact__r.Name, Contact__r.Affiliated_Consumer_Count__c, Class__r.Name, Status__c FROM SFDC_Enrollment__c Where Class__c = :classId AND Status__c != 'Student Requested for Removal' Order By Contact__r.Name, Consumer_Name__r.Name];
        return enrollmentList;
    }
    @AuraEnabled
    public static List < SFDC_Class__c > fetchClassDetails(String classId, String contactId) {
        System.debug('classId--'+classId);
        List<SFDC_Class__c> classList = new List<SFDC_Class__c>();
        SFDC_Class__c classRec = [Select RecordTypeId From SFDC_Class__c Where Id = :classId];
        //System.debug('classRec--'+classRec);
        
        classList= [SELECT Id,Name,RecordType.Name,Class_Status__c,Language__c,End_Date__c,Start_Date__c,Class_Course__r.Name FROM SFDC_Class__c where Class_Status__c='Upcoming' AND Id Not IN (Select Class__c From SFDC_Enrollment__c Where Contact__c = :contactId) AND RecordTypeId = :classRec.RecordTypeId];
        
        //System.debug('classList--'+classList);
        return classList;
    }
    @AuraEnabled
    public static List < Consumer_Enrollment__c > viewConsumers(String enrollmentId, String classId) {
        
        List<Consumer_Enrollment__c> viewconsumerList = new List<Consumer_Enrollment__c>();
        viewconsumerList= [SELECT Id,Enrollment__r.Class_Name__c, Enrollment__r.Provider_Name__c, Home_Care_Consumer__r.Name,Home_Care_Consumer__r.Age__c,Home_Care_Consumer__r.MediCal_ID__c,Enrollment__c FROM Consumer_Enrollment__c Where Enrollment__c = :enrollmentId AND Enrollment__r.Class__c = :classId];
        System.debug('ViewconsumerList--'+viewconsumerList);
        return viewconsumerList;
    }
    
    @AuraEnabled
    public static List < Contact > fetchContacts(String classId) {
        //String CountofQualified=[SELECT count(id) FROM SFDC_Enrollment__c where Status__c ='Qualified' And Contact__c ='0035g000003wsSOAAY']
        return [SELECT Id,Total_number_of_Enrolled__c,Current_Consumer_Count__c, Total_number_of_Qualified__c, Student_ID__c,Rolodex_ID__c,EdFund_Facility_Primary__r.Name, EdFund_Facility_Secondary__r.Name,CPR_Status__c,CPR_Valid_From__c, Name, Status__c,MailingPostalCode,MailingCity, Training_status__c,CCA_Provider_ID__c, Qualified__c FROM Contact Where Id Not IN(Select Contact__c From SFDC_Enrollment__c Where Class__c = :classId)];
        
    }
    @AuraEnabled
    public static List < Contact > fetchValues(String searchNameText, String searchCityText, String searchPostalCodeText, String searchEdFundPrimaryText, String searchEdFundSecondaryText, String searchStudentIDText, String searchRolodexIDText, String classId, string searchLimits) {
        
        String searchKey1 = searchNameText + '%';
        String searchKey2 = searchCityText + '%';
        String searchKey3 = searchPostalCodeText + '%';
        String searchKey6 = searchEdFundPrimaryText + '%';
        String searchKey7 = searchEdFundSecondaryText + '%';
        String searchKey4 = searchRolodexIDText + '%';
        String searchKey5 = searchStudentIDText + '%';
        
        List < Contact > returnList = new List < Contact > ();
        List < Contact > lstOfContact = new List<Contact>();
        String query = 'select id,EdFund_Facility_Primary__r.Name,EdFund_Facility_Secondary__r.Name,Student_ID__c,Rolodex_ID__c, Name,Status__c,CCA_Provider_ID__c,MailingCity, Training_status__c, Qualified__c,MailingPostalCode from Contact WHERE Id Not IN(Select Contact__c From SFDC_Enrollment__c Where Class__c = :classId)';
        if(searchNameText != null){
            query = query + ' AND Name LIKE: searchKey1';
        }
        if(searchCityText != null){
            query = query + ' AND MailingCity LIKE: searchKey2';
        }
        if(searchPostalCodeText != null){
            query = query + ' AND MailingPostalCode LIKE: searchKey3';
        }
        if(searchRolodexIDText != null){
            query = query + ' AND Rolodex_ID__c LIKE: searchKey4';
        }
        if(searchStudentIDText != null){
            query = query + ' AND Student_ID__c LIKE: searchKey5';
        } 
        if(searchEdFundPrimaryText != null){
            query = query + ' AND EdFund_Facility_Primary__r.Name LIKE: searchKey6';
        }
        if(searchEdFundSecondaryText != null){
            query = query + ' AND EdFund_Facility_Secondary__r.Name LIKE: searchKey7';
        }
        if(String.isNotBlank(searchLimits)){
            system.debug(' searchLimits ' + searchLimits);
            Integer limits = Integer.valueOf(searchLimits);
            query = query + '  Limit ' + limits;
        }
        System.debug('Query--'+query);
        //lstOfContact =  [select id,EdFund_Facility_Primary__c,EdFund_Facility_Secondary__c, Name,Status__c,CCA_Provider_ID__c,MailingCity, Training_status__c, Qualified__c,MailingPostalCode from Contact 
        //where (Name LIKE: searchKey1 AND MailingPostalCode LIKE: searchKey3 AND MailingCity LIKE :searchKey2) AND Training_status__c = 'Enrolled' AND Status__c = 'Student' AND Id Not IN(Select Contact__c From SFDC_Enrollment__c Where Class__c = :classId)];
        lstOfContact = Database.query(query);
        for (Contact Con: lstOfContact) {
            returnList.add(Con);
        }
        return returnList;
    }
    
    
    @AuraEnabled
    public static List < SFDC_Class__c > classValues(String searchNameText, String searchClassCourseText, String contactId) {
        
        String searchNameKey = searchNameText + '%';
        String searchCourseKey = searchClassCourseText + '%';
        
        List < SFDC_Class__c > returnList = new List < SFDC_Class__c > ();
        List < SFDC_Class__c > lstOfClass = new List<SFDC_Class__c>();
        String query = 'SELECT Id,Name,Class_Status__c,RecordType.Name,Language__c,End_Date__c,Start_Date__c,Class_Course__r.Name FROM SFDC_Class__c where Class_Status__c= \'Upcoming\' AND Id Not IN (Select Class__c From SFDC_Enrollment__c Where Contact__c = :contactId)';
        if(searchNameText != null){
            query = query + ' AND Name LIKE: searchNameKey';
        }
        if(searchClassCourseText != null){
            query = query + ' AND Class_Course__r.Name LIKE: searchCourseKey';
        }
        
        System.debug('Query--'+query);
        
        lstOfClass = Database.query(query);
        /*for (SFDC_Class__c class: lstOfClass) {
            returnList.add(class);
            }*/
        return lstOfClass ;
    }
    
    
    @AuraEnabled
    public static List < Provider_Consumer_Affiliation__c > fetchConsumers(String contactId, String enrollmentId, String classId) {
        return [SELECT Id,Is_Consumer_a_relative_of_Provider__c,Relationship__c, Home_Care_Consumer__c, Home_Care_Consumer__r.Name, Home_Care_Consumer__r.Age__c FROM Provider_Consumer_Affiliation__c Where Provider__c = :contactId AND Home_Care_Consumer__c Not IN(Select Home_Care_Consumer__c From Consumer_Enrollment__c Where Enrollment__c = :enrollmentId AND Enrollment__r.Class__c = :classId)];
    }
    
    @AuraEnabled
    public static Boolean updateStudentRemoval(String enrollmentId, String removeReason, String removeReasonCtgry ) {
        
        System.debug('enrollmentId--'+enrollmentId);
        Boolean recordUpdated = true;
        SFDC_Enrollment__c classMngmnt = [SELECT Id,Remove_Reason__c,Remove_Reason_Category__c,Removed_By__c,Removed_On__c, Status__c FROM SFDC_Enrollment__c Where Id = :enrollmentId];
        classMngmnt.Status__c = 'Student Requested for Removal';
        //classMngmnt.Remove_Reason__c =RemoveReasonId;
        classMngmnt.Id = enrollmentId;
        classMngmnt.Remove_Reason_Category__c = removeReasonCtgry;
        classMngmnt.Remove_Reason__c = removeReason;
        classMngmnt.Removed_By__c = UserInfo.getUserId();
       	classMngmnt.Removed_On__c = System.today();
        try{
            upsert classMngmnt;            
        }
        Catch(Exception ex){
            recordUpdated = false;
            throw new AuraHandledException(ex.getMessage());
        }
        return recordUpdated;
    }
    
    @AuraEnabled
    public static Boolean studentTransfer(String enrollmentId, String newClassId, String transferDesc, String transferReason, string contactId) {
        
        Boolean recordUpdated = true;
        //String newClassId = selectedIds[0];
        SFDC_Enrollment__c classMngmnt = [SELECT Id,Class_Name__c,Contact__r.Name, Status__c,Class__c,Class__r.Name FROM SFDC_Enrollment__c Where Id = :enrollmentId AND Status__c='Enrolled'];
        classMngmnt.Status__c = 'Student Requested for Transfer';
        classMngmnt.Transfer_To_Class__c = newClassId;
        classMngmnt.Transferred_From_Class__c =classMngmnt.Class__c;
        Class_Transfer_Approvel__c transfer = new Class_Transfer_Approvel__c();
        transfer.Enrollment__c = enrollmentId;
        transfer.Status__c = 'Pending Approval';
        transfer.Provider_Name__c=classMngmnt.Contact__r.Name;
        transfer.Transfer_By__c = UserInfo.getUserId();
        transfer.Transferred_On__c = System.today();
        transfer.Transfer_Description__c = transferDesc;
        transfer.Transfer_Reason_Category__c = transferReason;
        transfer.Transferred_From_Class__c = classMngmnt.Class__c;
        transfer.Transferred_To_Class__c = newClassId;
        try{
            update classMngmnt;
            System.debug('classMngmnt--'+classMngmnt);
            Insert transfer;
        }
        Catch(Exception ex){
            recordUpdated = false;
            throw new AuraHandledException(ex.getMessage());
        }
        return recordUpdated;
    }
    
    @AuraEnabled
    public static Boolean createEnrollments(List<String> selectedIds, String classId, String enrollType, String enrollmentId){ 
        
        Boolean recordsCreated = true;
        String tempString = '';
        List<SFDC_Enrollment__c> enrollmentList = new List<SFDC_Enrollment__c>();
        List<Consumer_Enrollment__c> consumerEnvList = new List<Consumer_Enrollment__c>();
		Map<Id, List<Provider_Consumer_Affiliation__c>> providerConsumerMap = new Map<Id, List<Provider_Consumer_Affiliation__c>>();
        List<Consumer_Enrollment__c> consumerEnrollmentList = new List<Consumer_Enrollment__c>();
        Map<ID, Contact> contactMap;
        if(enrollType == 'class'){
            contactMap = new Map<ID, Contact>([SELECT Id, CPR_Status__c, CPR_Valid_From__c FROM Contact WHERE Id IN:selectedIds]);
            for(Provider_Consumer_Affiliation__c ca :[SELECT Id, Provider__c, Home_Care_Consumer__c FROM Provider_Consumer_Affiliation__c Where Provider__c IN :selectedIds]){
                
                if(!providerConsumerMap.containsKey(ca.Provider__c)){
                    providerConsumerMap.put(ca.Provider__c, new List<Provider_Consumer_Affiliation__c>());
                }
                providerConsumerMap.get(ca.Provider__c).add(ca);
            }
        }
        for(Integer i = 0; i < selectedIds.size(); i++){
            
            SFDC_Enrollment__c enrollment = new SFDC_Enrollment__c();
            Consumer_Enrollment__c conumerEnt= New Consumer_Enrollment__c();
            if(enrollType == 'class'){
                
                enrollment.Contact__c = selectedIds[i];
                if(contactMap.containsKey(selectedIds[i])){
                    enrollment.CPR_Status__c = contactMap.get(selectedIds[i]).CPR_Status__c;
                    enrollment.CPR_Valid_From__c = contactMap.get(selectedIds[i]).CPR_Valid_From__c;
                    enrollment.Class__c = classId;
                    enrollment.Status__c = 'Enrolled';
                    enrollmentList.add(enrollment);
                }
            }
            else if(enrollType == 'consumer'){
                
                conumerEnt.Home_Care_Consumer__c = selectedIds[i];
                conumerEnt.Enrollment__c = enrollmentId;
                //conumerEnt.Class__c = classId;
                consumerEnrollmentList.add(conumerEnt);
            }
        }
             
        try{
            if(!enrollmentList.isEmpty()){
                
                Insert enrollmentList;
                for(SFDC_Enrollment__c enroll :enrollmentList){
                    
                    if(providerConsumerMap.containsKey(enroll.Contact__c)){
                        
                        for(Provider_Consumer_Affiliation__c ca:providerConsumerMap.get(enroll.Contact__c)){
                            
                            Consumer_Enrollment__c conumerEnt = new Consumer_Enrollment__c();
                            conumerEnt.Home_Care_Consumer__c = ca.Home_Care_Consumer__c;
                            conumerEnt.Enrollment__c = enroll.Id;
                            conumerEnt.Class__c = classId;
                            consumerEnvList.add(conumerEnt);
                        }
                    }
                }
                if(!consumerEnvList.isEmpty()){
                    Insert consumerEnvList;
                }
            }
            if(!consumerEnrollmentList.isEmpty()){
                Insert consumerEnrollmentList;
            }
        }
        Catch(Exception ex){
            recordsCreated = false;
            throw new AuraHandledException(ex.getMessage());
        }
        return recordsCreated;
    }
    
    @AuraEnabled 
    public static Map<String, String> getTransferPickListValues(){
        
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = SFDC_Enrollment__c.Transfer_Reason_Category__c.getDescribe();
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
}