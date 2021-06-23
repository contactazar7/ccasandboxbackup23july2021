public class ClassTransferApprovaTriggerlHandler {
    
    public static void beforeTriggerHandler(Map<Id, Class_Transfer_Approvel__c> transferApprovalMap, List<Class_Transfer_Approvel__c> transferApprovalList){
        
        for(Class_Transfer_Approvel__c cta : transferApprovalList){
            
            if(cta.Status__c == 'Approved' && transferApprovalMap.get(cta.Id).Status__c == 'Pending Approval'){
                cta.Approved_By__c = UserInfo.getUserId();
                cta.Approved_On__c = System.today();
            }
        }
    }
    
    public static void afterTriggerHandler(Map<Id, Class_Transfer_Approvel__c> transferApprovalMap, List<Class_Transfer_Approvel__c> transferApprovalList){
        
        Map<Id, Class_Transfer_Approvel__c> approvalMap = new Map<Id, Class_Transfer_Approvel__c>();
        Map<Id, Class_Transfer_Approvel__c> rejectedMap = new Map<Id, Class_Transfer_Approvel__c>();
        for(Class_Transfer_Approvel__c cta : transferApprovalList){
            
            if(cta.Status__c == 'Approved' && transferApprovalMap.get(cta.Id).Status__c == 'Pending Approval'){
                approvalMap.put(cta.Enrollment__c, cta);
            }
            else if(cta.Status__c == 'Rejected' && transferApprovalMap.get(cta.Id).Status__c == 'Pending Approval'){
                rejectedMap.put(cta.Enrollment__c, cta);
            }
        }
        if(!approvalMap.isEmpty()){
            
            List<SFDC_Enrollment__c> transferApproveList = new List<SFDC_Enrollment__c>();
            for(SFDC_Enrollment__c enroll :[Select Id,Class_Name__c ,Contact__c,Transferred_From_Class__c,Class__r.Name,Transferred_On__c, Class__c, Transfer_To_Class__c, Status__c From SFDC_Enrollment__c Where Id IN :approvalMap.keySet()]){
                system.debug('enroll----'+enroll);
                enroll.Class__c = enroll.Transfer_To_Class__c;
                //enroll.Transferred_From_Class__c =enroll.Class__r.Name;
                //enroll.Transfer_To_Class__c = null;
                enroll.Status__c = 'Enrolled';
                enroll.Transfer_Description__c = approvalMap.get(enroll.Id).Transfer_Description__c;
                enroll.Transfer_Reason_Category__c = approvalMap.get(enroll.Id).Transfer_Reason_Category__c;
                enroll.Transfer_By__c = approvalMap.get(enroll.Id).Transfer_By__c;
                enroll.Transferred_On__c = approvalMap.get(enroll.Id).Transferred_On__c;
                enroll.Transfer_Approved_By__c = UserInfo.getUserId();
                enroll.Transfer_Approved_On__c = System.today();
                
                transferApproveList.add(enroll);                
            }
            if(!transferApproveList.isEmpty()){
                update transferApproveList;
            }
        }
        
        if(!rejectedMap.isEmpty()){
            
            List<SFDC_Enrollment__c> transferRejectList = new List<SFDC_Enrollment__c>();
            for(SFDC_Enrollment__c enroll :[Select Id, Class__c, Transfer_To_Class__c, Status__c From SFDC_Enrollment__c Where Id IN :rejectedMap.keySet()]){
                
                enroll.Transfer_To_Class__c = null;
                enroll.Status__c = 'Enrolled';
                transferRejectList.add(enroll);
            }
            if(!transferRejectList.isEmpty()){
                update transferRejectList;
            }
        }
    }
}