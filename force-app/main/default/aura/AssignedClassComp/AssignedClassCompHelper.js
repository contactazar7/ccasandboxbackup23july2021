({
    fetchEnrollmentDetails : function(component, event, helper) {
         
        window.setTimeout(
            $A.getCallback(function() {
                //alert(component.get("v.contactId"))
                var action = component.get("c.fetchEnrollmentDetails");
                action.setParams({
                    "contactId":component.get("v.contactId"),
                    //"classId":component.get("v.classId")
                    
                });
                action.setCallback(this, function(response){
                    var state = response.getState();
                    //alert(state)
                    if (state === "SUCCESS") {
                        component.set("v.classList", response.getReturnValue());
                        /*var classIds =  []; 
                        for (const element of response.getReturnValue()) {
                            classIds.push(element.Class__c);
                        }
                        component.set("v.classIdList", classIds)*/
                        //this.fetchClassDetails(component, event, helper);
                        //alert('1--'+component.get('v.classIdList'))
                    }
                    else{
                        alert("Error Occured");
                    }
                });
                $A.enqueueAction(action);
            }), 100
        );  
    },
    
    fetchClassDetails : function(component, event, helper) {
         
        window.setTimeout(
            $A.getCallback(function() {
                //alert(component.get("v.contactId"))
                var action = component.get("c.fetchClassDetails");
                //alert('2--'+component.get('v.classIdList'))
                action.setParams({
                    "contactId":component.get("v.contactId"),
                    // "newClassId":component.get("v.newClassId")
                });
                action.setCallback(this, function(response){
                    var state = response.getState();
                    //alert(state)
                    if (state === "SUCCESS") {
                        component.set("v.fetchClassList", response.getReturnValue());                    
                    }
                    else{
                        alert("Error Occured");
                    }
                });
                $A.enqueueAction(action);
            }), 100
        );  
    },
    
 classSearchHelper: function(component, event, searchClassNameText, searchClassCourseText, searchClassCategoryText, searchClassPreferredDayText, searchLanguageText) {
        
        //alert('1--'+searchClassCourseText)
        var action = component.get("c.classValues");
        action.setParams({
            'searchClassNameText': searchClassNameText,
            'searchClassCourseText': searchClassCourseText,
            'searchClassCategoryText': searchClassCategoryText,
            'searchClassPreferredDayText': searchClassPreferredDayText,
            'searchLanguageText': searchLanguageText,
            'contactId':component.get("v.contactId")
        });
        action.setCallback(this, function(response) {
            
            //component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            //alert(state)
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                /*if (storeResponse.length == 0) {
                    component.set("v.message", true);
                } else {
                    component.set("v.message", false);
                }*/
                component.set("v.fetchClassList", storeResponse); 
                
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