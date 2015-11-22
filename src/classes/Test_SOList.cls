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
    
    public static testmethod void updateRecords_WithProperRecords_updatesTheListIntoTheDataBase() {
        
        Account a = new Account(name = 'Test a');
        Account b = new Account(name = 'Test b');
        insert a;
        insert b;
        
        a.description = 'Hello';
        b.description = 'World';
        
        Test.startTest();
        SOList l = SOList.create(new List<sObject>{a, b});
        SOList result = l.updateRecords();
        Test.stopTest();
        
        System.assertEquals(2, ([SELECT Id FROM Account]).size());
        System.assertEquals(2, result.size());
        
        List<Account> acc1 = [SELECT Description FROM Account WHERE Id = :a.Id];
        System.assertEquals('Hello', acc1[0].description);
        
        List<Account> acc2 = [SELECT Description FROM Account WHERE Id = :b.Id];
        System.assertEquals('World', acc2[0].description);
    }
    
    public static testmethod void updateRecords_WithFailureRecords_updatesTheListIntoTheDataBaseAndReturnsTheFailures() {
        
        Account a = new Account(name = 'Test a');
        Account b = new Account(name = 'Test b');
        
        insert a;
        insert b;
        
        a.description = 'Hello';
        b.description = 'Test';
        
        Test.startTest();
        SOList l = SOList.create(new List<sObject>{a, b});
        SOList result = l.updateRecords();
        Map<Id, String> errors = result.errors();
        Test.stopTest();
        
        System.assertEquals(2, ([SELECT Id FROM Account]).size());
        System.assertEquals(1, result.size());
        System.assertEquals(1, errors.keySet().size());
    }
    
    public static testmethod void deleteRecords_WithProperRecords_deletesTheRecords() {
        
        Account a = new Account(name = 'Test a');
        Account b = new Account(name = 'Test b');
        insert a;
        insert b;
        
        Test.startTest();
        SOList l = SOList.create(new List<sObject>{a, b});
        SOList result = l.deleteRecords();
        Test.stopTest();
        
        System.assertEquals(0, ([SELECT Id FROM Account]).size());
        System.assertEquals(2, result.size());
    }
}