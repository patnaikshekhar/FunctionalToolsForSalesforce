public virtual class FList {
	private List<Object> lst;
    
    public FList() {
        this.lst = new List<Object>();
    }
    
    public FList(List<Object> lst) {
        this.lst = lst;
    }
    
    public Integer size() {
        return lst.size();
    }
    
    public FList add(Object o) {
        FList newList = this.cloneList();
        newList.lst.add(o);
        return newList;
    }
    
    public Object get(Integer index) {
        return lst[index];
    }
    
    public FList cloneList() {
        List<Object> newList = new List<Object>();
        
        for (Object o : lst) {
            newList.add(o);
        }
        
        return new FList(newList);
    }
    
    public FList mapper(FunctionalInterface f) {
        return new FList(FuncTools.mapper(this.lst, f));
    }
    
    public FList filter(FunctionalInterface f) {
        return new FList(FuncTools.filter(this.lst, f));
    }
    
    public Object reduce(FunctionalInterface2 f, Object initialValue) {
        return FuncTools.reduce(this.lst, f, initialValue);
    }
    
    public List<Object> getList() {
        return this.lst.clone();
    }
    
    public Object head() {
        if (this.lst.size() > 0) {
        	return this.lst[0];    
        } else {
            return null;
        }
    }
    
    public FList tail() {
        List<Object> newList = this.lst.clone();
        if (lst.size() > 0) {
        	newList.remove(0);
            return new FList(newList);
        } else {
            return null;
        }
    }
}