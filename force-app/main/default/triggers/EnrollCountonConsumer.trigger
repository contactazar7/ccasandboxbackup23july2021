trigger EnrollCountonConsumer on Consumer_Enrollment__c (after insert,after update) {

    set<ID> enID=new set<ID>();
    set<ID> ConsID=new set<ID>();
    for(Consumer_Enrollment__c ce:Trigger.new)
    {
        enID.add(ce.Enrollment__c);
        ConsID.add(ce.Home_Care_Consumer__c);
    }
    
    list<SFDC_Enrollment__c> enlist=[select id,Status__c from SFDC_Enrollment__c where ID IN : enID AND Status__c='Enrolled'];
    
    list<Consumer__c> conslist=[select id,Check_Enrollment__c from Consumer__c where ID IN :ConsID];
    
    for(Consumer__c cn:conslist)
    {
        if(enlist.size()>=1)
        {
            cn.Check_Enrollment__c=true;
        }
        else
        {
            cn.Check_Enrollment__c=false;
        }
    }
    update conslist;
    
}