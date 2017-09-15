public class SampleController{
    public PageReference updateAccCon(){
        Savepoint sp = Database.setSavepoint();
        try{
            Account acc = [SELECT Id, Name FROM Account where id='0016A0000030Fix'];
            acc.Name = acc.Name+'2';
            update acc;
        }catch(Exception e){
            System.debug('Exception Caught while updating Account');
            database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(Apexpages.severity.ERROR, 'An exception thrown while updating Account'));
        }
        try{
            Contact con = [SELECT Id, LastName FROM Contact WHERE Id='0036A0000023h9f'];
            con.LastName = con.LastName + '3';        
            update con;
        }catch(Exception e){
            System.debug('Exception Caught while updating Contact');
            database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(Apexpages.severity.ERROR, 'An exception thrown while updating Contact'));
        }
        return null;
    }
}