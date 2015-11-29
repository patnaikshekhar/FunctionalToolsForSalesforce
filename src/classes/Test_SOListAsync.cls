@isTest
public class Test_SOListAsync {
    
    public static boolean called_Test_SOListAsync_mapper_CreateSimpleMapWithInsert_insertsRecords_MapAccountDescription = false;
    public static boolean called_Test_SOListAsync_mapper_CreateSimpleMapWithInsert_successCallback = false;
    
    class Test_SOListAsync_mapper_CreateSimpleMapWithInsert_insertsRecords_MapAccountDescription implements FunctionalInterface {
        public Object execute(Object o) {
            Account a = (Account) o;
            
            if (a.Name == 'A1') {
                called_Test_SOListAsync_mapper_CreateSimpleMapWithInsert_insertsRecords_MapAccountDescription = true;
            }
            
            a.Description = 'Test';
            
            return a;
        }
    }
    
    class Test_SOListAsync_mapper_CreateSimpleMapWithInsert_successCallback implements FunctionalInterface {
        public Object execute(Object o) {
            List<Account> accs = (List<Account>)o;
            
            if (accs.size() == 2) {
                called_Test_SOListAsync_mapper_CreateSimpleMapWithInsert_successCallback = true;
            }
            
            return null;
        }
    }
    
    public static testmethod void mapper_CreateSimpleMapWithInsert_insertsRecords() {
        Account a1 = new Account(name = 'A1');
        Account a2 = new Account(name = 'A2');
        
        Test.startTest();
        
        SOListAsync.create(new List<Account> {a1, a2})
            	   .mapper(new Test_SOListAsync.Test_SOListAsync_mapper_CreateSimpleMapWithInsert_insertsRecords_MapAccountDescription())
            	   .success(new Test_SOListAsync_mapper_CreateSimpleMapWithInsert_successCallback());
        Test.stopTest();
        
        System.assertEquals(true, called_Test_SOListAsync_mapper_CreateSimpleMapWithInsert_insertsRecords_MapAccountDescription);
        System.assertEquals(true, called_Test_SOListAsync_mapper_CreateSimpleMapWithInsert_successCallback);
    }
}