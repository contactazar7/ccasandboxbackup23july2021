({
    init: function(component, event, helper) {
     var mypagerefrence = component.get("v.pageReference");
         
        //var recordTypeId = component.get("v.pageReference").state.recordTypeId;
        var recordTypeId = mypagerefrence.state.recordTypeId;
       
        component.set("v.selectedRecordId", recordTypeId);
      

    
        var actionName = component.get("v.pageReference").attributes.actionName;
        //console.log('actionName-' + actionName);
         
       
        var objectApiName = component.get("v.pageReference").attributes.objectApiName;
        //console.log('objectApiName-' + objectApiName);

    },
    reInit: function(component, event, helper) {
    $A.get("e.force:refreshView").fire();
  }

})