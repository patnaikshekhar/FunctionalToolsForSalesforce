public class SOList {
    
	private List<sObject> lst;
    private Map<Id, String> errorMap = new Map<Id, String>();
    
    public static SOList create(List<sObject> lst) {
        return new SOList(lst, new Map<Id, String>());
    }
    
    public static SOList create(String query) {
        return new SOList(Database.query(query), new Map<Id, String>());
    }
    
    public SOList(List<sObject> lst, Map<Id, String> errorMap) {
        this.lst = lst;
        this.errorMap = errorMap;
    }
    
    public SOList(List<Object> lst, Map<Id, String> errorMap) {
        this.lst = new List<sObject>();
        for (Object o : lst) {
            lst.add((sObject)o);
        }
    }
    
    public Integer size() {
        return lst.size();
    }
    
    public SOList add(sObject o) {
        SOList newList = this.cloneList();
        newList.lst.add(o);
        return newList;
    }
    
    public sObject get(Integer index) {
        return lst[index];
    }
    
    public SOList cloneList() {
        List<sObject> newList = new List<sObject>();
        
        for (sObject o : lst) {
            newList.add(o);
        }
        
        return new SOList(newList, errorMap);
    }
    
    public SOList mapper(FunctionalInterface f) {
        return new SOList(FuncTools.mapper(this.lst, f), this.errorMap);
    }
    
    public SOList filter(FunctionalInterface f) {
        return new SOList(FuncTools.filter(this.lst, f), this.errorMap);
    }
    
    public sObject reduce(FunctionalInterface2 f, sObject initialValue) {
        return (sObject)FuncTools.reduce(this.lst, f, initialValue);
    }
    
    public List<sObject> getList() {
        return this.lst.clone();
    }
    
    private class getIdMapOfRecords_reducer implements FunctionalInterface2 {
        public Object execute(Object acc, Object o) {
            Map<Id, sObject> currentMap = (Map<Id, sObject>)acc;
            sObject so = (sObject)o;
            currentMap.put(so.Id, so);
            return currentMap;
        } 
    }
    
    private Map<Id, sObject> getIdMapOfRecords() {
        return (Map<Id, sObject>)FuncTools.reduce(this.lst, new getIdMapOfRecords_reducer(), new Map<Id, sObject>());
    }
    
    private SOList createSuccessErrorLists(List<Database.SaveResult> result) {
        List<sObject> successes = new List<sObject>();
        Map<Id, sObject> idMapOfRecords = getIdMapOfRecords();
            
        for (Database.SaveResult r : result) {
            if(r.isSuccess()) {
                if (idMapOfRecords.containsKey(r.getId())) {
                	successes.add(idMapOfRecords.get(r.getId()));    
                }
            } else {
                for(Database.Error err : r.getErrors()) {
                    this.errorMap.put(r.getId(), err.getMessage());
                }
            }
        }
        
        return new SOList(successes, this.errorMap);
    }
    
    public SOList insertRecords() {
        List<Database.SaveResult> result = Database.insert(this.lst, false);
        return createSuccessErrorLists(result);
    }
    
    public SOList updateRecords() {
        List<Database.SaveResult> result = Database.update(this.lst, false);
        return createSuccessErrorLists(result);
    }
    
    public SOList deleteRecords() {
        List<Database.DeleteResult> result = Database.delete(this.lst, false);
        List<sObject> successes = new List<sObject>();
        Map<Id, sObject> idMapOfRecords = getIdMapOfRecords();
        
        for(Database.DeleteResult dr : result) {
            if (dr.isSuccess()) {
                successes.add(idMapOfRecords.get(dr.getId()));
            } else {               
                for(Database.Error err : dr.getErrors()) {
                    this.errorMap.put(dr.getId(), err.getMessage());
                }
            }
        }
        
        return new SOList(successes, this.errorMap);
    }
	   
    public Map<Id, String> errors() {
        return this.errorMap;
    }
    
    public SOList errorRecords() {
        return null;
    }
}