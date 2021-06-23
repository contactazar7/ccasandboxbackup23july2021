public class EnrollmentTriggerHandler {

    EnrollmentTriggerHelper enrollmentHelper = new EnrollmentTriggerHelper();
    public void handleAfterInsert(List<SFDC_Enrollment__c> enrollmentList) {
        
        enrollmentHelper.updateEnrollmentCount(enrollmentList);
    }
    
    public void handleAfterUpdate(List<SFDC_Enrollment__c> enrollmentList, Map<Id, SFDC_Enrollment__c> enrollemntMap) {
        
        List<SFDC_Enrollment__c> enrollmentUpdateList = new List<SFDC_Enrollment__c>();
        for(SFDC_Enrollment__c enrollment :enrollmentList){
            
            if((enrollment.Status__c == 'Enrolled' && enrollemntMap.get(enrollment.Id).Status__c != 'Enrolled') || (enrollment.Status__c == 'Student Requested for Removal' && enrollemntMap.get(enrollment.Id).Status__c != 'Student Requested for Removal')  || (enrollment.Status__c == 'Qualified' && enrollemntMap.get(enrollment.Id).Status__c != 'Qualified')){
                enrollmentUpdateList.add(enrollment);
            }
        }
        enrollmentHelper.updateEnrollmentCount(enrollmentUpdateList);
    }
}