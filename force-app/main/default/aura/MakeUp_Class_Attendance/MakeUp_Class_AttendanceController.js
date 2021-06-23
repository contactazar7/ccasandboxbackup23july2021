({
    onPageReferenceChange: function(component, event, helper) {
        var myPageRef = component.get("v.pageReference");
        var id = myPageRef.state.c__id;
        component.set("v.id", id);
        if(component.get("v.id") != null){
            helper.setupTable(component,event,helper);
        }
    },
    updateSelectedRecs: function (component, event) {
        var rowstoUpdate = event.getParam('selectedRows');
        component.set("v.selectedRowsCount", rowstoUpdate.length);
        component.set("v.rowsToupdate" , rowstoUpdate);
    },
    chooseSelectedattendance : function(component, event, helper){
        var attendancerecords = component.get("v.rowsToupdate");
        var selectedRecordsIds= [];
        for(var i=0; i<attendancerecords.length; i++){
            selectedRecordsIds.push(attendancerecords[i].Id);
        }
        var action = component.get("c.createAtdrecords");
        action.setParams({
            jsonString : selectedRecordsIds,
            recId : component.get("v.id")
        });
        action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                var allRecords = response.getReturnValue();
                if(allRecords.length > 0){
                    var toastMessage = $A.get("e.force:showToast");
                    toastMessage.setParams({
                        title : "Success",
                        message : "Attendance records has created for the make-up class!",
                        duration:'100',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'dismissible'
                        
                    }) 
                    toastMessage.fire();
                    var state = response.getState();
                    $A.get('e.force:refreshView').fire();
                }
            }else{
                var errors = response.getError();
                var message = "Error: Unknown error";
                if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                component.set("v.error", message);
            }
        });
        $A.enqueueAction(action);
    },
    navigate : function(component, event, helper){
        var recordlinkto = component.get("v.id");
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordlinkto,
        });
        navEvt.fire();
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
        var nService = component.find("viewRosterService");
        event.preventDefault();
        nService.navigate(pageReference);
    }
})