({
    fetchData: function (cmp,event,helper) {
    	var myPageRef = component.get("v.pageReference");
          var id = myPageRef.state.c__id;
          component.set("v.recordId", id);
          component.get("v.recordId")
          //alert("accountId:::" + component.get("v.recordId"));
              var action = component.get("c.getRelatedList");
            
            action.setParams({
                AccId: component.get("v.recordId") 
               
            });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var lstContact=response.getReturnValue();       
                    
                   //  alert("accountId"+JSON.stringify("data"+response.getReturnValue()));
                    component.set("v.ClassrelatedroasterList", response.getReturnValue()); 
                    cmp.set('v.data',response.getReturnValue());
                }
                else if(state === "ERROR"){
                    console.log('A problem occurred: ' + JSON.stringify(response.error));
                }
            });
            
            $A.enqueueAction(action);
    
    }
        
})