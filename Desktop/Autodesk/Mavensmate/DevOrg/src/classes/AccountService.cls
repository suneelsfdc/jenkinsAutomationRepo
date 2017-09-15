global class AccountService{
    webservice static ResultWrapper upsertAccount(String accountId, String billingStreet, String billingCity, String billingPostalCode){
        ResultWrapper rw = new ResultWrapper(); 
        try{                    
            List<Account> accList = [SELECT Name, BillingAddress FROM Account WHERE Account_Id__c = :accountId LIMIT 1];
            Account acc = new Account();
            List<Account> listToUpdate = new List<Account>();
            if(accList.size() > 0){
                acc.Id = accList[0].Id;
                acc.BillingStreet = billingStreet;
                acc.BillingCity = billingCity;
                acc.billingPostalCode = billingPostalCode;
                listToUpdate.add(acc);
            }else{
                acc.Account_Id__c = accountId;
                acc.BillingStreet = billingStreet;
                acc.BillingCity = billingCity;
                acc.billingPostalCode = billingPostalCode;
                listToUpdate.add(acc);              
            }
            update listToUpdate;
            rw.accountId = accountId;
            rw.status = 'Success';
            rw.errorMessage = '';
            return rw;
        }catch(Exception e){
            rw.accountId = accountId;
            rw.status = 'Error';            
            rw.errorMessage = e.getMessage();
        }
        return rw;
    }
    global class AccountWrapper{
        global String accountId;
        global String accountName;
    }
    global class ResultWrapper{
        global String accountId;
        global String status;        
        global String errorMessage;
    }
}