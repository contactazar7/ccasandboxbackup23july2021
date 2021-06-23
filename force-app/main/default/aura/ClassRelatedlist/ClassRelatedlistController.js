({
    myAction : function(component, event, helper) 
    {
        var myPageRef = component.get("v.pageReference");
        var id = myPageRef.state.c__id;
        component.set("v.recordId", id);
        component.get("v.recordId")
        var action = component.get("c.getRelatedList");
        
        action.setParams({
            AccId: component.get("v.recordId") 
            
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var lstContact=response.getReturnValue();       
                
                //  alert("accountId"+JSON.stringify("data"+response.getReturnValue()));
                component.set("v.ClassrelatedroasterList", response.getReturnValue()); 
                
            }
            else if(state === "ERROR"){
                console.log('A problem occurred: ' + JSON.stringify(response.error));
            }
        });
        
        $A.enqueueAction(action);
    },
    navigate:function(component){
        
        var idx= event.currentTarget.id;
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": idx,
            "slideDevName": "detail"
            
        });
        navEvt.fire(); 
    },
    backtoClass : function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.recordId"),
            "slideDevName": "Detail"
        });
        navEvt.fire();
    },
    Save: function(component, event, helper) {
        var action = component.get("c.saveRoaster");
        action.setParams({
            'lstRoaster': component.get("v.ClassrelatedroasterList")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                component.set("v.ClassrelatedroasterList", storeResponse);
                component.set("v.showSaveCancelBtn",false);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'The record has been updated successfully.',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire();
                        $A.get('e.force:refreshView').fire(); 

                //alert('Updated...');
            }
        });
        $A.enqueueAction(action);
        
    },
    
    cancel : function(component,event,helper){
        $A.get('e.force:refreshView').fire(); 
    } 
    
})