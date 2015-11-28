public class Test_SOListAsync {
    
    class Test_SOListAsync_mapper_CreateSimpleMapWithInsert_insertsRecords_MapAccountDescription implements FunctionalInterface {
        public Object execute(Object o) {
            return null;
        }
    }
    
    public void mapper_CreateSimpleMapWithInsert_insertsRecords() {
        Account a1 = new Account(name = 'A1');
        Account a2 = new Account(name = 'A2');
        
        Test.startTest();
        
        SOListAsync.create(new List<Account> {a1, a2})
            	   .mapper(new Test_SOListAsync.Test_SOListAsync_mapper_CreateSimpleMapWithInsert_insertsRecords_MapAccountDescription())
            	   .success('Test_SOListAsync_mapper_CreateSimpleMapWithInsert_successCallback');
        
        Test.stopTest();
        
        System.assertEquals(2, ([SELECT Id FROM Account]).size());
    }
}