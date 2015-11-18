# Functional Tools for Salesforce

Functional programming has really not been a thing on the Salesforce platform. However since functional programming is **awesome** and is becoming more and more **popular**, here is a library which allows us to do some sort of functional programming in apex. This is work in progress at the moment. Of course all this would've been easier if Apex supported Generic fully, and if it supported passing functions as arguments or even anonymous classes.

## Usage - FuncTools class
This is a class containing the basic map, reduce and filter functions and can be used with any standard List.

* **Map** Function
```java
private class Callback implements FunctionalInterface {
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

List<Object> result = FuncTools.mapper(arr, new Callback());       
System.assertEquals(2, result.size());
System.assertEquals('AA', ((Account)result[0]).Name);
System.assertEquals('BA', ((Account)result[0]).Name);

```

* **Filter** Function
```java
private class Callback implements FunctionalInterface {
    public Object execute(Object o) {
        return Math.mod((Integer) o, 2) == 0;
    }
}

List<Integer> ints = new List<Integer> {1, 2, 3, 4};
                
List<Object> result = FuncTools.filter(ints, new Callback());

System.assertEquals(2, result.size());
System.assertEquals(2, (Integer)result[0]);
System.assertEquals(4, (Integer)result[1]);
```

* **Reduce** Function
```java
private class Callback implements FunctionalInterface2 {
    public Object execute(Object acc, Object i) {
        return (Integer)acc + (Integer)i;
    }
}

List<Integer> ints = new List<Integer>{1, 2, 3, 4};
Object result = FuncTools.reduce(ints, new Callback(), 0);

System.assertEquals(10, (Integer) result);
```

## Usage - FList class
This is a wrapper immutable class which provides a better syntax for Lists.

Here is an example:
```java
private class NumbersGreaterThan2 implements FunctionalInterface {
    public Object execute(Object o) {
        return (Integer)o > 2;
    }
}
    
private class DoubleNumbers implements FunctionalInterface {
    public Object execute(Object o) {
        return (Integer)o * 2;
    }
}
    
private class Sum implements FunctionalInterface2 {
    public Object execute(Object o1, Object o2) {
        return (Integer)o1 + (Integer)o2;
    }
}

FList l = new FList(new List<Integer> {1, 2, 3, 4});
Object result = l.filter(new NumbersGreaterThan2())
                 .mapper(new DoubleNumbers())
                 .reduce(new Sum(), 0);
        
System.assertEquals(14, (Integer)result);
```

The class contains the following methods
* constructor - Pass in a List of Objects to create a FList
* add(**Object**) - Creates a new FList by cloning the old list and adding the item
* get(**Integer**) - Gets the element at the index
* cloneList() - Returns a clone of the list
* mapper(**FunctionalInterface** f) - Returns a new FList and runs the mapping function
* filter(**FunctionalInterface** f) - Returns a new FList and runs the filtering function
* reduce(**FunctionalInterface2** f, **Object** initialValue) - Returns an object by running the reducing function for each element of the list