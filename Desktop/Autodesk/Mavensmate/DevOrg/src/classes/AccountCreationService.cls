public class AccountCreationService{
    static String  accessToken;                    // OAuth 2.0 access token
    static String  sfdcInstanceUrl;                // Endpoint URL for SFDC instance
    @future(callout=true)
    public static void sendAccount(Set<Id> accIds){
        System.debug('accIds:'+accIds.size());
        //List<Account> accList = [Select Name, Industry, DunsNumber, active__c, Description, Description1__c, Description2__c from Account WHERE Id IN :accIds];
        List<Account> accList = [Select Name, Industry, DunsNumber, active__c, Description, Description1__c, Description2__c from Account];        
        if(!accList.isEmpty()){
            String consumerKey = '3MVG9CEn_O3jvv0zo7oaYF4UD_b2qeL_MRjRIqd93PHmcLxHoImvbWVIegC1jonV_qQtioUZLPStZnCneO.rW';
            String consumerSecret = '8938698901878575504';
            String uName = 'salesforcejsonvalidator@gmail.com';
            String uPassword = 'Salesforce#2OoFVswDawUhzzLBL5GQ78jJB1';
            Boolean isSandbox = false;
            authenticateByUserNamePassword(consumerKey, consumerSecret, uName, uPassword, isSandbox);
            String uri = sfdcInstanceUrl + '/services/apexrest/AccountService/createAccount';
            Account acc = accList[0];
            String accStr = JSON.serialize(accList);
            System.debug('accStr :'+accStr);
            //return;
            try{            
                HttpResponse hRes = send(uri, 'POST', accStr);
                 if (hRes.getStatusCode() != 200){
                    Exception__c ex = new Exception__c(Name = String.valueOf(hRes.getStatusCode()), Message__c = hRes.getBody());
                    insert ex;
                }             
                System.debug('res:'+hRes.toString());
                System.debug('res-body:'+hRes.getBody());            
            }catch(Exception e){
                Exception__c ex = new Exception__c(Name = e.getTypeName(), Message__c = e.getMessage());
                insert ex;
            }
           
                   
            
            /*HttpRequest req = new HttpRequest();
            
            req.setEndpoint('https://na50.salesforce.com/services/apexrest/AccountService/createAccount');
            String username = 'salesforcejsonvalidator@gmail.com';
            String password = 'Salesforce#2';
            Blob headerValue = Blob.valueOf(username + ':'+ password);
            String authorizationHeader = 'Basic '+EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader);
            --
            req.setEndpoint('callout:SFDC_Validator/services/apexrest/AccountService/createAccount');
            //req.setEndpoint('callout:SFDC_Validator/services/apexrest/AccountService/getAccount');            
            req.setMethod('POST');
            //req.setMethod('GET');            
            req.setBody(String.valueOf(accList[0]));
            System.debug('req:'+req.toString());   
            System.debug('Header*****'+req.getHeader('Authorization'));            
            Http http = new Http();
            HTTPResponse res = http.send(req);
            System.debug('res:'+res.toString());
            System.debug('res-body:'+res.getBody());         
            System.debug('***Header*****'+req.getHeader('Authorization'));  
            */                    
        }
    }
    private static HttpResponse send(String uri, String httpMethod, String body) {

        //if (Limits.getCallouts() == Limits.getLimitCallouts())
        //    throw new MyException('[HTTP-00] Callout limit: ' + Limits.getCallouts() + ' reached. No more callouts permitted.');
        Http        h       = new Http();
        HttpRequest hRqst   = new HttpRequest();
        hRqst.setEndpoint(uri);                     // caller provides, this will be a REST resource
        hRqst.setMethod(httpMethod);                // caller provides
        hRqst.setTimeout(6000); 
        System.debug('req:'+hRqst);
        if (body != null) 
            hRqst.setBody(body);                    // caller provides
        if (accessToken != null){               // REST requires using the token, once obtained for each request
            hRqst.setHeader('Authorization','Bearer ' + accessToken);
            hRqst.setHeader('Content-Type','application/json');            
        }    
        hRqst.setTimeout(60000);
        System.debug('req-:'+hRqst.getBody());        
        return h.send(hRqst);                   // make the callout
    }   
    //  ----------------------------------------------------------------------
    //  authenticateByUserNamePassword      : Returns a map of <String,String> of the OAuth 2.0 access token; required before REST calls on SFDC instances can be made 
    //  ----------------------------------------------------------------------
    public static void authenticateByUserNamePassword(String consumerKey, String consumerSecret, String uName, String uPassword, Boolean isSandbox) {
        // Reference documentation can be found in the REST API Guide, section: 'Understanding the Username-Password OAuth Authentication Flow'
        // OAuth 2.0 token is obtained from endpoints:
        //  PROD orgs   : https://login.salesforce.com/services/oauth2/token
        //  SANDBOX orgs: https://test.salesforce.com/services/oauth2/token

        //  OAuth 2.0 access token contains these name/values:
        //      access_token        : used in subsequent REST calls
        //      instance_url        : to form the REST URI
        //      id                  : identifies end user
        //      issued_at           : When signature was created
        //      signature           : HMAC-SHA256 signature signed with private key - can be used to verify the instance_url     

        String uri          = 'https://' + (isSandbox ? 'test' : 'login') + '.salesforce.com/services/oauth2/token';
        String clientId     = EncodingUtil.urlEncode(consumerKey,'UTF-8');
        String clientSecret = EncodingUtil.urlEncode(consumerSecret,'UTF-8');
        String username     = EncodingUtil.urlEncode(uName,'UTF-8');
        String password     = EncodingUtil.urlEncode(uPassword,'UTF-8');

        String body =   'grant_type=password&client_id=' + clientId + 
                        '&client_secret=' + clientSecret +
                        '&username=' + username + 
                        '&password=' + password; 
        System.debug('body:'+body);
        HttpResponse hRes = send(uri,'POST',body);
        if (hRes.getStatusCode() != 200){
            
        }
         
        //    throw new MyException('[HTTP-01] OAuth 2.0 access token request error. Verify username, password, consumer key, consumer secret, isSandbox?  StatusCode=' +
        //                                         hRes.getStatusCode() + ' statusMsg=' + hRes.getStatus());


        System.debug('response body =\n' + hRes.getBody());


        Map<String,String> res = (Map<String,String>) JSON.deserialize(hRes.getBody(),Map<String,String>.class);

        accessToken        = res.get('access_token');      // remember these for subsequent calls
        System.debug('accessToken:'+accessToken);        
        sfdcInstanceUrl    = res.get('instance_url');
        System.debug('sfdcInstanceUrl :'+sfdcInstanceUrl);

    }
}