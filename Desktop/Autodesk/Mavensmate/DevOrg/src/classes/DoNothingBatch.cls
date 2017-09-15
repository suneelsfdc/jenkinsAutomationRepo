global class DoNothingBatch implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('In debug'+System.today());
        return Database.getQueryLocator([SELECT Id FROM Account]);
    }
    global void execute(Database.BatchableContext bc, List<sObject> scope){
        for(Integer i = 0; i< 1000000; i++){
            for(Integer j = 0; j< 10; j++){
            }
        }
        System.debug('In execute');    
    }    
    global void finish(Database.BatchableContext bc){
        System.debug('In finish');       
        String jobName = 'MyJob' + Datetime.now();
        //system.scheduleBatch(this, jobName , 2, 10);       
        //Database.executeBatch(new DoNothingBatch(), 1);        
    }     
}