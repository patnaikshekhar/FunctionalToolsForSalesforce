# Functional Tools for Salesforce

Functional programming has really not been a thing on the Salesforce platform. However since functional programming is **awesome** and is becoming more and more **popular**, here is a library which allows us to do some sort of functional programming in apex. This is work in progress at the moment.

## Usage

* **Map** Function
```java
private class callback implements FunctionalInterface {
    public Object execute(Object o) {
        Account a = (Account)o;
        a.Name = a.Name + 'A';
        return a;
    }
}
    
List<Account> arr = new List<Account> {
    new Account(name='A'), 
    new Account(name='B')
};

List<Object> result = FuncTools.mapper(arr, new callback());       
System.assertEquals(2, result.size());
System.assertEquals('AA', ((Account)result[0]).Name);
System.assertEquals('BA', ((Account)result[0]).Name);

```

* **Filter** Function
```java
private class callback implements FunctionalInterface {
    public Object execute(Object o) {
        return Math.mod((Integer) o, 2) == 0;
    }
}

List<Integer> ints = new List<Integer> {1, 2, 3, 4};
                
List<Object> result = FuncTools.filter(ints, new callback());

System.assertEquals(2, result.size());
System.assertEquals(2, (Integer)result[0]);
System.assertEquals(4, (Integer)result[1]);
```

* **Reduce** Function
```java
private class callback implements FunctionalInterface2 {
    public Object execute(Object acc, Object i) {
        return (Integer)acc + (Integer)i;
    }
}

List<Integer> ints = new List<Integer>{1, 2, 3, 4};
Object result = FuncTools.reduce(ints, new callback(), 0);

System.assertEquals(10, (Integer) result);
```