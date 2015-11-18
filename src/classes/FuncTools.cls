public class FuncTools {
    public static List<Object> mapper(List<Object> input, FunctionalInterface f) {
        
        List<Object> result = new List<Object>();
        
        for (Object i : input) {
            result.add(f.execute(i));
        }
        
        return result;
    }
    
    public static List<Object> filter(List<Object> input, FunctionalInterface f) {
        List<Object> result = new List<Object>();
        
        for (Object i : input) {
            if ((boolean)f.execute(i)) {
            	result.add(i);    
            }
        }
        
        return result;
    }
    
    public static Object reduce(List<Object> input, FunctionalInterface2 f, Object initialValue) {
        
        Object accumulator = initialValue;
        
        for (Object i : input) {
            accumulator = f.execute(accumulator, i);
        }
        
        return accumulator;
    }
}