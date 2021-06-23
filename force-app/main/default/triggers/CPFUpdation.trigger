trigger CPFUpdation on Consumer__c (after insert,after update) {

    list<Contact> conlist=new list<Contact>();
    set<id> provID=new set<id>();
    list<Consumer__c> lstcons=[select id,name,(select id,name,Provider__c,Home_Care_Consumer__c from Provider_Consumer_Affiliations__r),Calls_Allowed__c from Consumer__c where id IN : Trigger.new];
    for(Consumer__c cc:lstcons)
    {
       for(Provider_Consumer_Affiliation__c p:cc.Provider_Consumer_Affiliations__r)
       {
           provID.add(p.Provider__c);
       }
    }
    
    for(Consumer__c c:Trigger.new)
    {
        for(Contact con:[select id,BackendCheck__c,Consumer_Participation_form_submitted__c,CPF_Submitted_Date__c from Contact where id IN :provID])
        {
            if(c.Consumer_Participation_form_submitted__c==true && con.BackendCheck__c==false)
            {
                con.Consumer_Participation_form_submitted__c=true;
                con.CPF_Submitted_Date__c=system.today();
                con.BackendCheck__c=true;
                conlist.add(con);
            }
        }
    }
    update conlist;
}