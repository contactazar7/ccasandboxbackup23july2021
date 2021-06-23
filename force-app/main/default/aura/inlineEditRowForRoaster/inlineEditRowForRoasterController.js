({
    doInit: function(component, event, helper) {
        component.get("v.recordId");
        console.log( ' make Up Id ' + component.get("v.makeupId"));

        // call the fetchPickListVal(component, field_API_Name, aura_attribute_name_for_store_options) -
        // method for get picklist values dynamic   
        helper.fetchPickListVal(component, 'Status__c', 'ratingPicklistOpts');
    },
    inlineEditName : function(component,event,helper){   
        // show the name edit field popup 
        component.set("v.nameEditMode", true); 
        // after the 100 millisecond set focus to input field   
        setTimeout(function(){ 
            component.find("inputId").focus();
        }, 100);
    },
    inlineEditStartTime : function(component,event,helper){   
        component.set("v.startTimeEditMode", true); 
        setTimeout(function(){ 
            component.find("starttime").focus();
        }, 100);
    },
    inlineEditModule : function(component,event,helper){   
        component.set("v.moduleEditMode", true); 
        setTimeout(function(){ 
            component.find("module").focus();
        }, 100);
    },
    inlineEditStatus : function(component,event,helper){   
        component.set("v.statusEditMode", true); 
        component.find("accStatus").set("v.options" , component.get("v.ratingPicklistOpts"));
        setTimeout(function(){ 
            component.find("accStatus").focus();
        }, 100);
    },
    
    onNameChange : function(component,event,helper){ 
        // if edit field value changed and field not equal to blank,
        // then show save and cancel button by set attribute to true
        if(event.getSource().get("v.value").trim() != ''){ 
            component.set("v.showSaveCancelBtn",true);
        }
    },
    onstarttimeChange : function(component,event,helper){ 
        if(event.getSource().get("v.value").trim() != ''){ 
            component.set("v.showSaveCancelBtn",true);
        }
    },
    onmoduleChange : function(component,event,helper){ 
        component.set("v.showSaveCancelBtn",true);
    }, 
    onRatingChange : function(component,event,helper){ 
        component.set("v.showSaveCancelBtn",true);
    },     
    
    closeNameBox : function (component, event, helper) {
        // on focus out, close the input section by setting the 'nameEditMode' att. as false   
        component.set("v.nameEditMode", false); 
        // check if change/update Name field is blank, then add error class to column -
        // by setting the 'showErrorClass' att. as True , else remove error class by setting it False   
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    }, 
    
    closeModuleBox : function (component, event, helper) {
        // on focus out, close the input section by setting the 'ratingEditMode' att. as false
        component.set("v.moduleEditMode", false); 
    },
    closestarttimeBox : function (component, event, helper) {
        component.set("v.startTimeEditMode", false); 
    },
    closeRatingBox : function (component, event, helper) {
        component.set("v.statusEditMode", false); 
    },
    onload: function(component, event, helper)
    {
        if(event.getParam("recordUi").record){
            component.set("v.currentRecord", JSON.parse(JSON.stringify(event.getParam("recordUi").record.fields)));
        }
    },
    createAttendance : function(component, event, helper){
        var recordId = component.get("v.singleRec.Id");
        console.log( ' recordId ' + recordId );
        //Fetch the Method from  inlineEditCtrlForRoaster class and create the Attendance Records for Roster
        var action = component.get("c.createAttendancefromViewRoster");
        action.setParams({
            'recId' : recordId
        });    
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                if (storeResponse.length == 0) {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        type: 'Error',
                        message: ' Records has not created for Roster ',
                        duration:'100',
                        key: 'info_alt',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                } 
                component.set("v.TotalNumberOfAttendanceRecords", storeResponse.length);
                if(storeResponse.length > 0 ){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        type: 'Success',
                        message: ' Attendance records has created for the ' + component.get("v.singleRec.Name") ,
                        duration:'100',
                        key: 'info_alt',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                    $A.get('e.force:refreshView').fire();
                }
            }else if (state === "INCOMPLETE") {
                alert('Response is Incompleted');
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + 
                              errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    markregularAttendance : function(component, event, helper){
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__markRosterattendance',
            },
            state: {
                "c__id": component.get("v.singleRec.Id")
            }
        } 
        var nService = component.find("MarkAttendanceService");
        event.preventDefault();
        nService.navigate(pageReference);
    },
    createMakeUpClass: function(component, event, helper) {
        component.set("v.showModal", true);
     },
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "showModal" attribute to "Fasle"  
        component.set("v.showModal", false);
     },
    savemakeup : function(component, event, helper) {
        component.set("v.showModal", false);
        var action = component.get("c.createMakeupAttendance");
        action.setParams({
                "rosId"         : component.get("v.singleRec.Id"),
                "classId"       : component.get("v.singleRec.Class_Name__c"),
                "scheduledDate" : component.get("v.chooseRecdate"),
                "startTime"     : component.get("v.chooseRecStartTime"),
                "endTime"       : component.get("v.chooseRecEndTime")
        })
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                if (storeResponse.length == 0) {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        type: 'Error',
                        message:  component.get("v.singleRec.Name")+' has already have a Make-Up class with Status - Open. Please Close the Open - Make-Up Class!',
                        duration:'250',
                        key: 'info_alt',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                } 
                if(storeResponse.length > 0 ){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        type: 'Success',
                        message: ' Make-up class has created for ' + component.get("v.singleRec.Name") ,
                        duration:'100',
                        key: 'info_alt',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                    $A.get('e.force:refreshView').fire();

                    //component.set("v.makeupId", storeResponse );
                    //console.log( ' make Up Id ' + component.get("v.makeupId"));
                }
            }else if (state === "INCOMPLETE") {
                alert('Response is Incompleted');
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + 
                              errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
     },
    addmakeupAttendance : function(component, event, helper){
        var pageReference = {
            type: 'standard__component',
            attributes: {
                componentName: 'c__MakeUp_Class_Attendance',
            },
            state: {
                "c__id": component.get("v.singleRec.Id")
            }
        } 
        var nService = component.find("AddMakeupService");
        event.preventDefault();
        nService.navigate(pageReference);
    }
})