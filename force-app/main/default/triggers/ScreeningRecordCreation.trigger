trigger ScreeningRecordCreation on Contact (before update,After update) {

    
    list<Screening_Question__c> sclist=new list<Screening_Question__c>();
     list<Screening_Question__c> sclist1=new list<Screening_Question__c>();
    list<AD8_Form__c> ADlist=new list<AD8_Form__c>();
    list<AD8_Form__c> ADlist1=new list<AD8_Form__c>();
    
    
    if(trigger.isBefore)
    {
        for(Contact cn1:Trigger.new)
        {
           if(cn1.Participation_form_submitted__c==true && cn1.BackendCheck3__c==false)
        {
            cn1.PPF_Submitted_Date__c=system.today();
            cn1.BackendCheck3__c=true;
        } 
        }
        
    }
    
    if(trigger.isAfter)
    {
        for(Contact cc:Trigger.new)
    {
          system.debug(cc.Number_of_yes__c);
         system.debug(Trigger.oldmap.get(cc.id).Number_of_yes__c);
        if(cc.Number_of_yes__c != Trigger.oldmap.get(cc.id).Number_of_yes__c)
        {
        Screening_Question__c sc= new Screening_Question__c();
        sc.Provider__c=cc.id;
        sc.Total_of_Yes__c=cc.Number_of_yes__c;
        sc.Total_of_No__c=cc.Number_of_No__c;
        sc.Total_of_Questions__c=7;
        sclist.add(sc);
        }
       
    }
    if(sclist.size()>0)
    {
        system.debug('inserted');
       insert sclist;
    }
    
      for(Screening_Question__c sc1:[select id,name,Provider__c,Provider_DOB__c from Screening_Question__c where Provider__c IN : Trigger.new])
    {
         for(Contact c1:Trigger.new)
    {
        if(c1.Birthdate != Trigger.oldmap.get(c1.id).Birthdate)
        {
             system.debug('dsgkjagfjsahfjkhalfkj');
             sc1.Provider_DOB__c=c1.Birthdate;   
             sclist1.add(sc1);
        }
    }
    }
     update sclist1;
    
    for(Contact cc1:Trigger.new)
    {
         system.debug(cc1.AD_Total_Yes__c);
         system.debug(Trigger.oldmap.get(cc1.id).AD_Total_Yes__c);
        if(cc1.AD_Total_Yes__c != Trigger.oldmap.get(cc1.id).AD_Total_Yes__c)
        {
        AD8_Form__c ad= new AD8_Form__c();
        ad.Provider__c=cc1.id;
        ad.Total_of_Yes__c=cc1.AD_Total_Yes__c;
        ad.Total_of_No__c=cc1.AD_Total_No__c;
        ad.Total_of_Not_Applicable__c=cc1.AD_Total_NAP__c;
        ad.Total_of_Questions__c=8;
        ADlist.add(ad);
            system.debug('dsgkjagfjsahfjkhalfkj');
        }
   
    }
     if(ADlist.size()>0)
    {
       insert ADlist;
    }
    for(AD8_Form__c AD:[select id,name,Provider__c from AD8_Form__c where Provider__c IN : Trigger.new])
    {
         for(Contact cc2:Trigger.new)
    {
        if(cc2.ConsumerName__c != Trigger.oldmap.get(cc2.id).ConsumerName__c)
        {
             system.debug('dsgkjagfjsahfjkhalfkj');
             AD.Consumer_Name__c=cc2.ConsumerName__c;   
             ADlist1.add(AD);
        }
    }
    }
     update ADlist1;
    }
    
}