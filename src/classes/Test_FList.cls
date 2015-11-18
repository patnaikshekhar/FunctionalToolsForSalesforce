@IsTest
public class Test_FList {
	
    public static testmethod void mapper_withAnEmptyArray_shouldReturnTheList() {
        FList l = new FList(new List<Integer>());
        
        Test.startTest();
        Flist result = l.mapper(new mapper_withAnEmptyArray_shouldReturnTheList());
        Test.stopTest();
        
        System.assertEquals(0, result.size());
        System.assertNotEquals(l, result);
    }
    
    public static testmethod void mapper_withAList_shouldDoubleNumbersInList() {
        FList l = new FList(new List<Integer> {1, 2, 3, 4});
        
        Test.startTest();
        Flist result = l.mapper(new mapper_withAList_shouldDoubleNumbersInList());
        Test.stopTest();
        
        System.assertEquals(4, result.size());
        System.assertEquals(2, (Integer)result.get(0));
        System.assertEquals(4, (Integer)result.get(1));
    }
    
    public static testmethod void filter_withAList_shouldFilterNumbersInList() {
        FList l = new FList(new List<Integer> {1, 2, 3, 4});
        
        Test.startTest();
        Flist result = l.filter(new filter_withAList_shouldFilterNumbersInList());
        Test.stopTest();
        
        System.assertEquals(2, result.size());
        System.assertEquals(3, (Integer)result.get(0));
        System.assertEquals(4, (Integer)result.get(1));
    }
    
    public static testmethod void reduce_withAList_shouldSumUpNumbers() {
        FList l = new FList(new List<Integer> {1, 2, 3, 4});
        
        Test.startTest();
        Integer result = (Integer)(l.reduce(new reduce_withAList_shouldSumUpNumbers(), 0));
        Test.stopTest();
        
        System.assertEquals(10, result);
    }
    
    public static testmethod void mapfilterreduce_withAList_ShouldPerformOperations() {
        FList l = new FList(new List<Integer> {1, 2, 3, 4});
        
        Test.startTest();
        Object result = l.filter(new NumbersGreaterThan2())
                         .mapper(new DoubleNumbers())
            			 .reduce(new Sum(), 0);
        Test.stopTest();
        
        System.assertEquals(14, (Integer)result);
    }
    
    // Callbacks
    private class mapper_withAnEmptyArray_shouldReturnTheList implements FunctionalInterface {
        public Object execute(Object lst) {
            return null;
        }
    }
    
    private class mapper_withAList_shouldDoubleNumbersInList implements FunctionalInterface {
        public Object execute(Object o) {
            return (Integer)o * 2;
        }
    }
    
    private class filter_withAList_shouldFilterNumbersInList implements FunctionalInterface {
        public Object execute(Object o) {
            return (Integer)o > 2;
        }
    }
    
    private class reduce_withAList_shouldSumUpNumbers implements FunctionalInterface2 {
        public Object execute(Object o1, Object o2) {
            return (Integer)o1 + (Integer)o2;
        }
    }
    
    private class NumbersGreaterThan2 implements FunctionalInterface {
        public Object execute(Object o) {
            return (Integer)o > 2;
        }
    }
    
    private class DoubleNumbers implements FunctionalInterface {
        public Object execute(Object o) {
            return (Integer)o * 2;
        }
    }
    
    private class Sum implements FunctionalInterface2 {
        public Object execute(Object o1, Object o2) {
            return (Integer)o1 + (Integer)o2;
        }
    }
}