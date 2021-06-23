trigger AffiliationCountOnProvider on Provider_Consumer_Affiliation__c (after insert,after update) {

    set<ID> pset=new set<ID>();
    for(Provider_Consumer_Affiliation__c pc:Trigger.new)
    {
        pset.add(pc.Provider__c);
    }
    
    list<Provider_Consumer_Affiliation__c> pclist=[select id,name,Provider__c,Affiliation_Status__c from Provider_Consumer_Affiliation__c where Provider__c IN:pset AND Affiliation_Status__c='Current'];
    
    list<Contact> conlist=[select id,Single_ConsAffiliate__c,Multi_ConsAffiliate__c,No_Affiliation__c from Contact where ID IN:pset];
    
    for(Contact cc:conlist)
    {
        if(pclist.size()==0){
            cc.No_Affiliation__c=true;
            cc.Single_ConsAffiliate__c=false;
            cc.Multi_ConsAffiliate__c=false;
        }
        if(pclist.size()==1)
        {
            cc.Single_ConsAffiliate__c=true;
            cc.Multi_ConsAffiliate__c=false;
            cc.No_Affiliation__c=false;
        }
        if(pclist.size()>1)
        {
            cc.Multi_ConsAffiliate__c=true;
            cc.Single_ConsAffiliate__c=false;
            cc.No_Affiliation__c=false;
        }
    }
    update conlist;
}