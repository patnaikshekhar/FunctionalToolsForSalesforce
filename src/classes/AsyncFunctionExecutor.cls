public class AsyncFunctionExecutor implements Queueable {
    
    private FList functions;
    private Object input;
    private FList operations;
    
    public AsyncFunctionExecutor(Object input, FList operations, FList functions) {
        this.functions = functions;
        this.input = input;
        this.operations = operations;
    }
    
	public void execute(QueueableContext context) {
        String operation =  (String)operations.head();
        
        SOList result;
        
        if (operation == 'map') {
            SOList lst = (SOList)input;
       		result = lst.mapper((FunctionalInterface)functions.head());    
        } else if (operation == 'success') {
            ((FunctionalInterface)functions.head()).execute(input);
        }
    	
        if (operations.tail() != null && operations.tail().size() > 0) {
        	System.enqueueJob(new AsyncFunctionExecutor(result, operations.tail(), functions.tail()));    
        }
        
    }
}