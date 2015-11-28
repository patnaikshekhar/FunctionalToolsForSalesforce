public class SOListAsync {
	FList functions;
    FList operations;
    List<sObject> lst;
    
    public SOListAsync(List<sObject> objects) {
        this(objects, null, null);
    }
    
    // Factory method for creation
    public static SOListAsync create(List<sObject> objects) {
        return new SOListAsync(objects);
    }
    
    public SOListAsync(List<sObject> objects, FList operations, FList functions) {
        this.lst = objects;
        this.operations = operations;
        this.functions = functions;
    }
    
    public SOListAsync mapper(FunctionalInterface f) {
        operations.getList().add('map');
        functions.getList().add(f);
        return new SOListAsync(lst, operations, functions);
    }
    
    // The success sink. It starts the operation
    public void success(FunctionalInterface f) {
        operations.getList().add('success');
        functions.getList().add(f);
        AsyncFunctionExecutor executor = new AsyncFunctionExecutor(SOList.create(lst), operations, functions);
        System.enqueueJob(executor);
    }
}