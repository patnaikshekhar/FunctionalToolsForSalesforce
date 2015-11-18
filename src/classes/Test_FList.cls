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
        System.assertNotEquals(2, (Integer)result.get(0));
        System.assertNotEquals(4, (Integer)result.get(1));
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
}