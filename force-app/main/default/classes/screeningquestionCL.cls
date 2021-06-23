public class screeningquestionCL {
    
    public string selectedOp {set;get;}
    public string selectedOp1 {set;get;}
    public string selectedOp2 {set;get;}
    public string selectedOp3 {set;get;}
    public string selectedOp4 {set;get;}
    public string selectedOp5 {set;get;}
    
     public boolean disablevalue {set;get;}
    
    
    public contact acct;
     public date birthdate {set;get;}
    public String selectedRT{get;set;} // selected value of selectList
     public boolean pb2Rendered{get;set;} // true -> show pb2
    public boolean pb3Rendered{get;set;}
     public boolean pb4Rendered{get;set;} // true -> show pb3
    public string ch {set;get;}
    public string radiovalue {set;get;}
    
    public screeningquestionCL(ApexPages.StandardController stdController) {
      this.acct = (contact)stdController.getRecord();
        disablevalue = false;
        system.debug('sasfsfds'+selectedOp);
        acct = [select Id,Question__c,AfterSubmit__c,BackendCheck1__c,Birthdate,Question1__c,Question2__c,Question3__c,Question4__c,Question5__c from contact where Id=:acct.Id];
        selectedOp= acct.Question__c;
        selectedOp1= acct.Question1__c;
        selectedOp2= acct.Question2__c;
        selectedOp3= acct.Question3__c;
        selectedOp4= acct.Question4__c;
        selectedOp5= acct.Question5__c;
        system.debug('sasfsfds'+selectedOp);
         disablevalue = acct.AfterSubmit__c;
        pb2Rendered=true;
       pb3Rendered = pb4Rendered =false;
        selectedRT='';
        //return null;
    }
    
   
     public PageReference step1() {
      return Page.ScreeningQuestions;
   }
    
    public pagereference updatecon(){
       
        integer noofY =0;
        integer noofN = 0;
        
        if(selectedOp =='Yes')
            noofY =noofY+1;
        else
            noofN =noofN+1;
         
         if(selectedOp1 =='Yes')
            noofY =noofY+1;
        else
            noofN =noofN+1;
        
         if(selectedOp2 =='Yes')
            noofY =noofY+1;
        else
            noofN =noofN+1;
        
         if(selectedOp3 =='Yes')
            noofY =noofY+1;
        else
            noofN =noofN+1;
        
        if(selectedOp4 =='Yes')
            noofY =noofY+1;
        else
            noofN =noofN+1;
        
        if(selectedOp5 =='Yes')
            noofY =noofY+1;
        else
            noofN =noofN+1;
        
        
        
       acct.Number_of_No__c = noofN;
       acct.Number_of_yes__c=  noofY;
       if(acct.BackendCheck1__c == false)
       {
           acct.Screening_Question_Submitted_Date__c=system.today();
           acct.BackendCheck1__c=true;
       }
         acct.AfterSubmit__c= true;
        acct.Question__c = selectedOp;
        acct.Question1__c = selectedOp1;
        acct.Question2__c = selectedOp2;
        acct.Question3__c = selectedOp3;
        acct.Question4__c = selectedOp4;
        acct.Question5__c = selectedOp5;
        acct.SQCheck__c=true;
        system.debug('va'+acct.Number_of_No__c);
        update acct;
        
        acct = [select Id,AfterSubmit__c from contact where Id=:acct.Id];
        disablevalue = acct.AfterSubmit__c;
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
   
}