@isTest(seeAllData=false)
public class TestAccountTrigger{
    public static testMethod void createAccounts1(){
        DateTime dt1 = DateTime.now();
        Long l1 = dt1.getTime();
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 100; i++){
            accList.add(new Account(Name='Acc'+i));
        }
        insert accList;
        Test.startTest();
        List<Account> aList = new List<Account>();
        for(Account acc : [SELECT Id, Description FROM Account]){
            acc.Description = 'Test';
            aList.add(acc);
        }
        update aList;
        Test.stopTest();
        accList = [SELECT Id FROM Account WHERE AccountNumber='123456'];
        System.assertEquals(100, accList.size());
        DateTime dt2 = DateTime.now();  
        Long l2 = dt2.getTime();        
        System.debug('time elapsed:'+(l2-l1));
    }
    public static testMethod void createAccounts2(){
        DateTime dt1 = DateTime.now(); 
        Long l1 = dt1.getTime();
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 100; i++){
            accList.add(new Account(Name='Acc'+i));
        }
        insert accList;
        Test.startTest();
        List<Account> aList = new List<Account>();
        for(Account acc : [SELECT Id, Description FROM Account]){
            acc.Description = 'Test';
            aList.add(acc);
        }
        update aList;                
        Test.stopTest();
        accList = [SELECT Id FROM Account WHERE AccountNumber='123456'];
        System.assertEquals(100, accList.size());
        DateTime dt2 = DateTime.now();  
        Long l2 = dt2.getTime();        
        System.debug('time elapsed:'+(l2-l1));        
    }   
    public static testMethod void createAccounts3(){
        DateTime dt1 = DateTime.now(); 
        Long l1 = dt1.getTime();
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 100; i++){
            accList.add(new Account(Name='Acc'+i));
        }
        insert accList;
        Test.startTest();
        List<Account> aList = new List<Account>();
        for(Account acc : [SELECT Id, Description FROM Account]){
            acc.Description = 'Test';
            aList.add(acc);
        }
        update aList;                
        Test.stopTest();
        accList = [SELECT Id FROM Account WHERE AccountNumber='123456'];
        System.assertEquals(100, accList.size());
        DateTime dt2 = DateTime.now();  
        Long l2 = dt2.getTime();        
        System.debug('time elapsed:'+(l2-l1));        
    }     
    public static testMethod void createAccounts4(){
        DateTime dt1 = DateTime.now(); 
        Long l1 = dt1.getTime();
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < 100; i++){
            accList.add(new Account(Name='Acc'+i));
        }
        insert accList;
        Test.startTest();
        List<Account> aList = new List<Account>();
        for(Account acc : [SELECT Id, Description FROM Account]){
            acc.Description = 'Test';
            aList.add(acc);
        }
        update aList;                
        Test.stopTest();
        accList = [SELECT Id FROM Account WHERE AccountNumber='123456'];
        System.assertEquals(100, accList.size());
        DateTime dt2 = DateTime.now();  
        Long l2 = dt2.getTime();        
        System.debug('time elapsed:'+(l2-l1));        
    }    
}