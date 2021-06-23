public class AD8FormController {

    public string selectedOp {set;get;}
    public string selectedOp1 {set;get;}
    public string selectedOp2 {set;get;}
    public string selectedOp3 {set;get;}
    public string selectedOp4 {set;get;}
    public string selectedOp5 {set;get;}
    public string selectedOp6 {set;get;}
    public string selectedOp7 {set;get;}
    
     public string conval {set;get;}
    
    public contact acct;
     public contact acct1;
    public Provider_Consumer_Affiliation__c PCA;
     public boolean disablevalue {set;get;}
    public String selectedRT{get;set;}
    public boolean pb2Rendered{get;set;} // true -> show pb2
    public boolean pb3Rendered{get;set;}
     public boolean pb4Rendered{get;set;}
     public AD8FormController(ApexPages.StandardController stdController) {
      this.acct = (contact)stdController.getRecord();
         disablevalue = false;
       acct = [select Id,QuestionAD__c,After_Submit_AD__c,ConsumerName__c,BackendCheck2__c,Birthdate,QuestionAD1__c,QuestionAD2__c,QuestionAD3__c,QuestionAD4__c,QuestionAD5__c,QuestionAD6__c,QuestionAD7__c from contact where Id=:acct.Id];
       acct1 = [select Id,QuestionAD__c,After_Submit_AD__c,ConsumerName__c,Birthdate,QuestionAD1__c,QuestionAD2__c,(select id,name,Provider__c,Affiliation_Status__c From Provider_Consumer_Affiliations__r where Affiliation_Status__c='Current'),QuestionAD3__c,QuestionAD4__c,QuestionAD5__c,QuestionAD6__c,QuestionAD7__c from contact where Id=:acct.Id];
         if(acct1.Provider_Consumer_Affiliations__r.size()>0 && acct.ConsumerName__c==null)
         {
           PCA =[select id,name,Provider__c,Home_Care_Consumer__r.name,Affiliation_Status__c From Provider_Consumer_Affiliation__c where Provider__c =:acct.Id AND Affiliation_Status__c='Current' LIMIT 1];
           conval=PCA.Home_Care_Consumer__r.name;
         } 
         if(acct.ConsumerName__c!=null)
         {
            conval=acct.ConsumerName__c; 
         }
             
         system.debug('name is'+acct.ConsumerName__c);
         selectedOp= acct.QuestionAD__c;
        selectedOp1= acct.QuestionAD1__c;
        selectedOp2= acct.QuestionAD2__c;
        selectedOp3= acct.QuestionAD3__c;
        selectedOp4= acct.QuestionAD4__c;
        selectedOp5= acct.QuestionAD5__c;
        selectedOp6= acct.QuestionAD6__c;
        selectedOp7= acct.QuestionAD7__c;
         disablevalue = acct.After_Submit_AD__c;
         pb2Rendered=true;
       pb3Rendered = pb4Rendered =false;
        selectedRT='';
     }
    
    
     public pagereference updatecon(){
         
         integer noofY =0;
        integer noofN = 0;
        integer noofNAP=0;
         
         if(selectedOp =='Yes')
            noofY =noofY+1;
        else if(selectedOp=='No')
            noofN =noofN+1;
         else
             noofNAP=noofNAP+1;
         
        if(selectedOp1 =='Yes')
            noofY =noofY+1;
        else if(selectedOp1=='No')
            noofN =noofN+1;
         else
             noofNAP=noofNAP+1;
         
         if(selectedOp2 =='Yes')
            noofY =noofY+1;
        else if(selectedOp2=='No')
            noofN =noofN+1;
         else
             noofNAP=noofNAP+1;
         
         if(selectedOp3 =='Yes')
            noofY =noofY+1;
        else if(selectedOp3=='No')
            noofN =noofN+1;
         else
             noofNAP=noofNAP+1;
         
         if(selectedOp4 =='Yes')
            noofY =noofY+1;
        else if(selectedOp4=='No')
            noofN =noofN+1;
         else
             noofNAP=noofNAP+1;
         
         if(selectedOp5 =='Yes')
            noofY =noofY+1;
        else if(selectedOp5=='No')
            noofN =noofN+1;
         else
             noofNAP=noofNAP+1;
         
         if(selectedOp6 =='Yes')
            noofY =noofY+1;
        else if(selectedOp6=='No')
            noofN =noofN+1;
         else
             noofNAP=noofNAP+1;
         
         if(selectedOp7 =='Yes')
            noofY =noofY+1;
        else if(selectedOp7=='No')
            noofN =noofN+1;
         else
             noofNAP=noofNAP+1;
         
         acct.AD_Total_Yes__c=noofY;
         acct.AD_Total_No__c=noofN;
         acct.AD_Total_NAP__c=noofNAP;
         acct.After_Submit_AD__c= true;
         
         if(acct.BackendCheck2__c==false)
         {
             acct.AD8_Form_Submitted_Date__c=system.today();
             acct.BackendCheck2__c=true;
         }
         
       system.debug('value'+acct.AD_Total_Yes__c);
        acct.QuestionAD__c = selectedOp;
        acct.QuestionAD1__c = selectedOp1;
        acct.QuestionAD2__c = selectedOp2;
        acct.QuestionAD3__c = selectedOp3;
        acct.QuestionAD4__c = selectedOp4;
        acct.QuestionAD5__c = selectedOp5;
        acct.QuestionAD6__c = selectedOp6;
        acct.QuestionAD7__c = selectedOp7;
         acct.AD8Check__c=true;
        acct.ConsumerName__c=conval;
         update acct;
         system.debug('value'+acct.ConsumerName__c);
         
        acct = [select Id,After_Submit_AD__c from contact where Id=:acct.Id];
        disablevalue = acct.After_Submit_AD__c;
         
       return null;         
         
       }
    
    
     public void onChangeFnCall(){
            
          if(selectedRT=='abc'){
            pb2Rendered = true;
            pb3Rendered = false;
           pb4Rendered = false;
        }
        else if(selectedRT=='def'){
             pb3Rendered = true;
            pb2Rendered = false;
            pb4Rendered = false;
        }
            else if(selectedRT=='ghi'){
            pb2Rendered = false;
            pb3Rendered = false;
            pb4Rendered = true;
        }
            
        else{
           pb2Rendered = true;
            pb3Rendered = false;
           pb4Rendered = false;
        }
     }
        
     public void onChangeFnCall1(){
          if(selectedOp=='Yes'){
              selectedOp ='Yes';
               }
          if(selectedOp=='No'){
              selectedOp ='No';
               }
     }
     public void onChangeFnCall2(){
          if(selectedOp1=='Yes'){
              selectedOp1 ='Yes';
               }
          if(selectedOp1=='No'){
              selectedOp1 ='No';
               }
     }
     public void onChangeFnCall3(){
          if(selectedOp2=='Yes'){
              selectedOp2 ='Yes';
               }
          if(selectedOp2=='No'){
              selectedOp2 ='No';
               }
     }
    public void onChangeFnCall4(){
          if(selectedOp3=='Yes'){
              selectedOp3 ='Yes';
               }
          if(selectedOp3=='No'){
              selectedOp3 ='No';
               }
     }
    public void onChangeFnCall5(){
          if(selectedOp4=='Yes'){
              selectedOp4='Yes';
               }
          if(selectedOp4=='No'){
              selectedOp4 ='No';
               }
     }
    public void onChangeFnCall6(){
          if(selectedOp5=='Yes'){
              selectedOp5 ='Yes';
               }
          if(selectedOp5=='No'){
              selectedOp5 ='No';
               }
     }
    public void onChangeFnCall7(){
          if(selectedOp6=='Yes'){
              selectedOp6 ='Yes';
               }
          if(selectedOp6=='No'){
              selectedOp6 ='No';
               }
     }
    public void onChangeFnCall8(){
          if(selectedOp7=='Yes'){
              selectedOp7 ='Yes';
               }
          if(selectedOp7=='No'){
              selectedOp7 ='No';
               }
     }
}