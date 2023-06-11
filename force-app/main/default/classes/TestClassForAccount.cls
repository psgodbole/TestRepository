@isTest
public class TestClassForAccount {
   
    @isTest
    public static void testForAccountTriggerHandler(){
       	Test.startTest();
        Account objAcc = new Account();
        objAcc.Name = 'testAcc 1';
        objAcc.Type = 'Customer - Direct' ;
        objAcc.Active__c = true;
        
        insert objAcc;
        List<Contact> testAccount = [SELECT Id,AccountId From Contact WHERE AccountId = :objAcc.Id ];
        system.assertEquals(1,testAccount.size());
        Test.stopTest();
    }

}