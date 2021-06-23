({
	myAction : function(component, event, helper) {
		
	},
    doInit: function(component, event, helper) {
     helper.fetchPickListValyear(component, 'IHSS_AD_Complete_Documentation_Form__c', 'washPicklistOpts');
 helper.fetchPickListValburnout(component, 'IHSS_AD_Recognizing_AD__c', 'AvoidingBurnoutvals');
  helper.fetchPickListValComDocForm(component, 'IHSS_AD_Repetitive_Qs_and_Behaviour__c', 'CompleteDocumentationFormvals');
  helper.fetchPickListValDressUndress(component, 'IHSS_AD_Dressing_Undressing__c', 'DressingUndressingvals');
  helper.fetchPickListValhelpmanage(component, 'IHSS_AD_Oral_Care__c', 'managehallvals');
  helper.fetchPickListValhomsafe(component, 'IHSS_AD_Making_the_Home_Safe__c', 'homsafvals');

    },
     inlineEditStartDate : function(component,event,helper){  
        component.set("v.startdateEditMode", true);
        setTimeout(function(){
            component.find("startdateinputId").focus();
        }, 100);
    }, onstartChange : function(component,event,helper){
        if(event.getSource().get("v.value").trim() != ''){
            component.set("v.showSaveCancelBtn",true);
        }
    },
       startNameBox : function (component, event, helper) {
        component.set("v.startdateEditMode", false);
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }
        else{
            component.set("v.showErrorClass",false);
        }
    }, 
         oncontractChange : function(component,event,helper){
        component.set("v.showSaveCancelBtn",true);
    }, 
    
    closeRatingBox : function (component, event, helper) {
        component.set("v.ratingEditMode", false);
    },
     onWashChange : function (component, event, helper) {
        component.set("v.washEditMode", false);
         component.set("v.showSaveCancelBtn",true);
    },
    onburnoutChange : function (component, event, helper) {
        component.set("v.AvoidingBurnoutEditMode", false);
        component.set("v.showSaveCancelBtn",true);
    },
    onCompDocFormChange : function (component, event, helper) {
        component.set("v.CompleteDocumentationFormEditMode", false);
        component.set("v.showSaveCancelBtn",true);
    },
     onDressUndressChange : function (component, event, helper) {
        component.set("v.DressingUndressingEditMode", false);
         component.set("v.showSaveCancelBtn",true);
    },
    onhelpmanageChange : function (component, event, helper) {
        component.set("v.managehallEditMode", false);
        component.set("v.showSaveCancelBtn",true);
    },
    onsafehomeChange : function (component, event, helper) {
        component.set("v.homsafeEditMode", false);
        component.set("v.showSaveCancelBtn",true);
    },
    inlineEditcontract : function(component,event,helper){  
        component.set("v.washEditMode", true);
                 component.find("acccontract").set("v.options" , component.get("v.washPicklistOpts"));

        setTimeout(function(){
            component.find("acccontract").focus();
        }, 100);
    },
    inlineEditAvoidingBurnout : function(component,event,helper){  
        component.set("v.AvoidingBurnoutEditMode", true);
                 component.find("burnout").set("v.options" , component.get("v.AvoidingBurnoutvals"));

        setTimeout(function(){
            component.find("burnout").focus();
        }, 100);
    },
inlineEditCompleteDocumentationForm : function(component,event,helper){  
        component.set("v.CompleteDocumentationFormEditMode", true);
                 component.find("compdocout").set("v.options" , component.get("v.CompleteDocumentationFormvals"));

        setTimeout(function(){
            component.find("compdocout").focus();
        }, 100);
    },
inlineEditdressingUundressing : function(component,event,helper){  
        component.set("v.DressingUndressingEditMode", true);
                 component.find("dress").set("v.options" , component.get("v.DressingUndressingvals"));

        setTimeout(function(){
            component.find("dress").focus();
        }, 100);
    },
inlineEdithelpmanage : function(component,event,helper){  
        component.set("v.managehallEditMode", true);
                 component.find("helpmanage").set("v.options" , component.get("v.managehallvals"));

        setTimeout(function(){
            component.find("helpmanage").focus();
        }, 100);
    },
inlineEdithomsafe : function(component,event,helper){  
        component.set("v.homsafeEditMode", true);
                 component.find("homesafe").set("v.options" , component.get("v.homsafvals"));

        setTimeout(function(){
            component.find("homesafe").focus();
        }, 100);
    }
    
    
})