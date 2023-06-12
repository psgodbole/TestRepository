@isTest
public class TestClassForAccount {
     @testSetup 
    static void setup() {
    Account objAcc = new Account();
        objAcc.Name = 'testAcc for test class 1';
        objAcc.Type = 'Customer - Direct' ;
        objAcc.Active__c = true;
        Account newAcc = new Account();
        newAcc.Name = 'testAcc for test class 2';
        newAcc.Type = 'Customer - Direct' ;
        newAcc.Active__c = false;
        insert objAcc;
        insert newAcc;
    } 
    @isTest
    public static void testForAccountTriggerHandler(){
       	Test.startTest();
        List<Account> acc1 = [SELECT Id,Name FROM Account WHERE Name LIKE 'testAcc for test class 1' LIMIT 1];
        List<Contact> testAccount = [SELECT Id,AccountId From Contact WHERE AccountId = : acc1[0].Id ];
        system.assertEquals(1,testAccount.size());
        Test.stopTest();
    }
    @isTest
    public static void testForAccountUpdate(){
        Test.startTest();
        list<Account> testAccount = [SELECT Id,type,Active__c FROM Account WHERE Name LIKE 'testAcc for test class 2' LIMIT 1 ];
       	testAccount[0].Active__c = true;
        testAccount[0].Account_Activation_Summary__c = 'Test summary';
        update testAccount;
        List<Contact> testcontact = [SELECT Id,AccountId From Contact WHERE AccountId = :testAccount[0].Id ];
        system.assertEquals(1,testAccount.size());
        Test.stopTest();
    }
     public static void testForAccountValidation(){
        Test.startTest();
        Account objAcc = new Account();
        objAcc.Name = 'testAcc 2';
        objAcc.Type = 'Customer - Direct' ;
        objAcc.Active__c = false;
        insert objAcc;
         try{
            	list<Account> testAccount = [SELECT Id,type,Active__c FROM Account WHERE Id=:objAcc.Id ];
        		Account accObj = testAccount[0];
       			accObj.Active__c = true;
        		update accObj;
             
         } catch(exception ex){
             	Boolean expectedExceptionThrown =  ex.getMessage().contains('While activating account, Account Activation Summary must be filled in') ? true : false;
				System.AssertEquals(expectedExceptionThrown, true);
         }
        Test.stopTest();
    }
}