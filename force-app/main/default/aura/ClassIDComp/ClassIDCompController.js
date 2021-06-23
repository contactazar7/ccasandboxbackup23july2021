({
	doinit : function(component, event, helper) {
       
       var navigateEvent = $A.get("e.force:navigateToComponent");
        navigateEvent.setParams({
            componentDef: "c:Mark_Competency_Check_Status",
            componentAttributes :{ "recordId" : component.get("v.recordId")}
        });
        navigateEvent.fire();
 var dismissActionPanel = $A.get("e.force:closeQuickAction");
    dismissActionPanel.fire();       
		
	}
})