public class SOListAync {
	List<String> operations;
    List<sObject> lst;
    
    public SOListAync(List<sObject> objects) {
        this.lst = objects;
        this.operations = new List<String>();
    }
    
    public SOListAync(List<sObject> objects, List<String> operations) {
        this.lst = objects;
        this.operations = operations;
    }
    
    public SOListAync mapper(String fn) {
        this.operations.add(fn);
        return new SOListAync(this.lst, this.operations);
    }
}