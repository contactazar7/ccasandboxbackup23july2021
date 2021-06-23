({
    doInit : function(component, event, helper) {
        
        var stringURL = window.location.hostname;
        stringURL = stringURL.split('--c')[0];
        var enrollmentURL = 'https://'+stringURL+'.lightning.force.com/lightning/r/SFDC_Enrollment__c/';
        component.set("v.customURL", enrollmentURL);
        helper.fetchEnrollmentDetails(component, event, helper);
        helper.fetchTransferReasonPickListValues(component, event, helper);
    },
    remove : function(component, event, helper) {
        
        component.set("v.enrollmentId", event.getSource().get('v.value'));
        //alert('1--'+event.getSource().get('v.value'));
        component.set("v.isRemoveReason", true);
     /*  var action = component.get("c.updateStudentRemoval");
        action.setParams({
            "enrollmentId":event.getSource().get('v.value')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                alert('Record Removed..');
                helper.fetchEnrollmentDetails(component, event, helper);
            }
            else{
                alert("Error Occured");
            }
        });    
        $A.enqueueAction(action);*/
    },
    
    openTransferModal : function(component, event, helper) {
        //component.set("v.enrollmentId", event.getSource().get('v.value'));
        component.set("v.isTransferReason", true);
        component.set("v.isClassModalOpen", false);
    },
    
    removeStudent : function(component, event, helper) {
        
         if(component.get("v.removeReasonCategory") == 'NA'){
            alert('Please enter Remove Reason Category')
            return;
        }
        //return;
        if(component.get("v.removeReasonDescription") == undefined){
            alert('Please enter Remove Reason')
            return;
        }
       var action = component.get("c.updateStudentRemoval");
        action.setParams({
            "enrollmentId":component.get("v.enrollmentId"),
            "removeReason":component.get("v.removeReasonDescription"),
            "removeReasonCtgry":component.get("v.removeReasonCategory")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.isRemoveReason", false);
                alert('Record Removed..');
                helper.fetchEnrollmentDetails(component, event, helper);
            }
            else{
                alert("Error Occured");
            }
            component.set("v.removeReasonDescription", null);
        });        
        $A.enqueueAction(action);  
    },
    
    
    transferStudent : function(component, event, helper) {
       
        if(component.get("v.transferReasonCategory") == 'NA'){
            alert('Please enter Transfer Reason Category')
            return;
        }
        //return;
        if(component.get("v.transferDescription") == undefined){
            alert('Please enter Transfer Reason')
            return;
        }
        var action = component.get("c.studentTransfer");
        action.setParams({
            "enrollmentId":component.get("v.enrollmentId"),
            "newClassId":component.get("v.selectedClassId"),
            "transferDesc":component.get("v.transferDescription"),
            "transferReason":component.get("v.transferReasonCategory")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                alert('Transfer Request sent for Approval..');
                helper.fetchEnrollmentDetails(component, event, helper);
                component.set("v.isClassModalOpen", false);
                component.set("v.isTransferReason", false);
            }
            else{
                alert("Error Occured");
            }
            component.set("v.transferDescription", null);
        });
        $A.enqueueAction(action);
    }, 
    
    openModal: function(component, event, helper) {
        
        component.set("v.isModalOpen", true);
        var action = component.get("c.fetchContacts");
        action.setParams({
            "classId":component.get("v.classId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contactList", response.getReturnValue());
            }
            else{
                alert("Error Occured");
            }
        });
        $A.enqueueAction(action);
    },
    
    backtoClass : function (component, event, helper) {
        var baseURL = window.location.href;
        var domain = baseURL.substring(8, baseURL.indexOf("--c"));
        window.open('https://'+domain+'.lightning.force.com/lightning/r/SFDC_Class__c/'+component.get('v.classId')+'/view',"_self");
    },
    
    closeModal: function(component, event, helper) {
        component.set("v.isModalOpen", false);
    },    
    closeRemoveModal: function(component, event, helper) {
        component.set("v.isRemoveReason", false);
    },
    closeTransferModal: function(component, event, helper) {
        component.set("v.isTransferReason", false);
        component.set("v.isClassModalOpen", true);
    },
    closeConsumerModal: function(component, event, helper) {
        component.set("v.isConsumerModalOpen", false);
    },
    closeViewConsumerModal: function(component, event, helper) {
        component.set("v.ViewConsumerModalOpen", false);
    },
    closeClassModal: function(component, event, helper) {
        component.set("v.isClassModalOpen", false);
    },
    
    createRecords: function(component, event, helper) {
        
        var action = component.get("c.createEnrollments");
        var selectedIds =  [];
        if(event.getSource().get('v.name') == 'consumer'){
            selectedIds = component.get("v.selectedConsumers");
        }
        else if(event.getSource().get('v.name') == 'class'){
            selectedIds = component.get("v.selectedContacts");
        }
        action.setParams({
            "selectedIds":selectedIds,
            "classId":component.get("v.classId"),
            "enrollType":event.getSource().get('v.name'),
            "enrollmentId":component.get("v.enrollmentId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            //alert(state)
            if (state === "SUCCESS") {
                alert('Records Created..');
                helper.fetchEnrollmentDetails(component, event, helper);
            }
            else{
                alert("Error Occured");
            }
        });
        $A.enqueueAction(action);
        if(event.getSource().get('v.name') == 'class'){
            component.set("v.isModalOpen", false);
        }
        else if(event.getSource().get('v.name') == 'consumer'){
            component.set("v.isConsumerModalOpen", false);
        }
    },
    
    handleCheck: function(component, event, helper) {
        
        var selectedIds =  [];
        var getAllId = component.find("checkbox");
        for(var i = 0; i < getAllId.length; i++){
            if(getAllId[i].get("v.value")){
                selectedIds.push(getAllId[i].get("v.name"));
            }
        }
        component.set('v.selectedContacts', selectedIds);
    },
    handleConsumerCheck: function(component, event, helper) {
        
        var selectedIds =  [];
        var getAllId = component.find("checkbox1");
        for(var i = 0; i < getAllId.length; i++){
            
            if(getAllId[i].get("v.value")){
                selectedIds.push(getAllId[i].get("v.name"));
            }
        }
        component.set('v.selectedConsumers', selectedIds);
        //alert(component.get("v.selectedConsumers"))
    },
    handleRemoveConsumers: function(component, event, helper) {
        
        var selectedIds =  [];
        var getAllId = component.find("consumerCheckbox");
        for(var i = 0; i < getAllId.length; i++){
            
            if(getAllId[i].get("v.value")){
                selectedIds.push(getAllId[i].get("v.name"));
            }
        }
        component.set('v.selectedConsumers', selectedIds);
        //alert(component.get("v.selectedConsumers"))
    },
    removeConsumers: function(component, event, helper) {
        
        
        var action = component.get("c.deleteConsumers");
        action.setParams({
            "selectedIds":component.get('v.selectedConsumers'),
            "classId":component.get('v.classId')
                    
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                alert('Consumers Removed...')
                helper.fetchEnrollmentDetails(component, event, helper);
            }
            else{
                alert("Error Occured");
            }
        });
        $A.enqueueAction(action);
        component.set("v.ViewConsumerModalOpen", false);
    },
     handleClassCheck: function(component, event, helper) {
         component.set('v.selectedClassId', event.getSource().get("v.text"));
         //alert(component.get("v.selectedClassId"))
         //component.set("v.value", selectedClassId);
    },
    /* keyPressController : function(component, event, helper) {
        
        var getInputkeyWord = component.get("v.SearchKeyWord");
        if( getInputkeyWord.length > 0 ){
            helper.searchHelper(component,event,getInputkeyWord);
        }else{
            var action = component.get("c.fetchContacts");
            action.setParams({
                "classId":component.get("v.classId")
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    component.set("v.contactList", response.getReturnValue());
                }
                else{
                    alert("Error Occured");
                }
            });
            $A.enqueueAction(action);
        }
    },*/
    classSearch: function(component, event, helper) {
        //alert('here')
        var searchClassNameField = component.find('className');
        var searchClassNameText = searchClassNameField.get('v.value');
        var searchClassCourseField = component.find('classCourse');
        var searchClassCourseText = searchClassCourseField.get('v.value');
        //alert(searchClassNameText)
        helper.classSearchHelper(component, event, searchClassNameText, searchClassCourseText);
    },
    Search: function(component, event, helper) {
        //alert(component.find('v.searchKeyword'));
        var searchNameField = component.find('name');
        var searchNameText = searchNameField.get('v.value');
        var searchCityField = component.find('mailingCity');
        var searchCityText = searchCityField.get('v.value');           
        var searchPostalCodeField = component.find('postalCode');
        var searchPostalCodeText = searchPostalCodeField.get('v.value');        
        var searchEdFundPrimaryField = component.find('EdFundPrimary');
        var searchEdFundPrimaryText = searchEdFundPrimaryField.get('v.value');        
        var searchEdFundSecondaryField = component.find('EdFundSecondary');
        var searchEdFundSecondaryText = searchEdFundSecondaryField.get('v.value');
        var searchRolodexIDField = component.find('RolodexID');
        var searchRolodexIDText = searchRolodexIDField.get('v.value');
        var searchStudentIDField = component.find('StudentID');
        var searchStudentIDText = searchStudentIDField.get('v.value');
        //alert(searchText)
        
        /*if(searchText == null) {
            searchField.showHelpMessageIfInvalid();
            searchField.focus();
        }else{*/
            // else call helper function 
            helper.SearchHelper(component, event, searchNameText, searchCityText, searchPostalCodeText, searchRolodexIDText, searchStudentIDText, searchEdFundPrimaryText, searchEdFundSecondaryText );
        //}
    },
    Clear: function(component, event, helper) {
        //alert(component.find('v.searchKeyword'));
         var searchNameField = component.find('name').set("v.value", "");
         var searchCityField = component.find('mailingCity').set("v.value", "");
         var searchPostalCodeField = component.find('postalCode').set("v.value", "");
         var searchRolodexIDField = component.find('RolodexID').set("v.value", "");
         var searchStudentIDField = component.find('StudentID').set("v.value", "");
         var searchEdFundPrimaryField = component.find('EdFundPrimary').set("v.value", "");
         var searchEdFundSecondaryField = component.find('EdFundSecondary').set("v.value", "");
        
            helper.SearchHelper(component, event );
       
    },
    consumer: function(component, event, helper) {
        
        //alert(event.getSource().get('v.name'))
        component.set("v.isConsumerModalOpen", true);
        component.set("v.consumerContactId", event.getSource().get('v.value'));
        component.set("v.enrollmentId", event.getSource().get('v.name'));
        var action = component.get("c.fetchConsumers");
        action.setParams({
            "contactId":event.getSource().get('v.value'),
            "enrollmentId":event.getSource().get('v.name'),
            "classId":component.get('v.classId')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.consumerList", response.getReturnValue());
            }
            else{
                alert("Error Occured");
            }
        });
        $A.enqueueAction(action);
    },
    
    Viewconsumer: function(component, event, helper) {
        
        //alert(event.getSource().get('v.name'))
        component.set("v.ViewConsumerModalOpen", true);
        //component.set("v.ViewconsumerId", event.getSource().get('v.value'));
        //component.set("v.ViewconsumerId", event.getSource().get('v.name'));
        var action = component.get("c.viewConsumers");
       
        action.setParams({
            "enrollmentId":event.getSource().get('v.name'),
            "classId":component.get('v.classId')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            //alert(state)
            if (state === "SUCCESS") {
                component.set("v.viewconsumerList", response.getReturnValue());
            }
            else{
                alert("Error Occured");
            }
            //alert(JSON.stringify(component.get("v.viewconsumerList")))
        });
        $A.enqueueAction(action);
    },
    openClass: function(component, event, helper) {
        
        //alert(event.getSource().get('v.name'))
        component.set("v.isClassModalOpen", true);
        component.set("v.enrollmentId", event.getSource().get('v.value'));
        component.set("v.consumerContactId", event.getSource().get('v.name'));
        var action = component.get("c.fetchClassDetails");
        //alert(event.getSource().get('v.name'))
        //alert(event.getSource().get('v.value'))
        action.setParams({
            "classId":component.get('v.classId'),
            "contactId":component.get("v.consumerContactId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            //alert(state)
            if (state === "SUCCESS") {
                component.set("v.classList", response.getReturnValue());
            }
            else{
                alert("Error Occured");
            }
            //alert(JSON.stringify(component.get("v.classList")))
        });
        $A.enqueueAction(action);
    }
    
 
})