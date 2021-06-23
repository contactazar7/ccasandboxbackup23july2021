trigger ClassTransferApprovalTrigger on Class_Transfer_Approvel__c (before update, after update) {
    
    if(Trigger.isUpdate){
        
        if(Trigger.isBefore){
            ClassTransferApprovaTriggerlHandler.beforeTriggerHandler(Trigger.oldMap, Trigger.New);
        }
        
        if(Trigger.isAfter){
            ClassTransferApprovaTriggerlHandler.afterTriggerHandler(Trigger.oldMap, Trigger.New);
        }
    }
}