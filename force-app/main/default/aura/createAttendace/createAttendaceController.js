({
    onPageReferenceChange: function(component, evt, helper) {
        //component.set("v.isLoading", true);
        var myPageRef = component.get("v.pageReference");
        console.log('myPageRef '+myPageRef);
        var id = myPageRef.state.c__id;
        console.log('id '+id);
        component.set("v.id", id);
        console.log(' set Id '+component.get("v.id"));
        if(component.get("v.id") != null){
            console.log('show me when this true')
            helper.setupTable(component);
        }
    },
    
    onChangeVal:function(component,event,helper) {
        console.log(' set Id '+component.get("v.id"));
        helper.setupTable(component,event,helper);
    },
    reset : function(component,event,helper){
        component.set('v.classDate','');
        helper.setupTable(component);
    },
    saveTableRecords : function(component, event, helper) {
        var recordsData = event.getParam("recordsString");
        var tableAuraId = event.getParam("tableAuraId");
        var action = component.get("c.updateRecords");
        
        action.setParams({
            jsonString: recordsData
        });
        //console.log('action setparams='+action);
        action.setCallback(this,function(response){
            var datatable = component.find(tableAuraId);
            datatable.finishSaving("SUCCESS");
            //console.log('datatable=='+datatable);
        });
        //console.log('action setCallback='+action);
        $A.enqueueAction(action);        
    },
    
    navigate : function(component, event, helper){
        
        var recordlinkto = component.get("v.id");
        console.log('recordlinkto '+recordlinkto);
        
        var navEvt = $A.get("e.force:navigateToSObject");
        console.log('navEvt '+navEvt);
        navEvt.setParams({
            "recordId": recordlinkto,
            //"url" = 'https://cube846-dev-ed.lightning.force.com/lightning/r/SFDC_Class__c/'+recordlinkto+'/view'
        });
        navEvt.fire();
    }
})