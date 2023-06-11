public with sharing class AccountTriggerController {
  public static void forAccUpdateCreateContact(List<Account> accList,Map<Id,Account> oldMap){
        List<Contact> insertConList = new List<Contact>();
        SET<Id> accId = new SET<Id>();
        for(Account acc : accList){
            accId.add(acc.Id);
        }
        for(Account objAcc :[SELECT Id,Name,Componay_Email__c,Phone,Active__c,Type FROM Account 
                            WHERE ID NOT IN  (SELECT AccountId FROM Contact WHERE LastName LIKE 'Customer Representative')
                            AND ID IN : accId]){
                                if(objAcc.Type == 'Customer - Direct' || objAcc.Type == 'Customer - Channel'){
                                    if( objAcc.Active__c == true && oldMap !=null && objAcc.Active__c != oldMap.get(objAcc.Id).Active__c){
                                        // This is for update account record
                                        Contact updCon = new Contact();
                                        updCon.FirstName = objAcc.Name;
                                        updCon.LastName = 'Customer Representative';
                                        updCon.AccountId = objAcc.Id;
                                        updCon.Email = objAcc.Componay_Email__c;
                                        updCon.Phone = objAcc.Phone;
                                        insertConList.add(updCon);
                                    } 
                                    // this is for new Account record
                                    if (objAcc.Active__c == true ){
                                        Contact objCon = new Contact();
                                        objCon.FirstName = objAcc.Name;
                                        objCon.LastName = 'Customer Representative';
                                        objCon.AccountId = objAcc.Id;
                                        objCon.Email = objAcc.Componay_Email__c;
                                        objCon.Phone = objAcc.Phone;
                                        insertConList.add(objCon);
                                    }
                                }
        }
      
        if(!insertConList.isEmpty()){
            system.debug('trigger execute inside insert update');
            insert insertConList;
        }
    }
}