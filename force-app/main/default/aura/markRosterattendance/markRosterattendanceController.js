({
    onPageReferenceChange: function(component, event, helper) {
        var pageState = component.get("v.pageReference").state;
        var id = pageState.c__id;
        component.set("v.id", id);
        if(component.get("v.id") != null){
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
        action.setCallback(this,function(response){
            var datatable = component.find(tableAuraId);
            datatable.finishSaving("SUCCESS");
        });
        $A.enqueueAction(action);        
    },
    
    navigate : function(component, event, helper){
        var recordlinkto = component.get("v.id");
        var navEvt = $A.get("e.force:navigateToSObject");
        console.log('navEvt '+navEvt);
        navEvt.setParams({
            "recordId": recordlinkto,
        });
        navEvt.fire();
    },
    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    },
    
    handleRecordSelectEvent : function(component, event, helper){
        var selectedRecords = event.getParam("selectedRecords");
        console.log(JSON.stringify(selectedRecords));
        component.set('v.selectedRecords',selectedRecords); 
    },
    
    handleSelect : function(component, event, helper){
        var selectedMenu = event.detail.menuItem.get("v.value");
        var selectedRecords = component.get('v.selectedRecords');
        var attIds = [];
        selectedRecords.forEach(function(row){
            attIds.push(row.id);
        })
        var action = component.get("c.updateMassRecords");
        action.setParams({
            selectedMenu : selectedMenu,
            attIds : attIds
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            $A.get('e.force:refreshView').fire();
        });
        $A.enqueueAction(action);  
    },
    viewRoster : function(component, event, helper){
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__ClassRelatedlist',
            },
            state: {
                "c__id": component.get("v.classId")
            }
        } 
        var nService = component.find("nService");
        event.preventDefault();
        nService.navigate(pageReference);
    }
})