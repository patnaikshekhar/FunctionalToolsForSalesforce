public class SOListAsync {
	List<Async_Task__c> operations;
    List<sObject> lst;
    
    public SOListAsync(List<sObject> objects) {
        this(objects, new List<Async_Task__c>());
    }
    
    public SOListAsync(List<sObject> objects, List<Async_Task__c> operations) {
        this.lst = objects;
        this.operations = operations;
    }
    
    public SOListAsync mapper(String fn) {
        this.operations.add(new Async_Task__c(Type__c = 'mapper', Function__c=fn));
        return new SOListAsync(this.lst, this.operations);
    }
}