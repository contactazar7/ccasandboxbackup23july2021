({
    SearchHelper: function(component, event, helper) {
        component.set('v.contactrows', [
            {label: 'Provider Name', fieldName: 'recordlink', type: 'url', sortable: true , typeAttributes: { label: { fieldName: 'Name' }, target: '_blank', tooltip:{fieldName: 'Name'}}},
            {label: ' Recruiter', fieldName: 'userLink', type: 'url', sortable: true, typeAttributes: { label: { fieldName: 'Assigned_Name__c'}, target: '_blank', tooltip:{fieldName: 'Recruiter__c'}}},
            {label: 'Assigned Date' , fieldName: 'Recruiter_Assigned_Date__c', type: 'date' , sortable: true,  typeAttributes:{
                weekday: "long",
                year: "numeric",
                month: "long",
                day: "2-digit"
               // month: "2-digit",
               // day: "2-digit",
               // year:"2-digit"
            }},
            //{label: 'Empower ID', fieldName: 'Student_ID__c', type: 'text', sortable: true},
            {label: 'Recruitment Program', fieldName: 'Recruitment_Program__c', type:'picklist', sortable: true},
            {label: 'Recruitment Status', fieldName: 'Recruitment_Status__c', type:'picklist', sortable: true},
            {label: 'Recruitment Assesment', fieldName: 'Recruitment_Assessment__c', type:'picklist', sortable: true},
            {label: 'Recruitment Type', fieldName: 'Recruitment_Type__c', type:'picklist', sortable: true},
            {label: 'Language', fieldName: 'Choice_of_Class_Language__c', type:'picklist', sortable: true},
            //{label: 'CCA Provider ID', fieldName: 'CCA_Provider_ID__c', type: 'text'},
            {label: 'Residing City', fieldName: 'MailingCity', type: 'text', sortable: true},
            {label: 'Residing PostalCode', fieldName: 'MailingPostalCode', type:'text', sortable: true}
        ]);
        var action = component.get("c.fetchValues");
        action.setParams({
            'searchName': component.get("v.searchName"),
            'searchLanguage' : component.get("v.planguage"),
            'searchProviderID': component.get("v.searchProviderID"),
            'searchStudentID': component.get("v.searchStudentID"),
            'searchCity':component.get("v.searchCity"),
            'searchPostalCode':component.get("v.searchPostalCode"),
            'searchStatus':component.get("v.recruiter_Status"),
            'searchRecruiter' :component.get( "v.recruiterId"),
            'searchDate': component.get("v.searchRecdate"),
            'searchrecruiterAssesment' : component.get("v.recruiter_Assesment"),
            'searchrecruitmentProgam' : component.get("v.recruiter_program"),
            'recLimits' : component.get("v.recLimits"),
            'recruiterW_WO' : component.find("recruiterW_WOId").get("v.value"),
            'searchrecruitmentType' : component.get("v.recruitment_type")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                if (storeResponse.length == 0) {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        type: 'Error',
                        message: ' No Provider has found!',
                        duration:'100',
                        key: 'info_alt',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
                } 
                component.set("v.TotalNumberOfRecord", storeResponse.length);
                component.set("v.searchResult", storeResponse); 
                component.set("v.cloneResult" , storeResponse);
                storeResponse.forEach(function(record){
                    record.recordlink = '/'+record.Id;
                    if(record.Recruiter__c){
                        record.userLink = '/'+record.Recruiter__c;
                    } 
                });
                component.set("v.searchResult", storeResponse);
                
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
    sortBy: function(field, reverse, primer) {
        var key = primer
        ? function(x) {
            return primer(x[field]);
        }
        : function(x) {
            return x[field];
        };
        
        return function(a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    },
    handleSort: function(component, event) {
        var sortedBy = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        var cloneData = component.get('v.cloneResult');
        cloneData.sort((this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1)));
        component.set('v.searchResult', cloneData);
        component.set('v.sortDirection', sortDirection);
        component.set('v.sortedBy', sortedBy);
    }
})