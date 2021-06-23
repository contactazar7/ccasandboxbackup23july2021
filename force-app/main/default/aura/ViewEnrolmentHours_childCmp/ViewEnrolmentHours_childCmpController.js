({
    doInit : function(component, event, helper) {
        helper.setupTable(component);
        //console.log('show this when child component called handler init');
    },
    
    filtermethod:function(component, event, helper){
        var params = event.getParam('arguments');
        //console.log('params=='+params);
        //console.log('params JSON=='+JSON.parse(JSON.stringify(params)));
        if(params){
            var fdata = params.filterdatas;
            //console.log('fdata=='+fdata);
            //console.log('fdata JSON=='+JSON.parse(JSON.stringify(params)));
            helper.setupData(component, fdata);
        }
    },
    sortTable : function(component, event, helper) {
        component.set("v.isLoading", true);
        setTimeout(function(){
            var childObj = event.target;
            var parObj = childObj.parentNode;
            while(parObj.tagName != 'TH') {
                parObj = parObj.parentNode;
            }
            var sortBy = parObj.name, //event.getSource().get("v.name"),
                sortDirection = component.get("v.sortDirection"),
                sortDirection = sortDirection === "asc" ? "desc" : "asc"; //change the direction for next time
            
            component.set("v.sortBy", sortBy);
            component.set("v.sortDirection", sortDirection);
            helper.sortData(component, sortBy, sortDirection);
            component.set("v.isLoading", false);
        }, 0);
    },
    
    calculateWidth : function(component, event, helper) {
        var childObj = event.target;
        var parObj = childObj.parentNode;
        var startOffset = parObj.offsetWidth - event.pageX;
        component.set("v.startOffset", startOffset);
    },
    
    setNewWidth : function(component, event, helper) {
        var childObj = event.target;
        var parObj = childObj.parentNode;
        while(parObj.tagName != 'TH') {
            parObj = parObj.parentNode;
        }
        var startOffset = component.get("v.startOffset");
        var newWidth = startOffset + event.pageX;
        parObj.style.width = newWidth+'px';
    },
    
    editField : function(component, event, helper) {
        var field = event.getSource(),
            indexes = field.get("v.name"),
            rowIndex = indexes.split('-')[0],
            colIndex = indexes.split('-')[1];
        
        var data = component.get("v.tableData");
        data[rowIndex].fields[colIndex].mode = 'edit';
        data[rowIndex].fields[colIndex].tdClassName = 'slds-cell-edit slds-is-edited';
        component.set("v.tableData", data);        
        component.set("v.isEditModeOn", true);
        //console.log('v.tableData=='+data);
    },
    
    onInputChange : function(component, event, helper){
        var field = event.getSource(),
            value = field.get("v.value"),
            indexes = field.get("v.name"),
            rowIndex = indexes.split('-')[0],
            colIndex = indexes.split('-')[1];
        
        helper.updateTable(component, rowIndex, colIndex, value);
        /**console.log('field='+field);
        console.log('value='+value);
        console.log('indexes='+indexes);
        console.log('rowIndex='+rowIndex);
        console.log('colIndex='+colIndex);**/
    },
    
    onRowAction : function(component, event, helper){
        var actionEvent = component.getEvent("dataTableRowActionEvent"),
            indexes = event.target.id, //rowIndex-colIndex-actionName
            params = indexes.split('-'),
            data = component.get("v.dataCache");
        //console.log('indexes='+indexes); 
        //console.log('data='+data); 
        actionEvent.setParams({
            actionName: params[2],
            rowData: data[params[0]]
        });
        actionEvent.fire();
    },
    
    closeEditMode : function(component, event, helper){
        component.set("v.buttonsDisabled", true);
        component.set("v.buttonClicked", "Cancel");
        component.set("v.isLoading", true);
        setTimeout(function(){
            var dataCache = component.get("v.dataCache");
            var originalData = component.get("v.tableDataOriginal");
            component.set("v.data", JSON.parse(JSON.stringify(dataCache)));
            component.set("v.tableData", JSON.parse(JSON.stringify(originalData)));
            component.set("v.isEditModeOn", false);
            component.set("v.isLoading", false);
            component.set("v.error", "");
            component.set("v.buttonsDisabled", false);
            component.set("v.buttonClicked", "");
        }, 0);
    },
    
    saveRecords : function(component, event, helper){
        component.set("v.buttonsDisabled", true);
        component.set("v.buttonClicked", "Save");
        component.set("v.isLoading", true);
        setTimeout(function(){
            var saveEvent = component.getEvent("dataTableSaveEvent");
            //console.log('show this when child component called saveEvent ='+saveEvent);
            saveEvent.setParams({
                tableAuraId: component.get("v.auraId"),
                recordsString: JSON.stringify(component.get("v.modifiedRecords"))
                
            });
            //console.log('show this when child component called saveEvent ='+saveEvent);
            saveEvent.fire();
        }, 0);
    },
    
    finishSaving : function(component, event, helper){
        var params = event.getParam('arguments');
        //console.log('params of event=='+params);
        
        if(params){
            var result = params.result, //Valid values are "SUCCESS" or "ERROR"
                data = params.data, //refreshed data from server
                message = params.message;
            /**
            console.log('params of event result=='+result);
            console.log('params of event data=='+data);
            console.log('params of event message=='+message);**/
            
            if(result === "SUCCESS"){//success
                if(data){
                    helper.setupData(component, data);
                }else{
                    var dataCache = component.get("v.dataCache"),
                        updatedData = component.get("v.updatedTableData");
                    component.set("v.data", JSON.parse(JSON.stringify(dataCache)));
                    component.set("v.tableDataOriginal", JSON.parse(JSON.stringify(updatedData)));
                    component.set("v.tableData", JSON.parse(JSON.stringify(updatedData)));                    
                }
                component.set("v.isEditModeOn", false);
            }else{
                if(message) component.set("v.error", message);
            }
        }
        component.set("v.isLoading", false);
        component.set("v.buttonsDisabled", false);
        component.set("v.buttonClicked", "");
    }    
})