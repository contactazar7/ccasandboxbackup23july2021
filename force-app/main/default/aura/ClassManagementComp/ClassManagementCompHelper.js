({
    fetchEnrollmentDetails : function(component, event, helper) {
        
        window.setTimeout(
            $A.getCallback(function() {
                var action = component.get("c.fetchEnrollmentDetails");
                action.setParams({
                    "classId":component.get("v.classId")
                });
                action.setCallback(this, function(response){
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        component.set("v.enrollmentList", response.getReturnValue());                    
                    }
                    else{
                        alert("Error Occured");
                    }
                });
                $A.enqueueAction(action);
            }), 100
        );
    },
    
    fetchTransferReasonPickListValues: function(component, event, helper) {
        
        var action = component.get("c.getTransferPickListValues");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var fieldMap = [];
                for(var key in result){
                    fieldMap.push({key: key, value: result[key]});
                }
                component.set("v.transferReasonPickListMap", fieldMap);
            }
        });
        $A.enqueueAction(action);  
    },
    
    SearchHelper: function(component, event, searchNameText, searchCityText, searchPostalCodeText, searchStudentIDText, searchRolodexIDText, searchEdFundPrimaryText, searchEdFundSecondaryText) {

        window.setTimeout(
            $A.getCallback(function() {
        //alert('here')
        //component.find("Id_spinner").set("v.class" , 'slds-show');
        //alert('Here--'+searchKeyWord)
        //if(searchKeyWord != null)//{
        //alert('notnull')
        var action = component.get("c.fetchValues");
        /*}else if(searchKeyWord == null){
            alert('null')
            var action = component.get("c.fetchContacts");
        }*/
        action.setParams({
            'searchNameText': searchNameText,
            'searchCityText': searchCityText,
            'searchPostalCodeText': searchPostalCodeText,
            'searchEdFundPrimaryText': searchEdFundPrimaryText,
            'searchEdFundSecondaryText': searchEdFundSecondaryText,
            'searchStudentIDText': searchStudentIDText,
            'searchRolodexIDText': searchRolodexIDText,
            'classId':component.get("v.classId")
        });
        action.setCallback(this, function(response) {
            
            //component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            //alert(state)
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                if (storeResponse.length == 0) {
                    component.set("v.Message", true);
                } else {
                    component.set("v.Message", false);
                }
                component.set("v.contactList", storeResponse); 
                
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
      }), 100
  );
 },
    classSearchHelper: function(component, event, searchNameText, searchClassCourseText) {
        
        //alert('1--'+searchClassCourseText)
        var action = component.get("c.classValues");
        action.setParams({
            'searchNameText': searchNameText,
            'searchClassCourseText': searchClassCourseText,
            'contactId': component.get("v.consumerContactId")
        });
        action.setCallback(this, function(response) {
            
            //component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            //alert(state)
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                if (storeResponse.length == 0) {
                    component.set("v.Message", true);
                } else {
                    component.set("v.Message", false);
                }
                component.set("v.classList", storeResponse); 
                
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
 }
})