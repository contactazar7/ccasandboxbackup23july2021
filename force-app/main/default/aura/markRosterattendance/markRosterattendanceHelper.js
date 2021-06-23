({
    setupTable : function(component,event, helper) {
        var action = component.get("c.getPicklistValues");
        action.setParams({
            objectAPIName: "Attendance__c",
            fieldAPIName: "Status__c"
        });
        action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                console.log('response getState == '+response.getState());
                console.log('response getValues == '+response.getReturnValue());
                var types = [];
                Object.entries(response.getReturnValue()).forEach(([key, value]) => types.push({label:key,value:value}));
                var cols = [
                    {label: "Name ", fieldName: "accountLink", type:"link", sortable: true, resizable:true, 
                     attributes:{label:{fieldName:"Name"}, title:"Click to View(New Window)", target:"_blank"}},
                    {label: "Attendance Status", fieldName: "Status__c", editable: true, type:"picklist", selectOptions:types}, 
                    {label: "Students RSVP", fieldName: "Students_RSVP__c", editable: false, type:"text"}, 
                    {label: 'Class Scheduled Date', fieldName: 'Date__c', type: 'Date'},
                    {label: 'Contact Name', fieldName: 'Contact_Name__c', type: 'Formula'},
                    {label: 'Enrollment No.', fieldName: 'Enrollment_No__c', type: 'Formula'},
                    {label: "Created Date", fieldName: "CreatedDate", type:"date", sortable: true}
                    
                ];
                component.set("v.columns", cols);
                this.loadRecords(component);
            }else{
                var errors = response.getError();
                var message = "Error: Unknown error";
                if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                component.set("v.error", message);
            }
        });
        $A.enqueueAction(action);
    },
    
    loadRecords : function(component) {
        var action = component.get("c.fetchAttendance");
        action.setParams({
            'recId': component.get("v.id")
        });
       	action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                var allRecords = response.getReturnValue();
                if(allRecords.length == 0){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        type: 'Error',
                        message: 'No records has found on requested date.',
                        duration:'100',
                        key: 'info_alt',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                }
                allRecords.forEach(rec => {
                    rec.accountLink = '/'+rec.Id;
                    component.set("v.classId" , rec.Class__c)
                });
                    
                    component.set("v.data", allRecords);
                    component.set("v.isLoading", false);
                    component.set("v.TotalNumberOfRecord", allRecords.length);
                    
                    var filterdatamethods = component.find('datatableId');
                    if(allRecords.length>0){
                    filterdatamethods.filtermethod(allRecords);
                }
                }else{
                    var errors = response.getError();
                    var message = "Error: Unknown error";
                    if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                    component.set("v.error", message);
                }
                });
                    $A.enqueueAction(action);
  }
})