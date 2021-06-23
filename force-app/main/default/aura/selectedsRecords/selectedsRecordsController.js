({
   selectRecord : function(component, event, helper){      
    // get the selected record from list  
   // alert("call");
      var getSelectRecord = component.get("v.oRecord");
    // call the event   
      var compEvent = component.getEvent("oSelectedRecordEvent1");
    // set the Selected sObject Record to the event attribute.  
         compEvent.setParams({"recordByEvent1" : getSelectRecord });  
    // fire the event  
         compEvent.fire();
    },
})