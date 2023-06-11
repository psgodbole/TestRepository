trigger AccountTriggerHandler on Account (after insert,after update) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            AccountTriggerController.forAccUpdateCreateContact(trigger.new,trigger.oldMap);
        }
        if(trigger.isUpdate){
             AccountTriggerController.forAccUpdateCreateContact(trigger.new,trigger.oldMap);
        }
    }
}