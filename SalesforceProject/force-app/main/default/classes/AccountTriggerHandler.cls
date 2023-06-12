public class AccountTriggerHandler {
	public static void forAccUpdateCreateContact(List<Account> accList,Map<Id,Account> oldMap){
        List<Contact> insertConList = new List<Contact>();
        SET<Id> accId = new SET<Id>();
        for(Contact eachCon : [SELECT Id,LastName,AccountId FROM Contact WHERE AccountId != null AND LastName = 'Customer Representative']){
            accId.add(eachCon.AccountId);
        }
        for(Account eachAcc : accList){
            if(eachAcc.Type == 'Customer - Direct' || eachAcc.Type == 'Customer - Channel'){
               if( eachAcc.Active__c == true && eachAcc.Active__c != oldMap.get(eachAcc.Id).Active__c && (!accId.Contains(eachAcc.Id))){
                		Contact objCon = new Contact();
                   		objCon.FirstName = eachAcc.Name;
                   		objCon.LastName = 'Customer Representative';
                   		objCon.AccountId = eachAcc.Id;
                   		objCon.Email = eachAcc.Componay_Email__c;
                   		objCon.Phone = eachAcc.Phone;
                   		insertConList.add(objCon);
            	}  
            }
        } 
        if(!insertConList.isEmpty()){
            system.debug('trigger execute inside insert update');
            insert insertConList;
        }
    }
    public static void forAccCreateContact(List<Account> accList){
        system.debug('trigger execute inside handler');
        List<Contact> insertConList = new List<Contact>();
        for(Account eachAcc : accList){
            if(eachAcc.Type == 'Customer - Direct' || eachAcc.Type == 'Customer - Channel'){
               if( eachAcc.Active__c == true){
                		Contact objCon = new Contact();
                   		objCon.FirstName = eachAcc.Name;
                   		objCon.LastName = 'Customer Representative';
                   		objCon.AccountId = eachAcc.Id;
                   		objCon.Email = eachAcc.Componay_Email__c;
                   		objCon.Phone = eachAcc.Phone;
                   		insertConList.add(objCon);
            	}  
            }
        }
        if(!insertConList.isEmpty()){
            system.debug('trigger execute inside insert');
            insert insertConList;
        }
    }
}