@isTest
public class Test_SOList {
	
    public static testmethod void create_WithAList_CreatesASOList() {
        
        Account a = new Account(name = 'Test a');
        Account b = new Account(name = 'Test b');
        insert a;
        insert b;
        
        Test.startTest();
        SOList l = SOList.create([SELECT Id FROM Account]);
        Test.stopTest();
        
        System.assertEquals(2, l.size());
    }
    
    public static testmethod void create_WithAQuery_CreatesASOList() {
        
        Account a = new Account(name = 'Test a');
        Account b = new Account(name = 'Test b');
        insert a;
        insert b;
        
        Test.startTest();
        SOList l = SOList.create('SELECT Id FROM Account');
        Test.stopTest();
        
        System.assertEquals(2, l.size());
    }
    
    public static testmethod void insertRecords_WithProperRecords_insertsTheListIntoTheDataBase() {
        
        Account a = new Account(name = 'Test a');
        Account b = new Account(name = 'Test b');
        
        Test.startTest();
        SOList l = SOList.create(new List<sObject>{a, b});
        SOList result = l.insertRecords();
        Test.stopTest();
        
        System.assertEquals(2, ([SELECT Id FROM Account]).size());
        System.assertEquals(2, result.size());
    }
    
    public static testmethod void insertRecords_WithFailureRecords_insertsTheListIntoTheDataBaseAndReturnsTheFailures() {
        
        Account a = new Account(name = 'Test a', description='Test');
        Account b = new Account(name = 'Test b');
        
        Test.startTest();
        SOList l = SOList.create(new List<sObject>{a, b});
        SOList result = l.insertRecords();
        Map<Id, String> errors = result.errors();
        Test.stopTest();
        
        System.assertEquals(1, ([SELECT Id FROM Account]).size());
        System.assertEquals(1, result.size());
        System.assertEquals(1, errors.keySet().size());
    }
}