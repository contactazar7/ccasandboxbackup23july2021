public class IconsForConsumerCL {

    public Consumer__c conrec {get;set;}
    public string accId {get;set;}
    public String contId {get;set;}
    public IconsForConsumerCL (ApexPages.StandardController controller){
        contId =controller.getRecord().id;

        system.debug('contId===='+contId);
        conrec= new Consumer__c();
        if(contId!=null){
 
        conrec= [Select id,Consumer_Participation_form_submitted__c,Authorization_Form_Submitted__c,Check_Enrollment__c
                 from Consumer__c where id=:ApexPages.currentPage().getParameters().get('id')];
        system.debug('Id:'+conrec);
                        }}
                           
}