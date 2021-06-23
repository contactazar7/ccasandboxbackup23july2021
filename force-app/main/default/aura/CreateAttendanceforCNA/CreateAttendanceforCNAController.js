({
    onPageReferenceChange: function (component, event, helper) {
        var myPageRef = component.get("v.pageReference");
        var id = myPageRef.state.c__id;
        component.set("v.id", id);
        if(component.get("v.id") != null){
            helper.setUpTable(component);
        }
    },
    
    updateSelectedRows: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        component.set("v.selectedRowsCount", selectedRows.length);
        
        //console.log('selectedRows '+selectedRows);
        //console.log('selectedRow as stringfy ' + JSON.stringify(selectedRows));
        
        component.set("v.selectedRecords", selectedRows);
        //console.log('selectedRows after set up '+component.get("v.selectedRecords"));
        //console.log('selectedRows.length '+selectedRows.length);
    },
    
    createAttendance : function(component, event, helper){
        var action = component.get("c.createCNAattendance");
        action.setParams({
            jsonstring : JSON.stringify(component.get("v.selectedRecords")),
            rosterId : component.get("v.id")
        })
        action.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                //console.log('createAttendance response getState == '+response.getState());
                //console.log('createAttendance response getValues == '+response.getReturnValue());
                
                var allRecords = response.getReturnValue();
                //console.log('allRecords == '+allRecords);
                //console.log('allRecords.length=='+allRecords.length);
                
                if(allRecords.length > 0){
                    
                }    
            }else{
                var errors = response.getError();
                //console.log('errors '+errors);
                var message = "Error: Unknown error";
                if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                component.set("v.error", message);
                //console.log("Error: "+message);
            }
        });
        $A.enqueueAction(action);
        var toastMessage = $A.get("e.force:showToast");
        toastMessage.setParams({
            title : "Success",
            message : "Attendance records has created for the Class",
            duration:'100',
            key: 'info_alt',
            type: 'success',
            mode: 'dismissible'
            
        }) 
        toastMessage.fire();     
        
        $A.get('e.force:refreshView').fire();
    },
    navigate : function(component, event, helper){
        var recordlinkto = component.get("v.id");
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": recordlinkto,
        });
        navEvt.fire();
    }
})