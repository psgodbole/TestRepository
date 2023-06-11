@isTest
public class TestClassForAccount {
   
    @isTest
    public static void testForAccountTriggerHandler(){
       	Test.startTest();
        Account objAcc = new Account();
        objAcc.Name = 'testAcc 1';
        objAcc.Type = 'Customer - Direct' ;
        objAcc.Active__c = true;
        Account newAcc = new Account();
        newAcc.Name = 'testAcc 1';
        newAcc.Type = 'Customer - Direct' ;
        newAcc.Active__c = false;
        
        insert objAcc;
        insert newAcc;
        List<Contact> testAccount = [SELECT Id,AccountId From Contact WHERE AccountId = :objAcc.Id ];
        system.assertEquals(1,testAccount.size());
        Test.stopTest();
    }
    @isTest
    public static void testForAccountUpdate(){
        Test.startTest();
        Account objAcc = new Account();
        objAcc.Name = 'testAcc 2';
        objAcc.Type = 'Customer - Direct' ;
        objAcc.Active__c = false;
        insert objAcc;
        list<Account> testAccount = [SELECT Id,type,Active__c FROM Account WHERE Id=:objAcc.Id ];
        Account accObj = testAccount[0];
        accObj.Active__c = true;
        update accObj;
        List<Contact> testcontact = [SELECT Id,AccountId From Contact WHERE AccountId = :accObj.Id ];
        system.assertEquals(1,testAccount.size());
        Test.stopTest();
    }
}