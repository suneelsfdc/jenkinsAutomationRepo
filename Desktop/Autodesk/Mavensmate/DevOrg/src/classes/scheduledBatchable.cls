global class scheduledBatchable implements Schedulable {
    global void execute(SchedulableContext sc) {
        DoNothingBatch b = new DoNothingBatch();
        Database.executeBatch(b, 1);
    }
}