public class MassTransferProvider_Recs {
    @AuraEnabled
    public static List<ListView> getListViews(){
        List<ListView> listviews = [select id, Name from ListView where SobjectType = 'Contact' and Name='All Provider'];
        return listviews;
    }
    @AuraEnabled
    public static List <Contact> fetchValues(String searchName, String searchProviderID, String searchRolodexID, String searchStudentID, String searchCity, String searchPostalCode, string searchStatus, string searchLanguage,  string searchRecruiter, string searchDate, string searchrecruiterAssesment, string searchrecruitmentProgam,  string searchrecruitmentType, string recruiterW_WO, string recLimits) {
        system.debug(' searchrecruitmentType ' + searchrecruitmentType);
        system.debug(' recLimits ' + recLimits);
        system.debug( ' recruiterW_WO ' + recruiterW_WO);
        string sStatus = searchStatus;
        system.debug(' sStatus ' + sStatus);
        string sLanguage = searchLanguage;
        system.debug(' sLanguage ' + sLanguage);
        string sRecruiter = searchRecruiter;
        system.debug(' sRecruiter ' + sRecruiter);
        String pName = '%' +searchName + '%';
        String pProviderID = searchProviderID + '%';
        String pRolodexID = searchRolodexID + '%';
        String pStudentID = '%'+ searchStudentID + '%';
        String pCity = searchCity + '%';
        String pPostalCode = searchPostalCode + '%';
        List < Contact > returnList = new List < Contact > ();
        String query = 'select id,Assigned_Name__c,Recruitment_Program__c,Recruitment_Type__c,Recruiter_Assigned_Date__c,Recruitment_Assessment__c,Recruiter__c,Recruitment_Status__c,EdFund_Facility_Primary__r.Name,EdFund_Facility_Secondary__r.Name,Student_ID__c,Rolodex_ID__c, Name,CCA_Provider_ID__c,MailingCity,Qualified__c,MailingPostalCode from Contact where id != null  ';
        if(String.isNotBlank(sStatus)){
            query = query + ' AND Recruitment_Status__c=: sStatus';
        }
        if(String.isNotBlank(sLanguage)){
            query = query + ' AND Choice_of_Class_Language__c=: sLanguage';
        }
        if(String.isNotBlank(searchrecruitmentType)){
            query = query + ' AND Recruitment_Type__c=: searchrecruitmentType';
        }
        if(String.isNotBlank(searchrecruiterAssesment)){
            query = query + ' AND Recruitment_Assessment__c=: searchrecruiterAssesment';
        }
        if(String.isNotBlank(searchrecruitmentProgam)){
            query = query + ' AND Recruitment_Program__c=: searchrecruitmentProgam';
        }
        if(String.isNotBlank(searchName)){
            query = query + ' AND Name LIKE: pName ';
        }
        if(String.isNotBlank(searchStudentID)){
            query = query + ' AND Student_ID__c LIKE: pStudentID';
        } 
        if(String.isNotBlank(searchCity)){
            query = query + ' AND MailingCity LIKE: pCity';
        }
        if(String.isNotBlank(searchPostalCode)){
            query = query + ' AND MailingPostalCode LIKE: pPostalCode';
        }
        if(String.isNotBlank(sRecruiter)) {
        system.debug( ' sRecruiter ' + sRecruiter);
            query = query + ' AND Recruiter__c =:sRecruiter';
        }
        if(String.isNotBlank(searchDate)){
            Date sDate = Date.valueOf(searchDate);
            query = query + ' AND Recruiter_Assigned_Date__c =:sDate';
        }
        if(String.isNotBlank(recruiterW_WO)){
            if( recruiterW_WO == '1' ){
                query = query + ' AND ( Recruiter__c != null OR Recruiter__c = null ) ';
            }else if(recruiterW_WO == '2' ){
                query = query + ' AND  Recruiter__c != null ';
            }else if(recruiterW_WO == '3' ){
                query = query + ' AND  Recruiter__c = null  ';
            }  
        }
        if(String.isNotBlank(recLimits)){
            system.debug(' recLimits ' + recLimits);
            Integer limits = Integer.valueOf(recLimits);
            query = query + '  Limit ' + limits;
        }
        /** if(String.isNotBlank(searchProviderID)){
            query = query + ' AND CCA_Provider_ID__c LIKE: pProviderID';
        }
        if(String.isNotBlank(searchRolodexID)){
            query = query + ' AND Rolodex_ID__c LIKE: pRolodexID';
        }**/
        
        List < Contact > lstOfContact = Database.query(query);
        system.debug(' lstOfContact '+lstOfContact);
        
        for (Contact c: lstOfContact) {
            returnList.add(c);
        }         
        return returnList;
    }
    @AuraEnabled        
    public static List<String> getPickListValuesIntoList(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
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
    public static List<String> getLanguagePickListValuesIntoList(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
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
    public static List<String> getRecruitmentAssesment(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
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
    public static List<String> getRecruitmentProgram(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
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
    public static List<String> getRecruitmentType(String objectType, String selectedField){
        List<String> pickListValuesList = new List<String>();
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
    public static List<contact> assignedUser(Id userId, string providerIds){
        system.debug(' userId ' + userId);
        system.debug(' providerIds ' + providerIds);
        List<Contact > contactList = new List<Contact > ();
        set<Id> pId = new set<Id>();
        set<Id> pchcId = new set<Id>();
        set<Id> hcId = new set<Id>();
        List<Provider_Consumer_Affiliation__c> pc_affiliation = new List<Provider_Consumer_Affiliation__c>();
        //List<Home_Care_Seeker_Consumer__c> hcList = new List<Home_Care_Seeker_Consumer__c>();
		
        try{
            List<Contact> records = (List<Contact>)JSON.deserialize(providerIds, List<Contact>.class);
            contactList =  [select id,Assigned_Name__c,Recruiter_Assigned_Date__c,Recruiter__c,Recruitment_Status__c,EdFund_Facility_Primary__r.Name,EdFund_Facility_Secondary__r.Name,Student_ID__c,Rolodex_ID__c, Name,CCA_Provider_ID__c,MailingCity, Qualified__c,MailingPostalCode from Contact where id=:records];
            system.debug(' contactList ' + contactList);
            
            if(string.isNotBlank(userId)){
                for(contact c : contactList){
                    pId.add(c.Id);
                    c.Recruiter__c  = userId;
                    c.Recruiter_Assigned_Date__c = system.today();
                }
                for( Provider_Consumer_Affiliation__c p: [select Id,name,Home_Care_Consumer__c,Provider__c from Provider_Consumer_Affiliation__c where Provider__c IN:pId] ){
                    pchcId.add(p.Id);
                    system.debug( ' pchcId ' + pchcId );
                    hcId.add(p.Home_Care_Consumer__c);
                    system.debug( ' hcId ' +hcId);  
                }

                //hcList = [select id, name, Recruiter__c from Home_Care_Seeker_Consumer__c where id IN:hcId];
                //system.debug( ' hcList  ' +hcList );

                //for(Home_Care_Seeker_Consumer__c h: hcList ){
                  //  h.Recruiter__c  = userId;
               // }
            }
        }catch(Exception e){
            system.debug(' Exception e ' + e);
            system.debug(' Exception Message ' + e.getMessage());
            system.debug(' Exception Line Number ' + e.getMessage());
            system.debug(' Exception Cause ' + e.getCause());
        }
        update contactList;
        //update hcList;
        return contactList;
    }   
}