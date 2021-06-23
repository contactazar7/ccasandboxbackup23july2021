({
    onPageReferenceChange: function(component, evt, helper) {
        var myPageRef = component.get("v.pageReference");
        //console.log('myPageRef '+myPageRef);
        //alert('myPageRef '+myPageRef);
        var id = myPageRef.state.c__id;
        //alert('myPageRef id '+id);
        //console.log('id '+id);
        component.set("v.id", id);
        //console.log(' set Id '+component.get("v.id"));
        if(component.get("v.id") != null){
            //console.log('show me when this true');
            helper.setupTable(component,event,helper);
        }
    }, 
    //Below onChangeVal function is used for to pass the Class scheduled date to get the attendance.
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
    },
    
    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    },
    
    handleRecordSelectEvent : function(component, event, helper){
        //alert('handleRecordSelectEvent called');
        var selectedRecords = event.getParam("selectedRecords");
        //alert('selectedRecords ' + selectedRecords);
        //alert('selectedRecords ' + JSON.stringify(selectedRecords));
        console.log(JSON.stringify(selectedRecords));
        component.set('v.selectedRecords',selectedRecords); 
    },
    
    handleSelect : function(component, event, helper){
        //alert('handleSelect called');
        var selectedMenu = event.detail.menuItem.get("v.value");
        var selectedRecords = component.get('v.selectedRecords');
        var attIds = [];
        selectedRecords.forEach(function(row){
            attIds.push(row.id);
        })
        //alert(JSON.stringify(selectedRecords));
        console.log(' Selected Records '+JSON.stringify(selectedRecords));
        
        var action = component.get("c.updateMassRecords");
        
        action.setParams({
            //jsonString : JSON.stringify(selectedRecords, selectedMenu, attIds),
            selectedMenu : selectedMenu,
            attIds : attIds
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            //alert(state)
            $A.get('e.force:refreshView').fire();
        });
        $A.enqueueAction(action);  
    }
})