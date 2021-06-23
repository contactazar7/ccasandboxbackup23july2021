trigger QuaterCalucationTrigger on SFDC_Class__c (before insert , before update,after insert, after update,after delete) {
    
    User current_user=[SELECT Email,Name FROM User WHERE Id= :UserInfo.getUserId()] ;

    
    String qua ='';
    if((trigger.isInsert || trigger.isUpdate) && (trigger.isBefore )){
        for(SFDC_Class__c sf :trigger.new){ 
            
            if(sf.Start_Date__c.month() >= 0 && sf.End_Date__c.month()  <= 3) {
                sf.Quarter__c='Q1 - Jan - Mar';
                qua = 'Q1 - Jan - Mar';
            }
            else if(sf.Start_Date__c.month() >= 4 && sf.End_Date__c.month()  <= 6){
                
                sf.Quarter__c='Q2 - Apr - Jun';
                qua = 'Q2 - Apr - Jun';
            } else if(sf.Start_Date__c.month() >= 7 && sf.End_Date__c.month()  <= 9){
                
                sf.Quarter__c='Q3 - Jul - Sep';
                qua = 'Q3 - Jul - Sep';
            }
            else if(sf.Start_Date__c.month() >= 10 && sf.End_Date__c.month()  <= 12){
                
                sf.Quarter__c='Q4 - Oct - Dec';
                qua = 'Q4 - Oct - Dec';
                
            }
             if(trigger.isInsert  && trigger.isBefore ){
                if(sf.Instructor_ID__c!=null){
            sf.Instructor_1_Assigned_By__c = current_user.Name;
                sf.Instructor_1_Assigned_On__c =system.today();
                }
                 if(sf.Instructor_ID_2__c!=null){
                sf.Instructor_2_Assigned_By__c = current_user.Name;
                sf.Instructor_2_Assigned_On__c =system.today();
                 }
            }
             if(trigger.isUpdate  && trigger.isBefore ){
                if(sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c){
            sf.Instructor_1_Assigned_By__c = current_user.Name;
                    sf.Instructor_1_Assigned_On__c =system.today();
                }
                if(sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c){
             sf.Instructor_2_Assigned_By__c = current_user.Name;
                sf.Instructor_2_Assigned_On__c =system.today();
                }
            } 
        } 
    }
    
    set<Id> Instructorid1 = new set<Id>();
    set<Id> Instructorid2 = new set<Id>();
     set<Id> Instructorids1 = new set<Id>();
    set<Id> Instructorids2 = new set<Id>();
    string qua1='';
    
    set<Id> updateInstructorid3 = new set<Id>();
    set<Id> updateInstructorid4 = new set<Id>();
    string qua2='';
   
    if((trigger.isInsert) && trigger.isAfter ){
        for(SFDC_Class__c sf:trigger.new){
            if(sf.Instructor_ID__c !=null){
                Instructorid1.add(sf.Instructor_ID__c);
                Instructorid2.add(sf.Instructor_ID_2__c);
                qua1 =sf.Quarter__c;
                
            }
        }
       /* if(trigger.isUpdate && trigger.isAfter ){
         for(SFDC_Class__c sf:trigger.new){
            if(sf.Quarter__c!=trigger.oldMap.get(sf.Id).Quarter__c){
                updateInstructorid3.add(sf.Instructor_ID__c);
                updateInstructorid4.add(sf.Instructor_ID_2__c);
                qua2 =sf.Quarter__c;
                
            }
        }*/
    
        
        
        
    
    
  
    List<Instructor__c> instcount1 =[select id,Name,Classes_assigned_in_Q1__c,Classes_assigned_in_Q2__c,Classes_assigned_in_Q3__c,Classes_assigned_in_Q4__c,(select id,Name,Instructor_ID_2__c,Instructor_ID__c,Quarter__c,Class_Status__c from Classes__r where Quarter__c = :qua1 and Instructor_ID__c =: Instructorid1 and (Class_Status__c ='Upcoming' or Class_Status__c ='Ongoing')) from Instructor__c where Id = :Instructorid1];
         system.debug('call'+instcount1);
   
      
               List<Instructor__c> instcount2 =[select id,Name,Classes_assigned_in_Q1__c,Classes_assigned_in_Q2__c,Classes_assigned_in_Q3__c,Classes_assigned_in_Q4__c,(select id,Name,Instructor_ID_2__c,Instructor_ID__c,Quarter__c,Class_Status__c from Classes__r where Quarter__c = :qua1 and Instructor_ID_2__c =: Instructorid2 and (Class_Status__c ='Upcoming' or Class_Status__c ='Ongoing')) from Instructor__c where Id = :Instructorid2];
  system.debug('sss'+instcount1);
         system.debug('sss'+instcount2);
    List<Instructor__c> listinst = new List<Instructor__c>();
    List<Instructor__c> listinsttruc3 = new List<Instructor__c>();

   for(Instructor__c a:instcount1){
        
        if(qua1 == 'Q1 - Jan - Mar'){
            system.debug('call');
            a.Classes_assigned_in_Q1__c =  a.Classes_assigned_in_Q1__c+1;
            listinst.add(a);
        }else if(qua1 == 'Q2 - Apr - Jun'){
            system.debug('call1');
            a.Classes_assigned_in_Q2__c =  a.Classes_assigned_in_Q2__c+1;
            listinst.add(a); 
        }
        else if(qua1 == 'Q3 - Jul - Sep'){
            system.debug('call2');
            a.Classes_assigned_in_Q3__c = a.Classes_assigned_in_Q3__c+1;
            listinst.add(a); 
            
        }
        else if(qua1 == 'Q4 - Oct - Dec'){
            system.debug('call3');
            a.Classes_assigned_in_Q4__c =  a.Classes_assigned_in_Q4__c+1;
            listinst.add(a); 
        }
        }

    
  for(Instructor__c a:instcount2){
       system.debug('callfirst'+instcount2.size());
        if(qua1 == 'Q1 - Jan - Mar'){
          a.Classes_assigned_in_Q1__c = a.Classes_assigned_in_Q1__c+1;
            listinsttruc3.add(a);
        }
      else if(qua1 == 'Q2 - Apr - Jun'){
            a.Classes_assigned_in_Q2__c =     a.Classes_assigned_in_Q2__c+1;
            listinsttruc3.add(a); 
        }
        else if(qua1 == 'Q3 - Jul - Sep'){
            system.debug('call2');
            a.Classes_assigned_in_Q3__c =   a.Classes_assigned_in_Q3__c+1;
            listinsttruc3.add(a); 
            
        }
        else if(qua1 == 'Q4 - Oct - Dec'){
            system.debug('call3');
            a.Classes_assigned_in_Q4__c =   a.Classes_assigned_in_Q4__c+1;
            listinsttruc3.add(a); 
        }
        
    }
    
   if(!listinst.isEmpty()){
   
   update listinsttruc3;
        update listinst;

}
           
   
    }  
    
    if((trigger.Isupdate) && trigger.isAfter ){
        for(SFDC_Class__c sf:trigger.new){
            if(((sf.Quarter__c!=null && sf.Quarter__c!=trigger.oldmap.get(sf.id).Quarter__c) && (sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c)) && (sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c)){
               updateInstructorid3.add(trigger.oldmap.get(sf.id).Instructor_ID__c);
                updateInstructorid4.add(trigger.oldmap.get(sf.id).Instructor_ID_2__c);
                qua1 =trigger.oldmap.get(sf.id).Quarter__c;
               
            }
            else if((sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c) && (sf.Quarter__c!=null && sf.Quarter__c!=trigger.oldmap.get(sf.id).Quarter__c))
            {
                updateInstructorid3.add(trigger.oldmap.get(sf.id).Instructor_ID__c);
                updateInstructorid4.add(sf.Instructor_ID_2__c);
                qua1 =trigger.oldmap.get(sf.id).Quarter__c;
               
            }
            else if((sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c) && (sf.Quarter__c!=null && sf.Quarter__c!=trigger.oldmap.get(sf.id).Quarter__c)){
                 updateInstructorid3.add(sf.Instructor_ID__c);
                 updateInstructorid4.add(trigger.oldmap.get(sf.id).Instructor_ID_2__c);
                 qua1 =trigger.oldmap.get(sf.id).Quarter__c;
               
            }
             else if((sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c) && (sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c)){
                     updateInstructorid3.add(trigger.oldmap.get(sf.id).Instructor_ID__c);
                 updateInstructorid4.add(trigger.oldmap.get(sf.id).Instructor_ID_2__c);
                 qua1 =trigger.oldmap.get(sf.id).Quarter__c;
               
            }else if(sf.Quarter__c!=null && sf.Quarter__c!=trigger.oldmap.get(sf.id).Quarter__c){
                 updateInstructorid3.add(sf.Instructor_ID__c);
                updateInstructorid4.add(sf.Instructor_ID_2__c);
                qua1 =trigger.oldmap.get(sf.id).Quarter__c;
               
            }
            else if((sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c)) {
                 updateInstructorid3.add(sf.Instructor_ID__c);
                 updateInstructorid4.add(trigger.oldmap.get(sf.id).Instructor_ID_2__c);
                qua1 =sf.Quarter__c;
               
            }
            else if((sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c)) {
                 updateInstructorid3.add(trigger.oldmap.get(sf.id).Instructor_ID__c);
                updateInstructorid4.add(sf.Instructor_ID_2__c);
                qua1 =sf.Quarter__c;
               
            }
        }
       system.debug('sss'+Instructorid1);
         system.debug('sss'+Instructorid2);
         system.debug('sss'+qua1);
        
               List<Instructor__c> instcount1 =[select id,Name,Classes_assigned_in_Q1__c,Classes_assigned_in_Q2__c,Classes_assigned_in_Q3__c,Classes_assigned_in_Q4__c,(select id,Name,Instructor_ID_2__c,Instructor_ID__c,Quarter__c,Class_Status__c from Classes__r where Quarter__c = :qua1 and Instructor_ID__c =: updateInstructorid3 and (Class_Status__c ='Upcoming' or Class_Status__c ='Ongoing')) from Instructor__c where Id = :updateInstructorid3];
         system.debug('call'+instcount1);
   
      
               List<Instructor__c> instcount2 =[select id,Name,Classes_assigned_in_Q1__c,Classes_assigned_in_Q2__c,Classes_assigned_in_Q3__c,Classes_assigned_in_Q4__c,(select id,Name,Instructor_ID_2__c,Instructor_ID__c,Quarter__c,Class_Status__c from Classes__r where Quarter__c = :qua1 and Instructor_ID_2__c =: updateInstructorid4 and (Class_Status__c ='Upcoming' or Class_Status__c ='Ongoing')) from Instructor__c where Id = :updateInstructorid4];
  system.debug('sss'+instcount1);
         system.debug('sss'+instcount2);
        

    List<Instructor__c> listinst = new List<Instructor__c>();
    List<Instructor__c> listinsttruc3 = new List<Instructor__c>();

    
    for(Instructor__c a:instcount1){
        
        if(qua1 == 'Q1 - Jan - Mar'){
            system.debug('call');
            a.Classes_assigned_in_Q1__c =  a.Classes_assigned_in_Q1__c-1;
            listinst.add(a);
        }else if(qua1 == 'Q2 - Apr - Jun'){
            system.debug('call1');
            a.Classes_assigned_in_Q2__c =  a.Classes_assigned_in_Q2__c-1;
            listinst.add(a); 
        }
        else if(qua1 == 'Q3 - Jul - Sep'){
            system.debug('call2');
            a.Classes_assigned_in_Q3__c = a.Classes_assigned_in_Q3__c-1;
            listinst.add(a); 
            
        }
        else if(qua1 == 'Q4 - Oct - Dec'){
            system.debug('call3');
            a.Classes_assigned_in_Q4__c =  a.Classes_assigned_in_Q4__c-1;
            listinst.add(a); 
        }
        }

    
  for(Instructor__c a:instcount2){
       system.debug('callfirst'+instcount2.size());
        if(qua1 == 'Q1 - Jan - Mar'){
          a.Classes_assigned_in_Q1__c = a.Classes_assigned_in_Q1__c-1;
            listinsttruc3.add(a);
        }
      else if(qua1 == 'Q2 - Apr - Jun'){
            a.Classes_assigned_in_Q2__c =     a.Classes_assigned_in_Q2__c-1;
            listinsttruc3.add(a); 
        }
        else if(qua1 == 'Q3 - Jul - Sep'){
            system.debug('call2');
            a.Classes_assigned_in_Q3__c =   a.Classes_assigned_in_Q3__c-1;
            listinsttruc3.add(a); 
            
        }
        else if(qua1 == 'Q4 - Oct - Dec'){
            system.debug('call3');
            a.Classes_assigned_in_Q4__c =   a.Classes_assigned_in_Q4__c-1;
            listinsttruc3.add(a); 
        }
        
    }
    
   if(!listinst.isEmpty()){
   
   update listinsttruc3;
        update listinst;

}
           
    } 
           
       if((trigger.Isupdate) && trigger.isAfter ){

        for(SFDC_Class__c sf:trigger.new){
              if(((sf.Quarter__c!=null && sf.Quarter__c!=trigger.oldmap.get(sf.id).Quarter__c) && (sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c)) && (sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c)){
               Instructorids1.add(trigger.newmap.get(sf.id).Instructor_ID__c);
                Instructorids2.add(trigger.newmap.get(sf.id).Instructor_ID_2__c);
                qua1 =trigger.newmap.get(sf.id).Quarter__c;
               
            }
            else if((sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c) && (sf.Quarter__c!=null && sf.Quarter__c!=trigger.oldmap.get(sf.id).Quarter__c))
            {
                Instructorids1.add(trigger.newmap.get(sf.id).Instructor_ID__c);
                Instructorids2.add(sf.Instructor_ID_2__c);
                qua1 =trigger.newmap.get(sf.id).Quarter__c;
               
            }
            else if((sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c) && (sf.Quarter__c!=null && sf.Quarter__c!=trigger.oldmap.get(sf.id).Quarter__c)){
                 Instructorids1.add(sf.Instructor_ID__c);
                 Instructorids2.add(trigger.newmap.get(sf.id).Instructor_ID_2__c);
                 qua1 =trigger.newmap.get(sf.id).Quarter__c;
               
            }
             else if((sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c) && (sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c)){
                     Instructorids1.add(trigger.newmap.get(sf.id).Instructor_ID__c);
                 Instructorids2.add(trigger.newmap.get(sf.id).Instructor_ID_2__c);
                 qua1 =trigger.newmap.get(sf.id).Quarter__c;
               
            }else if(sf.Quarter__c!=null && sf.Quarter__c!=trigger.oldmap.get(sf.id).Quarter__c){
                 Instructorids1.add(sf.Instructor_ID__c);
                Instructorids2.add(sf.Instructor_ID_2__c);
                qua1 =trigger.newmap.get(sf.id).Quarter__c;
               
            }
            else if((sf.Instructor_ID_2__c!=null && sf.Instructor_ID_2__c!=trigger.oldmap.get(sf.id).Instructor_ID_2__c)) {
                 Instructorids1.add(sf.Instructor_ID__c);
                 Instructorids2.add(trigger.newmap.get(sf.id).Instructor_ID_2__c);
                qua1 =sf.Quarter__c;
               
            }
            else if((sf.Instructor_ID__c!=null && sf.Instructor_ID__c!=trigger.oldmap.get(sf.id).Instructor_ID__c)) {
                 Instructorids1.add(trigger.newmap.get(sf.id).Instructor_ID__c);
                Instructorids2.add(sf.Instructor_ID_2__c);
                qua1 =sf.Quarter__c;
               
            }
        }
       
               List<Instructor__c> instcount1 =[select id,Name,Classes_assigned_in_Q1__c,Classes_assigned_in_Q2__c,Classes_assigned_in_Q3__c,Classes_assigned_in_Q4__c,(select id,Name,Instructor_ID_2__c,Instructor_ID__c,Quarter__c,Class_Status__c from Classes__r where Quarter__c = :qua1 and Instructor_ID__c =: Instructorids1 and (Class_Status__c ='Upcoming' or Class_Status__c ='Ongoing')) from Instructor__c where Id = :Instructorids1];
         system.debug('call'+instcount1);
   
      
               List<Instructor__c> instcount2 =[select id,Name,Classes_assigned_in_Q1__c,Classes_assigned_in_Q2__c,Classes_assigned_in_Q3__c,Classes_assigned_in_Q4__c,(select id,Name,Instructor_ID_2__c,Instructor_ID__c,Quarter__c,Class_Status__c from Classes__r where Quarter__c = :qua1 and Instructor_ID_2__c =: Instructorids2 and (Class_Status__c ='Upcoming' or Class_Status__c ='Ongoing')) from Instructor__c where Id = :Instructorids2];
 

    List<Instructor__c> listinst = new List<Instructor__c>();
    List<Instructor__c> listinsttruc3 = new List<Instructor__c>();

    
    for(Instructor__c a:instcount1){
        
        if(qua1 == 'Q1 - Jan - Mar'){
            system.debug('call');
            a.Classes_assigned_in_Q1__c =  a.Classes_assigned_in_Q1__c+1;
            listinst.add(a);
        }else if(qua1 == 'Q2 - Apr - Jun'){
            system.debug('call1');
            a.Classes_assigned_in_Q2__c =  a.Classes_assigned_in_Q2__c+1;
            listinst.add(a); 
        }
        else if(qua1 == 'Q3 - Jul - Sep'){
            system.debug('call2');
            a.Classes_assigned_in_Q3__c = a.Classes_assigned_in_Q3__c+1;
            listinst.add(a); 
            
        }
        else if(qua1 == 'Q4 - Oct - Dec'){
            system.debug('call3');
            a.Classes_assigned_in_Q4__c =  a.Classes_assigned_in_Q4__c+1;
            listinst.add(a); 
        }
        }

    
  for(Instructor__c a:instcount2){
       system.debug('callfirst'+instcount2.size());
        if(qua1 == 'Q1 - Jan - Mar'){
          a.Classes_assigned_in_Q1__c = a.Classes_assigned_in_Q1__c+1;
            listinsttruc3.add(a);
        }
      else if(qua1 == 'Q2 - Apr - Jun'){
            a.Classes_assigned_in_Q2__c =     a.Classes_assigned_in_Q2__c+1;
            listinsttruc3.add(a); 
        }
        else if(qua1 == 'Q3 - Jul - Sep'){
            system.debug('call2');
            a.Classes_assigned_in_Q3__c =   a.Classes_assigned_in_Q3__c+1;
            listinsttruc3.add(a); 
            
        }
        else if(qua1 == 'Q4 - Oct - Dec'){
            system.debug('call3');
            a.Classes_assigned_in_Q4__c =   a.Classes_assigned_in_Q4__c+1;
            listinsttruc3.add(a); 
        }
        
    }
    
   if(!listinst.isEmpty()){
   
   update listinsttruc3;
        update listinst;

}
           
   
           
   
    
    
    }
    
    
}