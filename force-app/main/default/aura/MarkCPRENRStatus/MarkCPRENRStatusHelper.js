({
    setupTable : function(component,event, helper) {
        var action = component.get("c.getPicklistValues");
        console.log('action=='+action);
        action.setParams({
            objectAPIName: "SFDC_Enrollment__c",
            fieldAPIName: "CPR_Status__c"
        });
        console.log('action after set params=='+action);
        action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                console.log('response getState == '+response.getState());
                console.log('response getValues == '+response.getReturnValue());
                var types = [];
                Object.entries(response.getReturnValue()).forEach(([key, value]) => types.push({label:key,value:value}));
                var cols = [
                    {label: "Name ", fieldName: "enrollLink", type:"link", sortable: true, resizable:true, 
                     attributes:{label:{fieldName:"Name"}, title:"Click to View(New Window)", target:"_blank"}},
                    {label: "Provider", fieldName: "providerLink", type:"link", sortable: true, resizable:true, 
                     attributes:{label:{fieldName:"Provider_Name__c"}, title:"Click to View(New Window)", target:"_blank"}},
                    {label: "CPR Status", fieldName: "CPR_Status__c", editable: true, type:"picklist", selectOptions:types}, 
                    {label: 'CPR Valid From', fieldName: 'CPR_Valid_From__c', editable: true, type: 'Date'},
                    //{label: 'CPR Certificate Uploaded?', fieldName: 'CPR_Certificate_Uploaded__c', editable: false, type: 'picklist',selectOptions:types},
                    {label: 'CPR Valid Till', fieldName: 'CPR_Valid_Till__c', type: 'text'},
                    {label: 'Days to Expire', fieldName: 'Days_to_Expire__c', type: 'text'},
                    {label: 'Enrollment Status', fieldName: 'Status__c', editable: false, type: 'picklist',selectOptions:types},
                    //{label: 'Class Name', fieldName: 'Class__c', type: 'text'}
                    //{label: "Created Date", fieldName: "CreatedDate", type:"date", sortable: true}
                ];
                    component.set("v.columns", cols);
                    this.loadRecords(component);
                    }else{
                    var errors = response.getError();
                    console.log('errors '+errors);
                    var message = "Error: Unknown error";
                    if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                component.set("v.error", message);
                console.log("Error: "+message);
            }
        });
        $A.enqueueAction(action);
    },
    
    loadRecords : function(component) {
        var action = component.get("c.fetchEnrollment");
        console.log('action fetchEnrollment='+component.get("c.fetchEnrollment"));
        console.log(' record Id for class '+component.get("v.id") ); 
        console.log(' schduled date for the class '+component.get("v.classDate")); 
        action.setParams({
            'recId': component.get("v.id")
            //'classDate' : component.get("v.classDate")
        });
        console.log('action.setParams loadRecords='+action.setParams);
        action.setCallback(this,function(response){
            if(response.getState() === "SUCCESS"){
                
                console.log('response getState == '+response.getState());
                console.log('response getValues == '+response.getReturnValue());
                
                var allRecords = response.getReturnValue();
                console.log('allRecords=='+allRecords);
                console.log('allRecords.length=='+allRecords.length);
                console.log('response.getReturnValue()=='+response.getReturnValue());
                if(allRecords.length == 0){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        type: 'Error',
                        message: 'No records has found on requested date.',
                        duration:'100',
                        key: 'info_alt',
                        mode: 'dismissible'
                        //mode: 'sticky'
                    });
                    toastEvent.fire();
                }
                allRecords.forEach(rec => {
                    rec.enrollLink = '/'+rec.Id;
                    rec.providerLink = '/'+rec.Contact__c;
                    component.set("v.classname", rec.Class_Name__c);
                });
                    
                    component.set("v.data", allRecords);
                    component.set("v.isLoading", false);
                    component.set("v.TotalNumberOfRecord", allRecords.length);
                    console.log('v.data for Init from Parent=='+allRecords);
                    console.log('data after loadRecords=='+JSON.parse(JSON.stringify(component.get("v.data"))));
                    
                    var filterdatamethods = component.find('datatableId');
                    console.log('filterdatamethods before=='+filterdatamethods);
                    if(allRecords.length>0){
                    filterdatamethods.filtermethod(allRecords);
                    console.log('filterdatamethods after=='+filterdatamethods);
                   }
                }else{
                    var errors = response.getError();
                    var message = "Error: Unknown error";
                    if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                    component.set("v.error", message);
                    console.log("Error: "+message);
                }
                });
                    $A.enqueueAction(action);
  }
})