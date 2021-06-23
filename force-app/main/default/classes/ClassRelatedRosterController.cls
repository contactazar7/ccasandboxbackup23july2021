public with sharing class ClassRelatedRosterController  
{
   /* @AuraEnabled
    public static list<SFDC_Class__c> getRelatedList1(Id AccId)
    {
        List<SFDC_Class__c> Conlist = [Select id,(select id,Class_Name__r.Name,Class_Name__r.Start_Date__c,Class_Name__r.End_Date__c,Class_Name__r.Class_Status__c,Class_Name__r.Language__c,Class_Scheduled_Date__c,End_Date__c,End_Time__c,Start_Date__c,Name,Start_Time__c,Status__c,Module__r.Name from Roasters__r) from SFDC_Class__c where Id =: AccId ];
        return Conlist;
    }*/
      @AuraEnabled
    public static list<Roaster__c> getRelatedList(Id AccId)
    {
        List<Roaster__c> Conlist = [select id,Count_of_Make_up_Attendance__c,Total_Present__c,Total_Absent__c,Count_of_Enrollment__c,Count_Of_Regular_Attendance__c,Make_Up_Count__c,Total_Present_For_Regular__c,Total_Present_For_Make_Up__c,Total_Absent_For_Regular__c,Total_Absent_For_Make_Up__c,CNA_Status__c,Class_Name__r.Name,Class_Name__r.Start_Date__c,Class_Name__r.End_Date__c,Class_Name__r.Class_Status__c,Class_Name__r.Language__c,Class_Name__r.Students_Enrolled__c,Class_Scheduled_Date__c,End_Date__c,End_Time__c,Start_Date__c,Name,Start_Time__c,Status__c,Module__r.Name,Class_Name__c from Roaster__c where Class_Name__c =: AccId ];
        return Conlist;
    }
    @AuraEnabled
    public static List < Roaster__c > saveRoaster(List<Roaster__c> lstRoaster) {
        system.debug('data'+lstRoaster);
        update lstRoaster;
                system.debug('data'+lstRoaster);

        return lstRoaster;
    }
    @AuraEnabled
    public static String getLexOriginUrl() {
        String prefix = URL.getSalesforceBaseURL().toExternalForm().replace('https://', '').split('\\.')[0];
        prefix = prefix.removeEnd('--c');
        return 'https://' + prefix.toLowerCase() + '.lightning.force.com';
    }
}