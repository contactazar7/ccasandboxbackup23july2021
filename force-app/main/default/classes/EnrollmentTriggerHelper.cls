public class EnrollmentTriggerHelper {
    
    public void updateEnrollmentCount(List<SFDC_Enrollment__c> enrollmentList) {
        
        Set<Id> providerIdSet = new Set<Id>();
        List<SFDC_Enrollment__c> allEnrollmentList = new List<SFDC_Enrollment__c>();
        for(SFDC_Enrollment__c enrollment :enrollmentList){
            
            if(enrollment.Contact__c != null){
                providerIdSet.add(enrollment.Contact__c);
            }
        }
        if(!providerIdSet.isEmpty()){
            
            Map<Id, Integer> enrolledCountMap = new Map<Id, Integer>();
            Map<Id, Integer> qualifiedCountMap = new Map<Id, Integer>();
            Map<Id, Integer> consumerCountMap = new Map<Id, Integer>();
            allEnrollmentList = [Select Id, Contact__c, Status__c From SFDC_Enrollment__c Where Contact__c IN :providerIdSet];
            for(SFDC_Enrollment__c enrollmentRec :allEnrollmentList){
                
                if(enrollmentRec.Status__c == 'Enrolled' || enrollmentRec.Status__c == 'Student Requested for Removal'){
                    if(!enrolledCountMap.containsKey(enrollmentRec.Contact__c)){
                        enrolledCountMap.put(enrollmentRec.Contact__c, 0);
                    }
                    enrolledCountMap.put(enrollmentRec.Contact__c, enrolledCountMap.get(enrollmentRec.Contact__c) + 1);
                }
                else if(enrollmentRec.Status__c == 'Qualified'){
                    if(!qualifiedCountMap.containsKey(enrollmentRec.Contact__c)){
                        qualifiedCountMap.put(enrollmentRec.Contact__c, 0);
                    }
                    qualifiedCountMap.put(enrollmentRec.Contact__c, qualifiedCountMap.get(enrollmentRec.Contact__c) + 1);
                }
            }
            
            List<Contact> updateContactList = new List<Contact>();
            for(Id providerId :providerIdSet){
                
                Contact con = new Contact();
                con.Id = providerId;
                con.Total_number_of_Enrolled__c = enrolledCountMap.containsKey(providerId)?String.valueOf(enrolledCountMap.get(providerId)):'0';
                con.Total_number_of_Qualified__c = qualifiedCountMap.containsKey(providerId)?String.valueOf(qualifiedCountMap.get(providerId)):'0';
                updateContactList.add(con);
            }
            if(!updateContactList.isEmpty()){
                update updateContactList;
            }
        }
    }
}