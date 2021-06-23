({
    doInit : function(component,event,helper){
       var id= component.get("v.recordId");
      
         var action = component.get("c.editrecords");
       
        action.setParams({
           
            'id' : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
          
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                  if(storeResponse[0].Instructor_ID__c != null){
                      component.set("v.selectedRecord.Name" ,storeResponse[0].Instructor_ID__r.Name ); 
       
        var forclose = component.find("lookup-pill");
           $A.util.addClass(forclose, 'slds-show');
           $A.util.removeClass(forclose, 'slds-hide');
  
        var forclose = component.find("searchRes");
           $A.util.addClass(forclose, 'slds-is-close');
           $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');
                  
                      
                  }
                if(storeResponse[0].Instructor_ID_2__c != null){
                      component.set("v.selectedRecord1.Name" ,storeResponse[0].Instructor_ID_2__r.Name ); 
       
        var forclose = component.find("lookup-pill1");
           $A.util.addClass(forclose, 'slds-show');
           $A.util.removeClass(forclose, 'slds-hide');
  
        var forclose = component.find("searchRes1");
           $A.util.addClass(forclose, 'slds-is-close');
           $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField1");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');
                  
                      
                  }
                
                if(storeResponse[0].Monday_Start_Time__c != null){
                  //   alert("call");
   var hrs = ~~(storeResponse[0].Monday_Start_Time__c / 3600000);
    var mins = ~~((storeResponse[0].Monday_Start_Time__c % 3600) / 60);
    var secs = ~~storeResponse[0].Monday_Start_Time__c % 60;
                    
                    
                   var formatted = hrs.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
    // (hrs > 0) {
      //  ret += "0 " + hrs + ":" + (mins < 10 ? "0" : "");
   // }else{
                    
    //ret += "" + mins + ":" + (secs < 10 ? "0" : "");
    //ret += "" + secs;
                   
   // }             
                    // alert("ss"+formatted);
                         var hrs1 = ~~(storeResponse[0].Monday_End_Time__c / 3600000);
    var mins1 = ~~((storeResponse[0].Monday_End_Time__c % 3600) / 60);
    var secs1 = ~~storeResponse[0].Monday_End_Time__c % 60;
                    
                       var formatted1 = hrs1.toString().padStart(2, '0') + ':' + mins1.toString().padStart(2, '0') + ':' + secs1.toString().padStart(2, '0');
   
                    
                
                  
 
                    component.set("v.monday", true);
                    component.set("v.startendtime", false);
                    component.set("v.Mondaystarttime",  formatted+".000Z");
                    component.set("v.Mondayendtime", formatted1+".000Z");
                }
                if(storeResponse[0].Tuesday_Start_Time__c != null){
                    var hrs = ~~(storeResponse[0].Tuesday_Start_Time__c / 3600000);
                     var mins = ~~((storeResponse[0].Tuesday_Start_Time__c % 3600) / 60);
                     var secs = ~~storeResponse[0].Tuesday_Start_Time__c % 60; 
                      var formatted = hrs.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
                      
                      var hrs1 = ~~(storeResponse[0].Tuesday_End_Time__c / 3600000);
                      var mins1 = ~~((storeResponse[0].Tuesday_End_Time__c % 3600) / 60);
                       var secs1 = ~~storeResponse[0].Tuesday_End_Time__c % 60;
                    
                       var formatted1 = hrs1.toString().padStart(2, '0') + ':' + mins1.toString().padStart(2, '0') + ':' + secs1.toString().padStart(2, '0');
   
                    component.set("v.tuesday", true);
                    component.set("v.startendtime", false);
                    component.set("v.Tuesdaystarttime", formatted+".000Z");
                    component.set("v.Tuesdayendtime", formatted1+".000Z");
                }
                 if(storeResponse[0].Wednesday_Start_Time__c != null){
                     var hrs = ~~(storeResponse[0].Wednesday_Start_Time__c / 3600000);
                     var mins = ~~((storeResponse[0].Wednesday_Start_Time__c % 3600) / 60);
                     var secs = ~~storeResponse[0].Wednesday_Start_Time__c % 60; 
                      var formatted = hrs.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
                      
                      var hrs1 = ~~(storeResponse[0].Wednesday_End_Time__c / 3600000);
                      var mins1 = ~~((storeResponse[0].Wednesday_End_Time__c % 3600) / 60);
                       var secs1 = ~~storeResponse[0].Wednesday_End_Time__c % 60;
                    
                       var formatted1 = hrs1.toString().padStart(2, '0') + ':' + mins1.toString().padStart(2, '0') + ':' + secs1.toString().padStart(2, '0');
   
                    component.set("v.wednesday", true);
                    component.set("v.startendtime", false);
                    component.set("v.Wednesdaystarttime", formatted+".000Z");
                    component.set("v.Wednesdayendtime", formatted1+".000Z");
                }
                 if(storeResponse[0].Thursday_Start_Time__c != null){
                      var hrs = ~~(storeResponse[0].Thursday_Start_Time__c / 3600000);
                     var mins = ~~((storeResponse[0].Thursday_Start_Time__c % 3600) / 60);
                     var secs = ~~storeResponse[0].Thursday_Start_Time__c % 60; 
                      var formatted = hrs.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
                      
                      var hrs1 = ~~(storeResponse[0].Thursday_End_Time__c / 3600000);
                      var mins1 = ~~((storeResponse[0].Thursday_End_Time__c % 3600) / 60);
                       var secs1 = ~~storeResponse[0].Thursday_End_Time__c % 60;
                    
                       var formatted1 = hrs1.toString().padStart(2, '0') + ':' + mins1.toString().padStart(2, '0') + ':' + secs1.toString().padStart(2, '0');
   
                    component.set("v.thursday", true);
                    component.set("v.startendtime", false);
                    component.set("v.Thursdaystarttime", formatted+".000Z");
                    component.set("v.Thursdayendtime", formatted1+".000Z");
                }
                if(storeResponse[0].Friday_Start_Time__c != null){
                      var hrs = ~~(storeResponse[0].Friday_Start_Time__c / 3600000);
                     var mins = ~~((storeResponse[0].Friday_Start_Time__c % 3600) / 60);
                     var secs = ~~storeResponse[0].Friday_Start_Time__c % 60; 
                      var formatted = hrs.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
                      
                      var hrs1 = ~~(storeResponse[0].Friday_End_Time__c / 3600000);
                      var mins1 = ~~((storeResponse[0].Friday_End_Time__c % 3600) / 60);
                       var secs1 = ~~storeResponse[0].Friday_End_Time__c % 60;
                    
                       var formatted1 = hrs1.toString().padStart(2, '0') + ':' + mins1.toString().padStart(2, '0') + ':' + secs1.toString().padStart(2, '0');
                    component.set("v.friday", true);
                    component.set("v.startendtime", false);
                    component.set("v.Fridaystarttime", formatted+".000Z");
                    component.set("v.Fridayendtime", formatted1+".000Z");
                }
                if(storeResponse[0].Saturday_Start_Time__c != null){
                      var hrs = ~~(storeResponse[0].Saturday_Start_Time__c / 3600000);
                     var mins = ~~((storeResponse[0].Saturday_Start_Time__c % 3600) / 60);
                     var secs = ~~storeResponse[0].Saturday_Start_Time__c % 60; 
                      var formatted = hrs.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
                      
                      var hrs1 = ~~(storeResponse[0].Saturday_End_Time__c / 3600000);
                      var mins1 = ~~((storeResponse[0].Saturday_End_Time__c % 3600) / 60);
                       var secs1 = ~~storeResponse[0].Saturday_End_Time__c % 60;
                    
                       var formatted1 = hrs1.toString().padStart(2, '0') + ':' + mins1.toString().padStart(2, '0') + ':' + secs1.toString().padStart(2, '0');
                    component.set("v.saturday", true);
                    component.set("v.startendtime", false);
                    component.set("v.Saturdaystarttime", formatted+".000Z");
                    component.set("v.Saturdayendtime", formatted1+".000Z");
                }
                 if(storeResponse[0].Sunday_Start_Time1__c != null){
                      var hrs = ~~(storeResponse[0].Sunday_Start_Time1__c / 3600000);
                     var mins = ~~((storeResponse[0].Sunday_Start_Time1__c % 3600) / 60);
                     var secs = ~~storeResponse[0].Sunday_Start_Time1__c % 60; 
                      var formatted = hrs.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
                      
                      var hrs1 = ~~(storeResponse[0].Sunday_End_Time1__c / 3600000);
                      var mins1 = ~~((storeResponse[0].Sunday_End_Time1__c % 3600) / 60);
                       var secs1 = ~~storeResponse[0].Sunday_End_Time1__c % 60;
                    
                       var formatted1 = hrs1.toString().padStart(2, '0') + ':' + mins1.toString().padStart(2, '0') + ':' + secs1.toString().padStart(2, '0');
                    component.set("v.sunday", true);
                    component.set("v.startendtime", false);
                    component.set("v.Sundaystarttime", formatted+".000Z");
                    component.set("v.Sundayendtime", formatted1+".000Z");
                }
                if(storeResponse[0].Start_Time__c != null){
                      var hrs = ~~(storeResponse[0].Start_Time__c / 3600000);
                     var mins = ~~((storeResponse[0].Start_Time__c % 3600) / 60);
                     var secs = ~~storeResponse[0].Start_Time__c % 60; 
                      var formatted = hrs.toString().padStart(2, '0') + ':' + mins.toString().padStart(2, '0') + ':' + secs.toString().padStart(2, '0');
                      
                      var hrs1 = ~~(storeResponse[0].End_Time__c / 3600000);
                      var mins1 = ~~((storeResponse[0].End_Time__c % 3600) / 60);
                       var secs1 = ~~storeResponse[0].End_Time__c % 60;
                    
                       var formatted1 = hrs1.toString().padStart(2, '0') + ':' + mins1.toString().padStart(2, '0') + ':' + secs1.toString().padStart(2, '0');
                    component.set("v.startendtime", true);
                  
                    component.set("v.sarttime", formatted+".000Z");
                    component.set("v.endtime", formatted1+".000Z");
                }
                if(storeResponse[0].Count_of_Roster__c >= 1){
                component.set("v.disableallfields", true);
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
   
   onfocus : function(component,event,helper){
       $A.util.addClass(component.find("mySpinner"), "slds-show");
        var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
        // Get Default 5 Records order by createdDate DESC  
       
         var getInputkeyWord = '';
         helper.searchHelper(component,event,getInputkeyWord);
    },
     onfocus1 : function(component,event,helper){
       $A.util.addClass(component.find("mySpinner"), "slds-show");
        var forOpen = component.find("searchRes1");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
        // Get Default 5 Records order by createdDate DESC  
         var getInputkeyWord = '';
         helper.searchHelper1(component,event,getInputkeyWord);
    },
    onblur : function(component,event,helper){ 
               

        component.set("v.listOfSearchRecords", null );
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    onblur1 : function(component,event,helper){       
        component.set("v.listOfSearchRecords1", null );
        var forclose = component.find("searchRes1");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    keyPressController : function(component, event, helper) {
       // get the search Input keyword   
         var getInputkeyWord = component.get("v.SearchKeyWord");
       // check if getInputKeyWord size id more then 0 then open the lookup result List and 
       // call the helper 
       // else close the lookup result List part.   
        if( getInputkeyWord.length > 0 ){
             var forOpen = component.find("searchRes");
               $A.util.addClass(forOpen, 'slds-is-open');
               $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchtwoinstructors(component,event,getInputkeyWord);
        }
        else{  
             component.set("v.listOfSearchRecords", null ); 
             var forclose = component.find("searchRes");
               $A.util.addClass(forclose, 'slds-is-close');
               $A.util.removeClass(forclose, 'slds-is-open');
          }
	},
    keyPressController1 : function(component, event, helper) {
       // get the search Input keyword   
         var getInputkeyWord = component.get("v.SearchKeyWord1");
       // check if getInputKeyWord size id more then 0 then open the lookup result List and 
       // call the helper 
       // else close the lookup result List part.   
        if( getInputkeyWord.length > 0 ){
             var forOpen = component.find("searchRes1");
               $A.util.addClass(forOpen, 'slds-is-open');
               $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchtwoinstructors(component,event,getInputkeyWord);
        }
        else{  
             component.set("v.listOfSearchRecords1", null ); 
             var forclose = component.find("searchRes1");
               $A.util.addClass(forclose, 'slds-is-close');
               $A.util.removeClass(forclose, 'slds-is-open');
          }
	},
    
  // function for clear the Record Selaction 
    clear :function(component,event,heplper){
         var pillTarget = component.find("lookup-pill");
         var lookUpTarget = component.find("lookupField"); 
        
         $A.util.addClass(pillTarget, 'slds-hide');
         $A.util.removeClass(pillTarget, 'slds-show');
        
         $A.util.addClass(lookUpTarget, 'slds-show');
         $A.util.removeClass(lookUpTarget, 'slds-hide');
      
         component.set("v.SearchKeyWord",null);
         component.set("v.listOfSearchRecords", null );
         component.set("v.selectedRecord", {} );   
        component.set("v.isModalOpen2", false);
    },
      clear1 :function(component,event,heplper){
         var pillTarget = component.find("lookup-pill1");
         var lookUpTarget = component.find("lookupField1"); 
        
         $A.util.addClass(pillTarget, 'slds-hide');
         $A.util.removeClass(pillTarget, 'slds-show');
        
         $A.util.addClass(lookUpTarget, 'slds-show');
         $A.util.removeClass(lookUpTarget, 'slds-hide');
      
         component.set("v.SearchKeyWord1",null);
         component.set("v.listOfSearchRecords1", null );
         component.set("v.selectedRecord1", {} ); 
           
        component.set("v.isModalOpen2", false);
    },
    
  // This function call when the end User Select any record from the result list.   
    handleComponentEvent : function(component, event, helper) {
    // get the selected Account record from the COMPONETN event 	 
       var selectedAccountGetFromEvent = event.getParam("recordByEvent");
       // alert("Ss"+JSON.stringify("Ss"+selectedAccountGetFromEvent));
	   component.set("v.selectedRecord" , selectedAccountGetFromEvent); 
       
        var forclose = component.find("lookup-pill");
           $A.util.addClass(forclose, 'slds-show');
           $A.util.removeClass(forclose, 'slds-hide');
  
        var forclose = component.find("searchRes");
           $A.util.addClass(forclose, 'slds-is-close');
           $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');  
         var name = component.get("v.selectedRecord.Name");
          helper.Searchinstructorcount(component, event, name);
      
	},
      handleComponentEvent1 : function(component, event, helper) {
    // get the selected Account record from the COMPONETN event 	 
       var selectedAccountGetFromEvent = event.getParam("recordByEvent1");
	   component.set("v.selectedRecord1" , selectedAccountGetFromEvent);
        


        var forclose = component.find("lookup-pill1");
           $A.util.addClass(forclose, 'slds-show');
           $A.util.removeClass(forclose, 'slds-hide');
  
        var forclose = component.find("searchRes1");
           $A.util.addClass(forclose, 'slds-is-close');
           $A.util.removeClass(forclose, 'slds-is-open');
        
        var lookUpTarget = component.find("lookupField1");
            $A.util.addClass(lookUpTarget, 'slds-hide');
            $A.util.removeClass(lookUpTarget, 'slds-show');  
        var name = component.get("v.selectedRecord1.Name");
          helper.Searchinstructorcount2(component, event, name);

      
	},
     getpicklistvalues : function(component,event,helper){
       
        var picklistvalues = component.get("v.DaysValues.Class_Days__c");
        //alert("ss"+JSON.stringify("SS"+picklistvalues));
      var check = component.get("v.checkboxss");
        // alert("ss"+JSON.stringify("SS"+check));
var start =  component.get("v.sarttime");
        var end = component.get("v.endtime");
        if(picklistvalues.includes('Monday') && check == true){
                        component.set("v.monday",true);
            component.set("v.Mondaystarttime", start);
            component.set("v.Mondayendtime", end);

        } //else{
           // component.set("v.Mondaystarttime", null);
           // component.set("v.Mondayendtime", null);
        //}
        if(picklistvalues.includes('Tuesday') && check == true){
                        component.set("v.tuesday",true);
            component.set("v.Tuesdaystarttime", start);
            component.set("v.Tuesdayendtime", end);

        } //else{
          //  component.set("v.Tuesdaystarttime", null);
           // component.set("v.Tuesdayendtime", null);
        //}
          if(picklistvalues.includes('Wednesday') && check == true){
                        component.set("v.Wednesday",true);
            component.set("v.Wednesdaystarttime", start);
            component.set("v.Wednesdayendtime", end);

        }// else{
           // component.set("v.Wednesdaystarttime", null);
            //component.set("v.Wednesdayendtime", null);
       // }
          if(picklistvalues.includes('Thursday') && check == true){
                        component.set("v.Thursday",true);
            component.set("v.Thursdaystarttime", start);
            component.set("v.Thursdayendtime", end);

        } //else{
           // component.set("v.Thursdaystarttime", null);
            //component.set("v.Thursdayendtime", null);
       // }
        if(picklistvalues.includes('Friday') && check == true){
                        component.set("v.Friday",true);
            component.set("v.Fridaystarttime", start);
            component.set("v.Fridayendtime", end);

        } //else{
           // component.set("v.Fridaystarttime", null);
           // component.set("v.Fridayendtime", null);
       // }
        if(picklistvalues.includes('Saturday') && check == true){
                        component.set("v.Saturday",true);
            component.set("v.Saturdaystarttime", start);
            component.set("v.Saturdayendtime", end);

        }// else{
           // component.set("v.Saturdaystarttime", null);
            //component.set("v.Saturdayendtime", null);
       // }
        if(picklistvalues.includes('Sunday') && check == true){
                        component.set("v.sunday",true);
            component.set("v.Sundaystarttime", start);
            component.set("v.Sundayendtime", end);

        }
        if(picklistvalues.includes('Monday') ){
       
            component.set("v.monday",true);
        }else{
               component.set("v.monday",false);
             
        }
         if(picklistvalues.includes('Tuesday')){
             component.set("v.tuesday", true);
        }else{
               component.set("v.tuesday",false);

        }
         if( picklistvalues.includes('Wednesday')){
             component.set("v.wednesday", true);
        }
        else{
               component.set("v.wednesday",false);

        }
         if(picklistvalues.includes('Thursday')){
             component.set("v.thursday", true);
        }
        else{
               component.set("v.thursday",false);

        }
         if(picklistvalues.includes('Friday')){
             component.set("v.friday",true);
        }
        else{
               component.set("v.friday",false);

        }
         if( picklistvalues.includes('Saturday')){
             component.set("v.saturday", true);
        }
         else{
               component.set("v.saturday",false);

        }
         if( picklistvalues.includes('Sunday')){
             component.set("v.sunday", true);
        }
         else{
               component.set("v.sunday",false);

        }
    
},
    getcheckboxstatus :  function(component, event, helper) {
        
        var status = component.find("same").get("v.value");
         
       component.set("v.checkboxss", status) ;       
       
        if(status ==  true){
            component.set("v.startendtime", true);
            
        }else{
             component.set("v.startendtime", false);
        }
        
    },
    monstarttime :  function(component, event, helper) {
var timeString = component.get("v.Mondaystarttime");
            //alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        //alert("ss"+JSON.stringify("Ss"+timeString));
        component.set("v.DaysValues.Monday_Start_Time1__c",timeString);
        

    },
     tuestarttime :  function(component, event, helper) {
var timeString = component.get("v.Tuesdaystarttime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Tuesday_Start_Time1__c",timeString);
      

    },
     wedstarttime :  function(component, event, helper) {
var timeString = component.get("v.Wednesdaystarttime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Wednesday_Start_Time1__c",timeString);

    },
     thustarttime :  function(component, event, helper) {
var timeString = component.get("v.Thursdaystarttime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Thursday_Start_Time1__c",timeString);

    },
     fristarttime :  function(component, event, helper) {
var timeString = component.get("v.Fridaystarttime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Friday_Start_Time1__c",timeString);

    },
     satstarttime :  function(component, event, helper) {
var timeString = component.get("v.Saturdaystarttime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Saturday_Start_Time1__c",timeString);

    },
     sunstarttime :  function(component, event, helper) {
var timeString = component.get("v.Sundaystarttime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Sunday_Start_Time__c",timeString);

    },
     monendtime :  function(component, event, helper) {
var timeString = component.get("v.Mondayendtime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Monday_End_Time2__c",timeString);

    },
     tueendtime :  function(component, event, helper) {
var timeString = component.get("v.Tuesdayendtime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Tuesday_End_Time2__c",timeString);

    },
     wedendtime :  function(component, event, helper) {
var timeString = component.get("v.Wednesdayendtime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Wednesday_End_Time2__c",timeString);

    },
     thuendtime :  function(component, event, helper) {
var timeString = component.get("v.Thursdayendtime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Thursday_End_Time2__c",timeString);

    },
     friendtime :  function(component, event, helper) {
var timeString = component.get("v.Fridayendtime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Friday_End_Time2__c",timeString);

    },
    satendtime :  function(component, event, helper) {
var timeString = component.get("v.Saturdayendtime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Saturday_End_Time2__c",timeString);

    },
     sunendtime :  function(component, event, helper) {
var timeString = component.get("v.Sundayendtime");
            // alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        component.set("v.DaysValues.Sunday_End_Time__c",timeString);

    },
   handleOnLoad : function(component, event, helper) {
          
    },	
				
	handleSuccess : function(component, event, helper) {
              

        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "Record is created successfully",
            "type": "success"
        });
        toastEvent.fire();
     

    var payload = event.getParams().response;
    var navService = component.find("navService");
    var pageReference = {
        type: 'standard__recordPage',
        attributes: {
            "recordId": payload.id,
            "objectApiName": "SFDC_Class__c",
            "actionName": "view"
        }

    }
    event.preventDefault();
    navService.navigate(pageReference);  


        
    },
   
    handleSubmit : function(component, event, helper) {
       
    },
    	 allstarttime :  function(component, event, helper) {
var timeString = component.get("v.sarttime");
          var picklistvalues = component.get("v.DaysValues.Class_Days__c");
                 // var picklistvalues = component.find("pickval").get("v.value");

        var start =  component.get("v.sarttime");
         var check = component.get("v.checkboxss");
        
           // alert("ss"+JSON.stringify("Ss"+picklistvalues));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
        //alert("ss"+JSON.stringify("Ss"+timeString));
        component.set("v.DaysValues.Start_Time1__c", timeString);
        if(picklistvalues != undefined){
 if(picklistvalues.includes('Monday') && check == true)  {
            //alert("ssssss");
                        component.set("v.monday", true);
            component.set("v.Mondaystarttime", start);
           

        } 
            //else{
            //component.set("v.Mondaystarttime", null);
           
        //}
        if(picklistvalues.includes('Tuesday') && check == true){
                        component.set("v.tuesday",true);
            component.set("v.Tuesdaystarttime", start);
           

        } //else{
           // component.set("v.Tuesdaystarttime", null);
         
       // }
                  if(picklistvalues.includes('Wednesday') && check == true){
                        component.set("v.Wednesday",true);
            component.set("v.Wednesdaystarttime", start);
          

        } //else{
            //component.set("v.Wednesdaystarttime", null);
            
      //  }
          if(picklistvalues.includes('Thursday') && check == true){
                        component.set("v.Thursday",true);
            component.set("v.Thursdaystarttime", start);
            

        } //else{
           // component.set("v.Thursdaystarttime", null);
           
        //}
        if(picklistvalues.includes('Friday') && check == true){
                        component.set("v.Friday",true);
            component.set("v.Fridaystarttime", start);
           

        } //else{
           // component.set("v.Fridaystarttime", null);
            
       // }
        if(picklistvalues.includes('Saturday') && check == true){
                        component.set("v.Saturday",true);
            component.set("v.Saturdaystarttime", start);
           

        }// else{
          //  component.set("v.Saturdaystarttime", null);
            
        //}
         if(picklistvalues.includes('Sunday') && check == true){
                        component.set("v.sunday",true);
            component.set("v.Sundaystarttime", start);
           

        }
    
        
        }
       
},
      allendtime :  function(component, event, helper) {
var timeString = component.get("v.endtime");
            //alert("ss"+JSON.stringify("Ss"+timeString));
var H = +timeString.substr(0, 2);
var h = H % 12 || 12;
var ampm = (H < 12 || H === 24) ? "AM" : "PM";
 var whiteSpace = " ";
timeString = h + timeString.substr(2, 3) + whiteSpace+ ampm; 
       
        component.set("v.DaysValues.End_Time1__c",timeString);
         var check = component.get("v.checkboxss");
        var picklistvalues = component.get("v.DaysValues.Class_Days__c");
 //alert("ss"+JSON.stringify("Ss"+picklistvalues));
        var end = component.get("v.endtime");
           if(picklistvalues != undefined){
        if(picklistvalues.includes('Monday') && check == true){
                        component.set("v.monday",true);
           
            component.set("v.Mondayendtime", end);

        } //else{
           
            //component.set("v.Mondayendtime", null);
       // }
        if(picklistvalues.includes('Tuesday') && check == true){
                        component.set("v.tuesday",true);
           
            component.set("v.Tuesdayendtime", end);

        }// else{
            
            //component.set("v.Tuesdayendtime", null);
       // }
                    if(picklistvalues.includes('Wednesday') && check == true){
                        component.set("v.Wednesday",true);
           
            component.set("v.Wednesdayendtime", end);

        } //else{
            
           // component.set("v.Wednesdayendtime", null);
        //}
          if(picklistvalues.includes('Thursday') && check == true){
                        component.set("v.Thursday",true);
            
            component.set("v.Thursdayendtime", end);

        } //else{
           
           // component.set("v.Thursdayendtime", null);
      //  }
        if(picklistvalues.includes('Friday') && check == true){
                        component.set("v.Friday",true);
            
            component.set("v.Fridayendtime", end);

        } //else{
            
           // component.set("v.Fridayendtime", null);
       // }
        if(picklistvalues.includes('Saturday') && check == true){
                        component.set("v.Saturday",true);
            
            component.set("v.Saturdayendtime", end);

        } //else{
           
           // component.set("v.Saturdayendtime", null);
        //}
        if(picklistvalues.includes('sunday') && check == true){
                        component.set("v.sunday",true);
            
            component.set("v.Sundayendtime", end);

        }
           }
},
     closeModel: function(component, event, helper) {
      // Set isModalOpen attribute to false  
      component.set("v.isModalOpen", false);
       var classId = component.get("v.recordId");
       var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
        "recordId": classId
    });
    navEvt.fire();

   },
    likenClose: function(component, event, helper) {
      // Display alert message on the click on the "Like and Close" button from Model Footer 
      // and set set the "isOpen" attribute to "False for close the model Box.
      
      component.set("v.isModalOpen1", false);
        component.set("v.isModalOpen2", false);
   },
})