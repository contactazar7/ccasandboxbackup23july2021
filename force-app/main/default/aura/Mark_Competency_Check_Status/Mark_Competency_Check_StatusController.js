({
	myAction : function(component, event, helper) {
		
	},
    doInit : function(component, event, helper) {
        var action = component.get("c.getRelatedList1"); 
        action.setParams
        ({
            recordId: component.get("v.recordId")
            
        });
        action.setCallback(this, function(response) {
            var state = response.getState(); 
            
            var result = JSON.stringify(response.getReturnValue());
            if (component.isValid() && state === "SUCCESS")
                component.set("v.Complist", response.getReturnValue());  
        });
        $A.enqueueAction(action);
    },
      openThePopUp : function(component, event, helper) {
        component.set("v.buttonss2", true);
        
        
        
    },
    
       handleClickforopp : function(component, event, helper) {
        var recordId = component.get("v.recordId");
        
        var sObectEvent = $A.get("e.force:navigateToSObject");
        sObectEvent.setParams({
            "recordId": recordId,
            "slideDevName": "detail"
        });
        sObectEvent.fire();
    },
    
    selectAll: function(component, event, helper) {
        var selectedHeaderCheck = event.getSource().get("v.value");
        
        var getAllId = component.find("boxPack");
        if(! Array.isArray(getAllId)){
            if(selectedHeaderCheck == true){ 
                component.find("boxPack").set("v.value", true);
            }else{
                component.find("boxPack").set("v.value", false);
            }
        }else{
            
            if (selectedHeaderCheck == true) {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", true);
                }
            } else {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", false);
                    // component.set("v.selectedCount", 0);
                }
            } 
        }  
    },
  Save: function(component, event, helper) {
        
        var data = component.get("v.Complist");
        
        var totalval = [];
        
        for(var i=0; i<data.length; i++) { 
            var item = data[i].Competency_Checks__r;
            
            totalval.push(item);
            
        } 
        
        var totalservicedata =JSON.stringify(totalval);
         alert("test"+totalservicedata);
        var action = component.get("c.saveservice");
        action.setParams({"lstService" : totalservicedata
                          
                         });
        
        action.setCallback(this, function(response) {
            
            
            var state = response.getState();
            if (state === "SUCCESS") {
                alert("test"+state);
                var storeResponse = response.getReturnValue();
                component.set("v.showSaveCancelBtn",false);
                $A.get('e.force:refreshView').fire();
                
            }
            else{
                var errors = response.getError();
                var message = "Error: Unknown error";
                if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                console.log("Error: "+message);
            }
        });
        $A.enqueueAction(action);
        
    },
     handleClickservice : function(component, event, helper) {
        var recordId = event.target.dataset.caseid;
        
        window.open('/' + recordId,'_blank');
    }

})