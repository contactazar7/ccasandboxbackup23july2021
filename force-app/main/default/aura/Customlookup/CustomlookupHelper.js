({
	searchHelper : function(component,event,getInputkeyWord) {
	  var action = component.get("c.fetchLookUpValues");
      // set param to method  
        action.setParams({
            'searchKeyWord': getInputkeyWord,
            'ObjectName' : component.get("v.objectAPIName"),
            'picklistva' :component.get("v.DaysValues.Class_Days__c"),
            'monstarttime' : component.get("v.Mondaystarttime"),
            'tuestarttime' : component.get("v.Tuesdaystarttime"),
            'wedstarttime' : component.get("v.Wednesdaystarttime"),
            'thurstarttime' : component.get("v.Thursdaystarttime"),
            'fristarttime' : component.get("v.Fridaystarttime"),
            'satstarttime' : component.get("v.Saturdaystarttime"),
            'sunstarttime' : component.get("v.Sundaystarttime"),

            'monendtime': component.get("v.Mondayendtime"),
            'tueendtime': component.get("v.Tuesdayendtime"),
            'wedendtime': component.get("v.Wednesdayendtime"),
            'thuendtime': component.get("v.Thursdayendtime"),
            'friendtime': component.get("v.Fridayendtime"),
            'satendtime': component.get("v.Saturdayendtime"),
            'sunendtime': component.get("v.Sundayendtime")

            
          });
      // set a callBack    
        action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
            }
 
        });
      // enqueue the Action  
        $A.enqueueAction(action);
    
	},
    searchHelper1 : function(component,event,getInputkeyWord) {
	  var action = component.get("c.fetchLookUpValues");
      // set param to method  
        action.setParams({
             'searchKeyWord': getInputkeyWord,
            'ObjectName' : component.get("v.objectAPIName"),
            'picklistva' :component.get("v.DaysValues.Class_Days__c"),
            'monstarttime' : component.get("v.Mondaystarttime"),
            'tuestarttime' : component.get("v.Tuesdaystarttime"),
            'wedstarttime' : component.get("v.Wednesdaystarttime"),
            'thurstarttime' : component.get("v.Thursdaystarttime"),
            'fristarttime' : component.get("v.Fridaystarttime"),
            'satstarttime' : component.get("v.Saturdaystarttime"),
            'sunstarttime' : component.get("v.Sundaystarttime"),

            'monendtime': component.get("v.Mondayendtime"),
            'tueendtime': component.get("v.Tuesdayendtime"),
            'wedendtime': component.get("v.Wednesdayendtime"),
            'thuendtime': component.get("v.Thursdayendtime"),
            'friendtime': component.get("v.Fridayendtime"),
            'satendtime': component.get("v.Saturdayendtime"),
            'sunendtime': component.get("v.Sundayendtime")
            
          });
      // set a callBack    
        action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords1", storeResponse);
            }
 
        });
      // enqueue the Action  
        $A.enqueueAction(action);
    
	},
     searchHelperinstructor2 : function(component,event,getInputkeyWord) {
	  var action = component.get("c.fetchinstructors2");
      // set param to method  
        action.setParams({
             'searchKeyWord': getInputkeyWord,
           
          });
      // set a callBack    
        action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords1", storeResponse);
            }
 
        });
      // enqueue the Action  
        $A.enqueueAction(action);
    
	},
     searchHelperinstructor1 : function(component,event,getInputkeyWord) {
	  var action = component.get("c.fetchinstructors2");
      // set param to method  
        action.setParams({
             'searchKeyWord': getInputkeyWord,
           
          });
      // set a callBack    
        action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
            }
 
        });
      // enqueue the Action  
        $A.enqueueAction(action);
    
	},
     Searchinstructorcount: function(component, event, name) {
        //alert("call");
        // show spinner message
        // component.find("Id_spinner").set("v.class" , 'slds-show');
        var action = component.get("c.fetchinstructors");
        action.setParams({
            'searchKeyWord': name,
          
        });
        action.setCallback(this, function(response) {
           // hide spinner when response coming from server 
           //s component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                var type= component.get("v.selectedRecord.Type_of_Instructor__c");
                // if storeResponse size is 0 ,display no record found message on screen.
             // alert("ss"+JSON.stringify("SS"+type));
               //  alert("ss"+JSON.stringify("SS"+ storeResponse.length));
             //component.set("v.classtype",storeResponse);
                if(storeResponse.length >=3 && type=='Part Time'){
                          component.set("v.isModalOpen1", true);

                // set numberOfRecord attribute value with length of return value from server
                component.set("v.TotalNumberOfRecord", storeResponse.length+1);
                }else if(storeResponse.length >=5 && type=='Full Time'){
                    component.set("v.isModalOpen1", true);

                // set numberOfRecord attribute value with length of return value from server
                component.set("v.TotalNumberOfRecord", storeResponse.length+1);
                }
                // set searchResult list with return value from server.
                              component.set("v.TotalNumberOfRecord", storeResponse.length+1);
//alert("ss"+JSON.stringify("SS"+storeResponse.length));
                
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
    Searchinstructorcount2: function(component, event, name) {
        //alert("call");
        // show spinner message
        // component.find("Id_spinner").set("v.class" , 'slds-show');
        var action = component.get("c.fetchinstructors");
        action.setParams({
            'searchKeyWord': name,
          
        });
        action.setCallback(this, function(response) {
           // hide spinner when response coming from server 
           //s component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                var type= component.get("v.selectedRecord1.Type_of_Instructor__c");
                // if storeResponse size is 0 ,display no record found message on screen.

// alert("ss"+JSON.stringify("SS"+type));
             // alert("ss"+JSON.stringify("SS"+storeResponse.length));
                if(storeResponse.length >= 3 && type=='Part Time'){
                          component.set("v.isModalOpen2", true);

                // set numberOfRecord attribute value with length of return value from server
               
                   component.set("v.TotalNumberOfRecord1", storeResponse.length+1);

                }else if(storeResponse.length >= 5 && type=='Full Time'){
                   
                    component.set("v.isModalOpen2", true);

                // set numberOfRecord attribute value with length of return value from server
               
                 component.set("v.TotalNumberOfRecord1", storeResponse.length+1);

                }
                // set searchResult list with return value from server.
                           
                 component.set("v.TotalNumberOfRecord1", storeResponse.length+1);
//alert("ss"+JSON.stringify("SS"+storeResponse.length));
                
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
    	searchtwoinstructors : function(component,event,getInputkeyWord) {


     var action = component.get("c.fetchValues");
    // alert("Ss"+getInputkeyWord);
        action.setParams({
            'searchKeyWord': getInputkeyWord,
           
          });
      // set a callBack    
        action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                        console.log('Test'+JSON.stringify(storeResponse));

                component.set("v.listOfSearchRecords", storeResponse);
                 component.set("v.listOfSearchRecords1", storeResponse);
            }
 
        });
      // enqueue the Action  
        $A.enqueueAction(action);
    
	},
    
})