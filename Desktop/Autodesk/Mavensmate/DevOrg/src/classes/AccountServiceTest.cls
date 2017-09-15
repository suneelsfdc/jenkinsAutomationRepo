@isTest
public class AccountServiceTest{
    @testsetup
    public static void setupTestData(){
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Account_Id__c = '786';
        acc.BillingStreet = 'XYZ';
        acc.BillingCity = 'ABC';
        insert acc;
    }
    public static testMethod void testSuccess(){
        List<Account> accList = [SELECT Id, BillingCity FROM Account WHERE account_Id__c = '786'];
        System.assertEquals('ABC', accList[0].BillingCity);
        Test.startTest();
        AccountService.ResultWrapper rw = AccountService.upsertAccount('786', '355 Serrano Dr', 'SF', '94132');
        Test.stopTest();
        accList = [SELECT Id, BillingCity FROM Account WHERE account_Id__c = '786'];
        System.assertEquals('Success', rw.Status);
        System.assertEquals('SF', accList[0].BillingCity);
    }
    public static testMethod void testFailure(){
        List<Account> accList = [SELECT Id, BillingCity FROM Account WHERE account_Id__c = '786'];
        System.assertEquals('ABC', accList[0].BillingCity);
        Test.startTest();
        AccountService.ResultWrapper rw = AccountService.upsertAccount('', '355 Serrano Dr', 'SF', '94132');
        Test.stopTest();
        System.assertEquals('Error', rw.Status);
    }    
}