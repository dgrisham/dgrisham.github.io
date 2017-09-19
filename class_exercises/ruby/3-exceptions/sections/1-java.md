Java
====

Terminology Review
------------------

**Exception**: Anomalous or exceptional conditions that require special
processing; disrupts the normal excecution.

An exception is **raised**/**thrown** when some sort of event/condition occurs.

The **exception handler** code determines what to do.

Advantages of Exceptions
------------------------

-   Error detection code is tedious to write and tends to clutter programs -- we
    don't want the core program logic to be obscured by error detection.
-   Exception *propagation* allows a high level of reuse of exception handling
    code.
-   Exceptions encourage programmers to consider all events that could occur
    that may need to be handled -- especially when *checked* exceptions are
    used.

Exception Propagation
---------------------

Exception propagation refers to the idea that an exception will propagate up the
call stack until it is caught. If the exception isn't handled before or by the
`main()` function, then execution terminates. If the exception is handled,
execution continues after the `try`/`catch` block that caught the exception.
Java and C++ both propagate exceptions in this way.

Java Exception Handling
-----------------------

The Java library includes two subclasses of `Throwable`:

1.  `Error`
    -   Thrown by the Java interpreter for events like heap-overflow
    -   Never handled by user programs
2.  `Exception`
    -   This is the parent class of most user-defined exceptions
    -   Has two predefined subclasses:
        a.  `IOException`
        b.  `RuntimeException`

Checked and Unchecked Exceptions
--------------------------------

Exceptions of the `Error` and `RuntimeException` classes, as well as all of
their descendants, are called **unchecked exceptions**. All other exceptions are
called **checked exceptions**, which are exceptions that the compiler ensures
your code handles in some way.

Methods containing code that can throw a checked exception must either:

1.  List the exception(s) in a `throws` clause, *or*
2.  Handle the exception (e.g. with `try`/`catch`)

Example `throws` clause:

```java
public void function() throws Exception
```

Remember, this does code does *not* throw an exception itself -- it just tells
the compiler (and other programmesr) that the function *might* throw an
exception of type `Exception`.

A few common misconceptions regarding checked exceptions:

-   'Checked' means that the Java compiler checks that your code knows a line of
    code *can* generate an error (and that your code handles it in some way)
-   The compiler does *not* know whether an exception will occur -- just that it
    *might*
-   *All* exceptions occur at *runtime*

Details of Java Exception Handling
----------------------------------

A method that calls a method with a checked exception in its `throws` clause has
3 options for handling:

1.  Catch and handle the exception
2.  Catch the exception and throw another exception (which must be listed in its
    own `throws` clause)
3.  Declare that exception in its `throws` clause and leave it unhandled

An example of each of these cases is shown in the following code block:

```java
// function that throws BadException
public void A() throws BadException {
    // ...
}

// 1. Catch and handle the exception
public void B() {
    try {
        A()
    } catch (BadException e) {
        // ... 
    }
}

// 2.  Catch the exception and throw another exception
public void C() throws AnException {
    try {
        A()
    } catch (BadException e) {
        throw (AnException) 
    }
}

// 3.  Declare that exception in its `throws` clause and leave it unhandled
public void D() throws BadException {
    // ...
    A()
    // ...
}
```

`NullPointerException`
----------------------

Imagine if Java's `NullPointerException` was a checked exception -- since
*every* reference in Java can be `null`, `every` method that returns anything
would have to include `throws NullPointerException` in its signature. This would
be impractical for programmers, and clutter the code quite a bit.

As an example, check out this (somewhat contrived) example, where we ensure
that every `NullPointerException` is handled in some way.:

```java
float distance(Point p1, Point p2) throws NullPointerException {
    int x1, y1, x2, y2;

    try {
        x1 = p1.getX();
    catch (NullPointerException e) {
        System.out.println("p1's x value is null");
        // handle exception...
    }
    try {
        y1 = p1.getY();
    catch (NullPointerException e) {
        System.out.println("p1's y value is null");
        // handle exception...
    }
    try {
        x2 = p2.getX();
    catch (NullPointerException e) {
        System.out.println("p2's x value is null");
        // handle exception...
    }
    try {
        y2 = p2.getY();
    catch (NullPointerException e) {
        System.out.println("p2's y value is null");
        // handle exception...
    }

    return euclideanDistance(x1, y1, x2, y2);
}

float euclideanDistance(int x1, int y1, int x2, int y2) throws NullPointerException {
    // ...
}
```

Note that, in the above example, we catch every `NullPointerException` because
that aids in debugging -- if we simply re-threw all of the
`NullPointerException`s to the calling function, then there would be no
information as to *which* variable caused the exception in the first place.

This illustrates one of the issues with `null` in many languages: While it's a
common design pattern that is easy to use, languages often don't provide
practical means of handling the errors that they can cause.

Overriding Methods
------------------

A method cannot declare more exceptions in its `throws` clause than the method
it overrides. For example, if you override `run` in a `Thread` subclass, you
cannot add a `throws` clause.

Java's `finally`
----------------

`finally` can appear at the end of a `try`/`catch` block:

```java
try {
    // ...
} catch (Exception e) {
    // ...
} finally {
    // ...
}
```

The purpose of `finally` is to specify code that must be executed *regardless of
what happens in the `try` block*. Examples include closing a file or connection
to a database. `finally` is executed *even if there is a `return` statement in
the `try`/`catch` block*.

Exercise
--------

### Preparation

1.  Download and import [exceptions.zip](../src/java_exceptions.zip)
2.  Read about the `finally` clause in [this link](http://www.javapractices.com/topic/TopicAction.do?Id=25)

#### `PropagateDemo`

-   Move the `try`/`catch` block from `doExample()` to `main()`. Notice you'll
    need a `throws` clause on `doExample()`
    -   Remember exceptions are thrown at runtime, but the compiler forces you
        to acknowledge checked exceptions at compile time.
-   Notice that the `throws` clause can specify `BadDataException` *or*
    `Exception`. Why?
-   Change `BadDataException` to extend `RuntimeException`. Is the `throws`
    clause still needed?
    -   Answer: No. But this does *not* mean the exception can't be thrown, just
        that the compiler doesn't force you to acknowledge it.
-   Propagate: means the error is passed to the caller to handle. That's why we
    can move `try`/`catch` to `main()`.

### `CheckedAndUnchecked`

`ArrayOutOfBounds` is good example of unchecked exception.
`NullPointerException` is also unchecked. Why would Java designers choose to
make these unchecked? What would your code look like if they were checked?

### `FinallyDemo` and `FinallyDemo2`

Note that `finally` is called before `return`, even if no error ocurred.

### On Paper

1.  When do you need a `throws` clause?
2.  Explain the difference between *checked* and *unchecked* exceptions.
3.  What does it mean for an error to be *propagated*?
4.  How does `finally` work? What is the purpose?
