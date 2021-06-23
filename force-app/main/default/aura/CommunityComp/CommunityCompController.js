({
    doInit : function(component, event, helper) {
        helper.getAccontRecord(component);
        helper.getPicklistValues(component, event);
         helper.fetchroster(component, event, helper);// Calling Helper method
    },
       handleOnChange : function(component, event, helper) {
        var industry = component.get("v.students.Students_RSVP__c");
        //alert(industry);
    },
    doSave: function(component, event, helper) {
        if (component.find("fileId").get("v.files").length > 0) {
            helper.uploadHelper(component, event);
        } else {
            alert('Please Select a Valid File');
        }
    },
    
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
    },
    saveOpportunity : function(component, event) {
         //alert("ss");
        var opp = event.getSource().get("v.value")
       // console.log('opp-- > ' + JSON.stringify(opp));
       // alert("ss"+JSON.stringify("dd"+opp));
        var action1 = component.get("c.saveOpp");
        action1.setParams({ "op" : opp });
        action1.setCallback(this, function(resp){
            var state = resp.getState();
            if(state === "SUCCESS"){
                       // alert("ss"+JSON.stringify("dd"+state));

                $A.get('e.force:refreshView').fire();
                console.log('server- > ' + resp.getReturnValue());
               // alert('Success');
                  var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'The record has been updated successfully.',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
                 
            }
            else if (state === "ERROR") {
                var errors = resp.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } 
                else {
                    console.log(resp.getReturnValue());
                }
            }
        });
        $A.enqueueAction(action1);
    },
    handleClick: function(component, event, helper){
        component.set("v.showLoadingSpinner1",true);
    },
    closeModel: function(component, event, helper){
        component.set("v.showLoadingSpinner1",false);
        
    },
    submitDetails: function(component, event, helper){
        component.set("v.showLoadingSpinner1",false);
    },
    handleClick1: function(component, event, helper){
        component.set("v.session",false);
        component.set("v.programs",false);
    },
    closeModel1: function(component, event, helper){
        component.set("v.session",false);
        component.set("v.programs",false);
        
    },
    submitDetails1: function(component, event, helper){
        component.set("v.session",false);
        component.set("v.programs",false);
        
    },
    myAction : function(component, event, helper) 
    {
        component.set("v.session",true);
       
            //var accountId = component.get("v.simpleRecord.AccountId");
            // alert("accountId:::" + accountId);
            
            },
            
            programs : function(component, event, helper) 
            {
            component.set("v.programs",true);
            
            //var accountId = component.get("v.simpleRecord.AccountId");
            // alert("accountId:::" + accountId);
            var action = component.get("c.getProgramsList");
            
            action.setParams({
            
            });
            action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
            var lstContact=response.getReturnValue();       
            
             // alert("accountId"+JSON.stringify("data"+lstContact.Name));
            component.set("v.ClassList", response.getReturnValue()); 
            
            }
            else if(state === "ERROR"){
            console.log('A problem occurred: ' + JSON.stringify(response.error));
            }
            });
            
            $A.enqueueAction(action);
            },
            SaveUpdatedContacts : function(component,event,helper) 
            {
            var UpdatedList = event.getParam('draftValues');    
            //alert("data"+JSON.stringify("ss"+UpdatedList));
            var UpdateContacts = component.get("c.updateRelatedList");
            
            UpdateContacts.setParams
            ({
            Conlist : UpdatedList
            });
            UpdateContacts.setCallback(this, function(response) 
            {
            var state = response.getState();
            if (state === 'SUCCESS')
            {
            $A.enqueueAction(component.get('c.myAction'));
            $A.get('e.force:refreshView').fire();
            }
            else{
            //error handling
            }
            });
            $A.enqueueAction(UpdateContacts);
            },

    
    navigateToMyComponent : function(component, event, helper) {
    //var evt = $A.get("e.force:navigateToComponent");
    //evt.setParams({
       // componentDef : "c:ProviderCommunityDetailPage",
       // componentAttributes: {
           
        //}
   // });
   // evt.fire();
    var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
     // "url": 'providerandconsumer-detail-relatedlist'


    });
    urlEvent.fire();
}
            
            })