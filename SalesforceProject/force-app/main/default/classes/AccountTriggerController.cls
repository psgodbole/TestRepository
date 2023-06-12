public with sharing class AccountTriggerController {
  public static void forAccUpdateCreateContact(List<Account> accList,Map<Id,Account> oldMap,Map<Id,Account> newMap){
        List<Contact> insertConList = new List<Contact>();
		for(Account objAcc :[SELECT Id,Name,Componay_Email__c,Phone,Active__c,Type FROM Account 
                            WHERE ID NOT IN  (SELECT AccountId FROM Contact WHERE LastName LIKE 'Customer Representative')
                            AND ID IN : newMap.keySet()]){
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
                                    if (objAcc.Active__c == true && oldMap == null ){
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
    public static void ifAccActivatedSummryMust(List<Account> accList,Map<Id,Account> oldMap){
        for(Account eachAcc : accList){
            if(eachAcc.Active__c == true && eachAcc.Active__c != oldMap.get(eachAcc.Id).Active__c && eachAcc.Account_Activation_Summary__c == null){
                eachAcc.Account_Activation_Summary__c.addError('While activating account, Account Activation Summary must be filled in');
            }
        }
    }
}