public class SOListAsync {
	List<Async_Task__c> operations;
    List<sObject> lst;
    
    public SOListAsync(List<sObject> objects) {
        this(objects, new List<Async_Task__c>());
    }
    
    // Factory method for creation
    public static SOListAsync create(List<sObject> objects) {
        return new SOListAsync(objects);
    }
    
    public SOListAsync(List<sObject> objects, List<Async_Task__c> operations) {
        this.lst = objects;
        this.operations = operations;
    }
    
    public SOListAsync mapper(FunctionalInterface f) {
        //this.operations.add(new Async_Task__c(Type__c = 'mapper', Function__c=fn));
        //return new SOListAsync(this.lst, this.operations);
        return null;
    }
    
    // The success sink. It starts the operation
    public void success(String callback) {
        
    }
}