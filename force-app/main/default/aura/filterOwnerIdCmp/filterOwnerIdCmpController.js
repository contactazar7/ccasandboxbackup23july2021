({
    setselectedOwnerId : function(component, event, helper) {
        var selectedOwnerId = component.get("v.selectedOwnerId");
    	component.find("lookupField").set("v.value", selectedOwnerId);	 
        //console.log(' selectedOwnerId ' + selectedOwnerId);
    },
    OnSelect : function(component, event, helper) {
	var cmpEvent = component.getEvent("onSelectEvts");
        //console.log(' ChildObjectName ' + component.get("v.childObjectName"));
        //console.log(' fieldNames ' + component.get("v.fieldNames"));
        //console.log(' lookupField ' + component.find("lookupField").get("v.value"));
        cmpEvent.setParams({
            "childObjectName": component.get("v.childObjectName"),
            "fieldNames": component.get("v.fieldNames"),
            "selectedOwnerId": component.find("lookupField").get("v.value")
        });
        cmpEvent.fire();
    }
})