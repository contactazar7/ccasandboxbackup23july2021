public class competency_automate {
    
    public List< Competency_Check__c > competencylist {get;set;}
    public List< SFDC_Enrollment__c  > enrollmentlist {get;set;}
    public Id recId {get; set;}
    public SFDC_Class__c classrec {get; set;}
    
    public competency_automate(ApexPages.StandardController controller){
        classrec = (SFDC_Class__c)controller.getRecord();
        recId = classrec.Id;
        system.debug('sakdhsaj'+recId);
    }
    
    public PageReference createCompetencyRecs() {
   // createCompetencyRecs(recId);
    SFDC_Class__c clst=[select id,name,competency_created__c ,Duplication_Avoider__c,Is_it_a_CNA_Other_class__c,Class_Category__c from SFDC_Class__c where id =:recId];
     clst.competency_created__c=true;
     update clst;
    PageReference pageRef = new PageReference('/'+recId);
    pageRef.setRedirect(true);
    return pageRef; 
    }
    
   
    }