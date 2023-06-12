trigger AccountTriggerHandler on Account (after insert,after update) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            AccountTriggerController.forAccUpdateCreateContact(trigger.new,trigger.oldMap,trigger.newMap);
        }
        if(trigger.isUpdate){
             AccountTriggerController.forAccUpdateCreateContact(trigger.new,trigger.oldMap,trigger.newMap);
             AccountTriggerController.ifAccActivatedSummryMust(trigger.new,trigger.oldMap);
        }
    }
}