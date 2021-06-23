trigger Competency_RecordCreation on SFDC_Class__c (After update) {

    if(Trigger.isAfter && Trigger.isUpdate)
    {
        
    map<id,Competency_Check__c> lstcmp= new map<id,Competency_Check__c>();
    list<SFDC_Class__c> clst=[select id,name,competency_created__c,Students_Enrolled__c,Competency_Dup_Check__c ,Competency_Dup_Check_2__c,(SELECT  Id, Name,Status__c FROM Enrollments__r),Is_it_a_CNA_Other_class__c,Class_Category__c from SFDC_Class__c where id IN : Trigger.new];
     if(checkRecursive.runOnce())
    {
      
    for(SFDC_Class__c cl:clst)
    {
        
         if(cl.competency_created__c==true)
        {
           
        for(SFDC_Enrollment__c en:cl.Enrollments__r)
        {
                 if(en.Status__c=='Enrolled')
                 {
                     Competency_Check__c cmpc=new Competency_Check__c();
                     if(cl.Class_Category__c == 'LA Care (IHSS+)'){
    cmpc.RecordTypeId= Schema.SObjectType.Competency_Check__c.getRecordTypeInfosByDeveloperName().get('IHSS_Category').getRecordTypeId();
                     }
                     if(cl.Class_Category__c == 'CDPH/UCSF'){
    
    cmpc.RecordTypeId = Schema.SObjectType.Competency_Check__c.getRecordTypeInfosByDeveloperName().get('CDPH_UCSF_Category').getRecordTypeId();
                     }
                     if(cl.Class_Category__c == 'IHSS+ A&D'){
    cmpc.RecordTypeId = Schema.SObjectType.Competency_Check__c.getRecordTypeInfosByDeveloperName().get('IHSS_AD_Category').getRecordTypeId();
                     }
                     cmpc.Enrollment__c=en.id;
                     cmpc.Class__c=cl.id;
                    
                         lstcmp.put(cmpc.Enrollment__c,cmpc); 
                 }
        }
      }    
            
    }
       
    if(lstcmp.size()>0)
    {
        upsert lstcmp.values();
    }
          
    } 
        
    }
}