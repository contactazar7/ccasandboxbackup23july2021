({
    doInit : function(component, event, helper) {
        helper.setupTable(component);
    },
    filtermethod:function(component, event, helper){
        var params = event.getParam('arguments');
        if(params){
            var fdata = params.filterdatas;
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
    },
    
    onInputChange : function(component, event, helper){
        var field = event.getSource(),
            value = field.get("v.value"),
            indexes = field.get("v.name"),
            rowIndex = indexes.split('-')[0],
            colIndex = indexes.split('-')[1];
        
        helper.updateTable(component, rowIndex, colIndex, value);
        
    },
    
    onRowAction : function(component, event, helper){
        var actionEvent = component.getEvent("dataTableRowActionEvent"),
            indexes = event.target.id, //rowIndex-colIndex-actionName
            params = indexes.split('-'),
            data = component.get("v.dataCache");
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
            saveEvent.setParams({
                tableAuraId: component.get("v.auraId"),
                recordsString: JSON.stringify(component.get("v.modifiedRecords"))
                
            });
            saveEvent.fire();
        }, 0);
    },
    
    finishSaving : function(component, event, helper){
        var params = event.getParam('arguments');
        
        if(params){
            var result = params.result, //Valid values are "SUCCESS" or "ERROR"
                data = params.data, //refreshed data from server
                message = params.message;
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
    },
    
    handleSelect : function(component, event, helper){
        var index = event.getSource().get('v.accesskey');
        var checked = event.getSource().get('v.checked');
        var tableData = component.get('v.tableData');
        var selectedRow = tableData[index];
        
        var selectedRecords = component.get('v.selectedRecords');
        
        console.log('Everytime I selectedRow from child ' + selectedRow);
        console.log('Everytime I selectedRecords from child ' + selectedRecords);
        if(selectedRecords.length == 0) {
            if(checked == true) {
                selectedRecords.push(selectedRow);
            }
            
        }
        else {
            selectedRecords.map((sRow,index) => {
                if(checked == true) {
                if(sRow.id !== selectedRow.id) {
                selectedRecords.push(selectedRow);
            }
                                }
                                if(checked == false) {
                if(sRow.id == selectedRow.id) {
                    selectedRecords.splice(index,1);
                }
            }
        });
    }
    
                    component.set('v.selectedRecords',selectedRecords);
                    var cmpEvent = component.getEvent("dataTableSaveEvent"); 
                    cmpEvent.setParams({
                    selectedRecords : selectedRecords
			}); 
					cmpEvent.fire();
		},
    
    handleSelectAll : function(component, event, helper){
        var selectAll = component.find('selectAll').get('v.checked');
        component.set('v.selectedRecords',component.get('v.tableData'));
        if(selectAll == true) {
            if(component.find('selectOne').length > 1) {
                component.find('selectOne').forEach(function(eachRecord) {
                    eachRecord.set('v.checked',true);
                    
                });
            }
            else {
                component.find('selectOne').set('v.checked',true);
            }
            var tableData = component.get('v.tableData');
            var cmpEvent = component.getEvent("dataTableSaveEvent")
            cmpEvent.setParams({
                selectedRecords : tableData
            }); 
            cmpEvent.fire();
        }
        else if(selectAll == false) {
            if(component.find('selectOne').length > 1) {
                component.find('selectOne').forEach(function(eachRecord) {
                    eachRecord.set('v.checked',false);
                    
                });
            }
            else {
                component.find('selectOne').set('v.checked',false);
            }
            var tableData = component.get('v.tableData');
            var cmpEvent = component.getEvent("dataTableSaveEvent")
            cmpEvent.setParams({
                selectedRecords : []
            }); 
            cmpEvent.fire();
        }
    }
})