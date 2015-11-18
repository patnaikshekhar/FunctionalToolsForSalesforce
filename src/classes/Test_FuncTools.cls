@isTest
public class Test_FuncTools {
    
    public static testmethod void map_EmptyArray_shouldReturnEmptyArray() {
        List<Integer> ints = new List<Integer>();
        
        Test.startTest();
        List<Object> result = FuncTools.mapper(ints, new map_EmptyArray_shouldReturnEmptyArray());
        Test.stopTest();
        
        System.assertEquals(0, result.size());
    }
    
    public static testmethod void map_WithArrayOfInts_shouldReturnMappedArray() {
        List<Integer> ints = new List<Integer>{1, 2, 3, 4};
        
        Test.startTest();
        List<Object> result = FuncTools.mapper(ints, new map_WithArrayOfInts_shouldReturnMappedArray());
        Test.stopTest();
        
        System.assertEquals(4, result.size());
        System.assertEquals(2, (Integer)result[0]);
        System.assertEquals(4, (Integer)result[1]);
    }
    
    public static testmethod void map_WithArrayOfStrings_shouldReturnMappedArray() {
        List<String> strs = new List<String>{'1', '2', '3', '4'};
        
        Test.startTest();
        List<Object> result = FuncTools.mapper(strs, new map_WithArrayOfStrings_shouldReturnMappedArray());
        Test.stopTest();
        
        System.assertEquals(4, result.size());
        System.assertEquals('1a', (String)result[0]);
        System.assertEquals('2a', (String)result[1]);
    }
    
    public static testmethod void map_WithArrayOfAccounts_shouldReturnMappedArray() {
        List<Account> arr = new List<Account>{new Account(name='A'), new Account(name='B')};
        
        Test.startTest();
        List<Object> result = FuncTools.mapper(arr, new map_WithArrayOfAccounts_shouldReturnMappedArray());
        Test.stopTest();
        
        System.assertEquals(2, result.size());
        System.assertEquals('AA', ((Account)result[0]).Name);
        System.assertEquals('BA', ((Account)result[1]).Name);
    }
    
    public static testmethod void filter_EmptyArray_shouldReturnEmptyArray() {
        List<Integer> ints = new List<Integer>();
        
        Test.startTest();
        List<Object> result = FuncTools.filter(ints, new filter_EmptyArray_shouldReturnEmptyArray());
        Test.stopTest();
        
        System.assertEquals(0, result.size());
    }
    
    public static testmethod void filter_FalseFilter_shouldReturnEmptyArray() {
        List<Integer> ints = new List<Integer> {1, 2, 3, 4};
        
        Test.startTest();
        List<Object> result = FuncTools.filter(ints, new filter_FalseFilter_shouldReturnEmptyArray());
        Test.stopTest();
        
        System.assertEquals(0, result.size());
    }
    
    public static testmethod void filter_TrueFilter_shouldReturnSameArray() {
        List<Integer> ints = new List<Integer> {1, 2, 3, 4};
        
        Test.startTest();
        List<Object> result = FuncTools.filter(ints, new filter_TrueFilter_shouldReturnSameArray());
        Test.stopTest();
        
        System.assertEquals(4, result.size());
    }
    
    public static testmethod void filter_EvenNumberFilter_shouldReturnEvensInArray() {
        List<Integer> ints = new List<Integer> {1, 2, 3, 4};
        
        Test.startTest();
        List<Object> result = FuncTools.filter(ints, new filter_EvenNumberFilter_shouldReturnEvensInArray());
        Test.stopTest();
        
        System.assertEquals(2, result.size());
        System.assertEquals(2, (Integer)result[0]);
        System.assertEquals(4, (Integer)result[1]);
    }
    
    // Callbacks
    private class map_EmptyArray_shouldReturnEmptyArray implements FunctionalInterface {
        public Object execute(Object o) {
            return null;
        }
    }
    
    private class map_WithArrayOfInts_shouldReturnMappedArray implements FunctionalInterface {
        public Object execute(Object o) {
            return (Integer)o * 2;
        }
    }
    
    private class map_WithArrayOfStrings_shouldReturnMappedArray implements FunctionalInterface {
        public Object execute(Object o) {
            return (String)o + 'a';
        }
    }
    
    private class map_WithArrayOfAccounts_shouldReturnMappedArray implements FunctionalInterface {
        public Object execute(Object o) {
            Account a = (Account)o;
            a.Name = a.Name + 'A';
            return a;
        }
    }
    
    private class filter_EmptyArray_shouldReturnEmptyArray implements FunctionalInterface {
        public Object execute(Object o) {
            return false;
        }
    }
    
    private class filter_FalseFilter_shouldReturnEmptyArray implements FunctionalInterface {
        public Object execute(Object o) {
            return false;
        }
    }
    
    private class filter_TrueFilter_shouldReturnSameArray implements FunctionalInterface {
        public Object execute(Object o) {
            return true;
        }
    }
    
    private class filter_EvenNumberFilter_shouldReturnEvensInArray implements FunctionalInterface {
        public Object execute(Object o) {
            return Math.mod((Integer) o, 2) == 0;
        }
    }
    
}