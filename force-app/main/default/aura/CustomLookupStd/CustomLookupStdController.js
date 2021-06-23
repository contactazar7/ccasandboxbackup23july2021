({
    setSelectedRecordId: function(component, event, helper) {
        var selectedRecordId = component.get("v.selectedRecordId");
    	component.find("lookupField").set("v.value", selectedRecordId);	 
        //console.log(' Selected RecordId ' + selectedRecordId);
    },
    OnSelect : function(component, event, helper) {
	var cmpEvent = component.getEvent("onSelectEvt");
        console.log(' ChildObjectName ' + component.get("v.childObjectName"));
        console.log(' fieldName ' + component.get("v.fieldName"));
        console.log(' lookupField ' + component.find("lookupField").get("v.value"));
        cmpEvent.setParams({
            "childObjectName": component.get("v.childObjectName"),
            "fieldName": component.get("v.fieldName"),
            "selectedRecordId": component.find("lookupField").get("v.value")
        });
        cmpEvent.fire();
    }
})