public with sharing class MarkCompetencyController {

    @AuraEnabled
    public static list<SFDC_Class__c> getRelatedList1(Id recordId)
    {
        system.debug(recordId);
        
    list<SFDC_Class__c> clst1=[select id,Name,Start_Date__c,End_Date__c,Language__c,Class_Status__c,Students_Enrolled__c,competency_created__c,Competency_Dup_Check_2__c,Competency_Dup_Check__c ,(SELECT  Id, Name,Status__c FROM Enrollments__r),(SELECT Name, Id, Enrollment__c,Enrollment__r.Name,Enrollment__r.Contact__r.Name, Class_Name__c, Class__c,CDPH_Handwashing__c,IHSS_Dress_and_Undress__c,IHSS_Hand_Washing__c,IHSS_Body_Mechanics__c,IHSS_Care_of_Teeth__c,IHSS_AD_Medication_Safety__c,IHSS_AD_Help_to_Manage_Hallucination__c, IHSS_AD_Assisting_with_Sleep__c,IHSS_AD_Complete_Documentation_Form__c,IHSS_AD_Recognizing_AD__c,IHSS_AD_Repetitive_Qs_and_Behaviour__c,IHSS_AD_Oral_Care__c,IHSS_AD_Making_the_Home_Safe__c,CDPH_Responding_to_Dementia_Behaviour__c,CDPH_Home_Safety__c,CDPH_Medication_Safety__c,CDPH_Urgent_Care_vs_Emergency_Care__c,CDPH_Model_of_Care__c, IHSS_AD_Avoiding_Burnout__c FROM Competency_Checks__r),Is_it_a_CNA_Other_class__c,Class_Category__c from SFDC_Class__c where id=:recordId];
        return clst1;
        
    }
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {       
        List < String > allOpts = new list < String > ();
        Schema.sObjectType objType = objObject.getSObjectType();
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        MAP < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        List < Schema.PicklistEntry > values = fieldMap.get(fld).getDescribe().getPickListValues();
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        allOpts.sort();
        return allOpts;
    }
     @AuraEnabled
    //public static List <Service__c> saveservice(List<Service__c> lstService) 
    public static void saveservice(String lstService){
        system.debug('demo'+lstService);
        // Service__c ser = (Service__c) lstService;
        List<Competency_Check__c> serviceupdate = new List<Competency_Check__c>();
        // Service__c contactToEdit = (Service__c)JSON.deserialize(JSON.serialize(ser),Service__c.class);
        // serviceupdate.add(contactToEdit);
        // system.debug('demo2'+contactToEdit);
        JSONParser parser = JSON.createParser(lstService);
        while (parser.nextToken() != null) {
            // Start at the array of accounts.
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    // Advance to the start object marker to
                    //  find next account statement object.
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        // Read entire account object.
                        Competency_Check__c acc = (Competency_Check__c)parser.readValueAs(Competency_Check__c.class);
                        system.debug('Id:' + acc.Id + ' Name:' + acc.Name);
                        serviceupdate.add(acc);
                    }
                }
            }
        }
        update serviceupdate;
    }

}