public class ActionFunctionController{
    public String name {get;set;}
    public PageReference updateAccount(){
        try{
            Account acc = [SELECT Id FROM Account LIMIT 1];
            acc.name = name;
            update acc;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, ''));
        }            
        return null;
    }
}