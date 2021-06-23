({
    onPageReferenceChange: function(component, event, helper) {
        var myPageRef = component.get("v.pageReference");
        var id = myPageRef.state.c__id;
        component.set("v.id", id);
        if(component.get("v.id") != null){helper.SearchHelper(component);}
    },
    navigate : function(component, event, helper){
        var action = component.get("c.getListViews");
        action.setCallback(this, function(response){
            if(response.getState() === "SUCCESS"){
                var listviews = response.getReturnValue(); 
                var navEvent = $A.get("e.force:navigateToList");
                navEvent.setParams({
                    "listViewId": listviews.Id,
                    "listViewName": "All Provider",
                    "scope": "Contact"
                });
                navEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
    reset : function(component,event,helper){
        if(component.get( "v.recruiterId") == null ){
            component.set("v.searchName", '');
            component.set("v.searchProviderID", '');
            component.set("v.searchRolodexID", '');
            component.set("v.searchStudentID", '');
            component.set("v.searchCity", '');
            component.set("v.searchPostalCode", '');
            component.set("v.recruiter_Status", '');
            component.set("v.planguage", '');
            component.set("v.recruiter_Assesment", '');
            component.set("v.searchRecdate", '');
            component.set("v.recruiter_program", '');
            component.set("v.recLimits",'');
            component.set("v.recruitment_type", '');
            component.find("recruiterW_WOId").set('v.value', '');
            helper.SearchHelper(component,event,helper);
        }else{
            $A.get('e.force:refreshView').fire();
        }
    },
    Search : function(component, event, helper ){
        helper.SearchHelper(component,event,helper);
    },
    updateSelectedRecs: function (component, event) {
        var rowstoUpdate = event.getParam('selectedRows');
        component.set("v.selectedRowsCount", rowstoUpdate.length);
        component.set("v.rowsToupdate" , rowstoUpdate);
        //console.log('rowstoUpdate -' + rowstoUpdate);
    },
    handleSort: function(component, event, helper) {
        helper.handleSort(component, event);
    },
    showModel: function(component, event, helper) {
        component.set("v.showModal", true);
    },
    hideModel: function(component, event, helper) {
        component.set("v.showModal", false);
    },
    saveDetails: function(component, event, helper) {
        var action = component.get("c.assignedUser");
        action.setParams({
            userId : component.get('v.OwnerId'),
            providerIds : JSON.stringify(component.get("v.rowsToupdate"))
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(response.getState() === "SUCCESS"){
                console.log( ' State ' + response.getState() );
                console.log( ' Resoponse values modules ' + response.getReturnValue());
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    type: 'Success',
                    message: ' Recruiter has assigned successfully !!',
                    duration:'100',
                    key: 'info_alt',
                    mode: 'dismissible'
                });
                toastEvent.fire();
                $A.get('e.force:refreshView').fire();
            }
            else{
                var errors = response.getError();
                var message = "Error: Unknown error";
                if(errors && Array.isArray(errors) && errors.length > 0)
                    message = "Error: "+errors[0].message;
                component.set("v.error", message);
                console.log('Error message - ' + message);
            }
        });
        $A.enqueueAction(action);
        component.set("v.showModal", false);
    },
    getLookUpValues : function(component, event, helper){
        var fieldName = event.getParam("fieldName");
        var AssignId = event.getParam("selectedRecordId");
        component.set("v.AssignId", AssignId);
        component.set( "v.OwnerId", AssignId);
    },
    getfiltervalues : function(component,event,helper){
        var fieldNames = event.getParam("fieldNames");
        var selectedOwnerId = event.getParam("selectedOwnerId");
        component.set( "v.recruiterId", selectedOwnerId);
        console.log( selectedOwnerId );
        console.log( ' selectedOwner ' + component.get( "v.recruiterId"));
       if( selectedOwnerId != null){
          helper.SearchHelper(component,event,helper);   
        }   
    }
})