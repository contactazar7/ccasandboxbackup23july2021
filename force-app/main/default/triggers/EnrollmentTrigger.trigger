trigger EnrollmentTrigger on SFDC_Enrollment__c (after insert, after update, after delete, after undelete) {
    //Set<Id> enid=new Set<Id>();
    //Set<Id> clnid=new Set<Id>();
    //List<Contact> classToUpdate=new List<Contact>();
    //List<SFDC_Class__c> classTo=new List<SFDC_Class__c>();
    EnrollmentTriggerHandler enrollmentHandler = new EnrollmentTriggerHandler();
    
   /* if(Trigger.isInsert||trigger.isUpdate ){
        System.debug('the update');
        for(SFDC_Enrollment__c huf : Trigger.new){
            System.debug('the update');
            if(huf.contact__c != null && huf.Pass_DNP__c=='pass'){
                enid.add(huf.contact__c); }
            //if(huf.Status__c=='Student Requested Removal'||huf.status__c=='Student Requested Transfer') {
            clnid.add(huf.Class__c);
            // }     
        }*/
        if(Trigger.isInsert && Trigger.isAfter){
            enrollmentHandler.handleAfterInsert(Trigger.new);
        }
        if(Trigger.isUpdate && Trigger.isAfter){
            enrollmentHandler.handleAfterUpdate(Trigger.new, Trigger.oldMap);
        }
    //}
    
    /*if(Trigger.isInsert){
        
        List<SFDC_Class__c> classTo1=new List<SFDC_Class__c>();
        Set<Id> clnid1=new Set<Id>();
        System.debug('the update');
        for(SFDC_Enrollment__c huf : Trigger.new){
            System.debug('the update');
            clnid1.add(huf.Class__c);
            
        }
        list<SFDC_Enrollment__c>plist1=new list<SFDC_Enrollment__c>([select id,name,Status__c,class__c from SFDC_Enrollment__c where class__c IN:clnid and Status__c='Enrolled']);
        system.debug('the size()'+plist1.size());
        for(SFDC_Class__c cc1:[select id,name from SFDC_Class__c where id IN:clnid1]){
            cc1.Count_of_Enrollment_Status_Enrolled__c=plist1.size();
            classTo1.add(cc1);
        }
        if(classTo1.size()>0){
            update classTo1;
        }
    }
    
    if(Trigger.isdelete){
        
        System.debug('the update');
        for(SFDC_Enrollment__c huf : Trigger.old){
            System.debug('the update');
            if(huf.contact__c != null && huf.Pass_DNP__c=='pass'){
                enid.add(huf.contact__c); }
            //if(huf.Status__c=='Student Requested Removal'||huf.status__c=='Student Requested Transfer') {
            clnid.add(huf.Class__c);
            // }     
        }*/
        
        if(trigger.isDelete && Trigger.isAfter){
            enrollmentHandler.handleAfterInsert(trigger.old);
        }
    //}
   /* system.debug(clnid);
    list<SFDC_Enrollment__c>plist=new list<SFDC_Enrollment__c>([select id,name,Status__c,class__c from SFDC_Enrollment__c where class__c IN:clnid and (Status__c='Student Requested Removal' OR status__c='Student Requested Transfer')]);
    System.debug('the update'+enid);
    for(contact cn:[select id,name,Status__c,Training_status__c from contact where id IN:enid]){
        System.debug('the update'+enid);
        cn.Status__c='Qualified As Provider';
        cn.Training_status__c='Qualified'; 
        classToUpdate.add(cn);
        System.debug('the update'+classToUpdate); 
    }
    if(classToUpdate.size()>0){
        System.debug('demo');
        upsert classToUpdate;
    }
    system.debug('the size is'+plist.size());
    if(plist.size()>0){
        for(SFDC_Class__c sc:[select id,name from SFDC_Class__c where id IN:clnid]){
            sc.Count_of_Enrollment_Result_Dropped__c=plist.size();
            classTo.add(sc);
        }
    }
    update classTo;*/
}