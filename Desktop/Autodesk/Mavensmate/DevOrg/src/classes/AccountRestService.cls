@RestResource(urlMapping='/AccountService')
global class AccountRestService{
    @HttpGet
    global static Account GetAccount(){
        String accountId = RestContext.request.params.get('accountId');        
        return [SELECT Name FROM Account WHERE Id = :accountId LIMIT 1];
    }
}