Exception Handling
==================

The following sections discuss exception handling in 3 languages: C++, Java, and
Ruby. For each language, you'll read through the background/review information
for that language, then complete a short exercise related to exception handling
in the language.

Exception handling is another one of those concepts that seems less important
when you're writing code for a course, but becomes crucial in production code.
Languages vary quite a bit in the tools they provide for exception handling --
for example, the general approach taken by Java, C++, Ruby, and Python (TODO:
verify) is syntactically noisier and semantically less orthogonal than that
taken by Go; Haskell lets the programmer build error handling into the datatypes
(TODO: review/check wording), so that the program logic code is completely
separate from the error handling code.

Java
----

### Terminology Review

**Exception**: Anomalous or exceptional conditions that require special
processing; disrupts the normal excecution.

An exception is **raised**/**thrown** when some sort of event/condition occurs.

The **exception handler** code determines what to do.

### Advantages of Exceptions

-   Error detection code is tedious to write and tends to clutter programs -- we
    don't want the core program logic to be obscured by error detection.
-   Exception *propagation* allows a high level of reuse of exception handling
    code.
-   Exceptions encourage programmers to consider all events that could occur
    that may need to be handled -- especially when *checked* exceptions are
    used.

### Exception Propagation

Exception propagation refers to the idea that an exception will propagate up the
call stack until it is caught. If the exception isn't handled before or by the
`main()` function, then execution terminates. If the exception is handled,
execution continues after the `try`/`catch` block that caught the exception.
Java and C++ both propagate exceptions in this way.

### Java Exception Handling

The Java library includes two subclasses of `Throwable`:

1.  `Error`
    -   Thrown by the Java interpreter for events like heap-overflow
    -   Never handled by user programs
2.  `Exception`
    -   This is the parent class of most user-defined exceptions
    -   Has two predefined subclasses:
        a.  `IOException`
        b.  `RuntimeException`

### Checked and Unchecked Exceptions

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

### Details of Java Exception Handling

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

### `NullPointerException`

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

### Overriding Methods

A method cannot declare more exceptions in its `throws` clause than the method
it overrides. For example, if you override `run` in a `Thread` subclass, you
cannot add a `throws` clause.

### Java's `finally`

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

### Exercise

#### Preparation

1.  Download and import [exceptions.zip](TODO)
2.  Read about the `finally` clause in [this link](http://www.javapractices.com/topic/TopicAction.do?Id=25)

##### `PropagateDemo`

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

#### `CheckedAndUnchecked`

`ArrayOutOfBounds` is good example of unchecked exception.
`NullPointerException` is also unchecked. Why would Java designers choose to
make these unchecked? What would your code look like if they were checked?

#### `FinallyDemo` and `FinallyDemo2`

Note that `finally` is called before `return`, even if no error ocurred.

#### On Paper

1.  When do you need a `throws` clause?
2.  Explain the difference between *checked* and *unchecked* exceptions.
3.  What does it mean for an error to be *propagated*?
4.  How does `finally` work? What is the purpose?

C++
---

### Background

Mechanisms for exception handling were added to C++ in 1990. Exceptions
themselves are user- or library- defined -- the language itself does not provide
any actual exceptions, just means of handling them.

### Catching Exceptions

C++ exceptions follow the form:

```cpp
try {
    // code that may raise an exception
} catch (/* exception parameter */) {
    // handler code
} catch (/* exception parameter */) {
    // handler code
}
// ...
```

`catch` is the name of all *handlers* in C++ -- it is an overloaded name, so the
*exception parameter* of each must be unique. You do not need to specify a
variable name to store the value of the parameter, you can simply specify the
type -- e.g. `catch(int)`, as opposed to `catch(int i)`. A parameter variable is
often useful, though, as it transfers information to the handling code. The
parameter may also simply be an ellipses: `catch(...)`, which is an exception
catch-all (compare to Java).

After a handler completes its execution, control flows to the first statement
after the `try`/`catch` block that handled the exception.

### Throwing Exceptions

Exceptions are explicitly raised by a `throw` statement:

```cpp
throw expression;
```

where `expression` may be any type (compare to Java).

A `throw` without an argument can only appear in a handler -- this simply
re-raises the exception, which should be handled elsewhere.

```cpp
try {
    // code that may raise an exception
} catch (string s) {
    // handler for string exceptions
} catch (...) {
    // throw all other exceptions
    throw;
}
```

### Concrete Example

```cpp
int num;
char ch;
double dNum;

try {
    std::cout << "Enter int from 1 - 100: ";
    std::cin >> num;
    if (num < 1 || num > 100) {
        throw num;
    }

    std::cout << "Enter 'A' or 'B' : ";
    std::cin >> ch;
    if (ch != 'A' && ch != 'B') {
        throw ch;
    }

    std::cout << "Enter double 1.1 - 1.5: ";
    std::cin >> dNum;
    if (dNum < 1.1 || dNum > 1.5) {
        throw dNum;
    }
} catch (int numIn) {
    std::cout << numIn << "is not in the specified range\n";
} catch (char charIn) {
    std::cout << charIn << "is not A or B\n";
} catch (...) {
    std::cout << "Invalid input!\n";
}
```

### Unhandled Exceptions and Propagation

An unhandled exception is *propagated* to the calling function, and this
propagation continues up to the `main` function if it goes unhandled. If no
matching handler is found through the entire propagation, the default handler
(`unexpected`) is called. This default handler simply terminates the program.
(*Note:* The default handler may be replaced by a user-defined handler, which
must be a `void` function that takes no parameters).

#### Propagation Example

```cpp
int doInput() {
    int num;
    std::cout << "Enter a number from 1-100: ";
    std::cin >> num;
    if (num < 1 || num > 100) {
        throw num; 
    }
    return num;
}

int main() {
    int num;
    try {
        doInput() 
    } catch (int numIn) {
        std::cout << numIn << " is not in the range\n"; 
        system("pause");
        exit(1);
    }

    std::cout "Continuing on...\n";
    system("pause");
}
```

Download the [example program](src/exceptions.cpp) and run it to see out it
works. To build, try `g++ exceptions.cpp`.

### Exercise

Modify the program so that it has another exception named
`FailingInputException`. If the user inputs a grade less than 60, the program
should display a message that we don't allow failing grades and then continue
accepting grades. The totals should be revised so that only 4 totals are
displayed.

#### Original code execution

```
Please input a grade or -1 to end: 100
Please input a grade or -1 to end: 50
Please input a grade or -1 to end: 67
Please input a grade or -1 to end: 92
Please input a grade or -1 to end: -1
End of input data reached
Limits Frequency
0 9 0
10 19 0
20 29 0
30 39 0
40 49 0
50 59 1
60 69 1
70 79 0
80 89 0
90 100 2
Press any key to continue . . .
```

#### Revised code execution

```
Please input a grade or -1 to end: 100
Please input a grade or -1 to end: 50
We don't allow failing grades!
Continuing with grades
Please input a grade or -1 to end: 67
Please input a grade or -1 to end: 92
Please input a grade or -1 to end: -1
End of input data reached
Limits Frequency
60 69 1
70 79 0
80 89 0
90 100 2
Press any key to continue . . .
```

**Note:** This is *not* a good use of exceptions. The point is really to
contrast the mechanics of C++ and Java.

### Hint

There are two `try`/`catch` blocks. Be sure to add your new exception to the
correct one.

Ruby
----

*Similar concepts, different syntax...*

-   Exceptions are *raised* using the `raise` method of the `Kernel` class
-   The `rescue` clause is used the handle exceptions
-   Exceptions are instances of the `Exception` class (or subclasses thereof)
    -   Subclasses *do not* add methods or behavior. They *do* allow exceptions
        to be categorized.
-   Most exceptions extend `StandardError`
    -   Other exceptions are low-level, typically not handled by programs

### Exception Methods

Methods that can be used to get information about an particular exception:

-   `message`
    -   Returns a `String` 
    -   More suitable for programmers than end users
-   `backtrace`
    -   Returns the call stack as an array of `String`s
    -   Lines of the form: `<filename>:<line_number>:in <method_name>

### Raising an Exception

`fail` is a synonym of `raise` -- it's meant to be used if you expected the
program to end as a result of the exception.

There are several ways to invoke `raise`:

-   No arguments
    -   If inside `rescue`, re-raises same exception
    -   Otherwise, raises `RuntimeError`
-   With single `Exception` object argument
    -   Uncommon
-   With single `String` argument
    -   Creates `RuntimeError` with the string arg as the message
    -   *Very* common
-   With `Exception` object, `String` (for `message()`), and an array of strings
    (for `backtrace`)

### Example + Exercise

```{.ruby}
def factorial(n)
    raise "Bad argument" if n < 1
    # raise ArgumentError if n < 1
    # raise ArgumentError, "Exception argument >= 1, got #{n}" if n < 1

    return 1 if n == 1
    n * factorial(n-1)
end
```

You can also provide a custom stack trace:

```{.ruby}
def factorial4(n)
    if n < 1
        raise ArgumentError, "Exception argument >= 1, got #{n}", caller
    end

    return 1 if n == 1
    n * factorial(n-1)
end
```

The above code blocks correspond to the code in `exceptions-1.rb` in the
provided source files. Uncomment the various factorial methods to see different
functionality.

### Catching an Exception

`rescue` is a language keyword (not a `Kernel` method). You can attach a
`rescue` clause to any statement in Ruby -- typically, it's attached to `begin`:

```{.ruby}
begin
    # statements, possible exceptions
rescue
    # code to handle exceptions
end
# if no exception, code continues here -- code in rescue is not executed
```

### Handling Exceptions

`rescue` handles any `StandardError`. The global variable `$!` refers to the
current raised exception, though it is better to specify a variable for the
exception in the `rescue` statement:

```{.ruby}
begin
    x = factorial(0)
    rescue => err
    puts "#{err.class}: #{err.message}"
end
```

### Handling Multiple Types of Exceptions

```{.ruby}
def factorial5(n)
    raise TypeError, "Need integer" if not n.is_a? Integer
    raise ArgumentError, "Need argument >= 1, got #{n}" if n < 1

    return 1 if n == 1
    n * factorial(n-1)
end

begin
    x = factorial5("a")
rescue ArgumentError => ex
    puts "Try again with argument > 1"
rescue TypeError => ex
    puts "Try again with an integer"
end
```

**Question**: Does the order of the `rescue` statements matter?

**Exercise**: In `exceptions-1.rb`, uncomment and run the various `begin`/`end`
blocks that handle exceptions.

### Propagating Exceptions

The following code gives a relatively complex system of exception handling --
**as a quick exercise, try tracing this code through each of the paths it could
take**.

```{.ruby}
def explode
    raise "bam!" if rand(10) == 0
end

def risky
    begin
        10.times do
            # raises error ~10% of time
            explode
        end
    rescue TypeError # won't catch RuntimeError
        puts $!
    end # RuntimeError not handled, will propagate
    "hello" # if no exception
end

def defuse
    begin
        puts risky
    rescue RuntimeError => e # handle propagated error
        puts e.message
    end
end

defuse
```

**Exercise**: After you try to trace the code, try running `exceptions-2.rb` and
check your understanding.

### Other Options

-   `retry`
    -   When used inside a `rescue`, `retry` reruns the block of code that
        raised the exception.
    -   Useful for transient failures, e.g. overloaded server
    -   Number of retries should be limited
-   `ensure`
    -   Same idea as Java's `finally`

### Note on `throw`/`catch`

Ruby has the keywords `throw`/`catch`, but they're not used for handling
exceptions. If you're curious, check out [this blog
post](http://rubylearning.com/blog/2011/07/12/throw-catch-raise-rescue--im-so-confused/),
which is written by this guy:

![Avdi Grimm](img/avdi_grimm.jpg)

Tell me he doesn't look like a guy you can trust, I dare you.

### Exercise

#### Purpose

Understand the *mechanics* of exception handling in Ruby.

#### Preparation

Download [these Ruby source files](src/ruby_exceptions.zip)

Exception Alternatives
----------------------

### Purpose

Explore some error handling ideas that are not as similar to Java/C++.

### Preparation

Read the following links:

1.  <https://davidnix.io/post/error-handling-in-go/>
2.  <http://www.golangpatterns.info/error-handling>
3.  <https://blog.golang.org/defer-panic-and-recover>
4.  <https://www.reddit.com/r/golang/comments/3sfjho/gos_error_handling_is_elegant/>

### Explore

With a partner or small group, discuss and write up brief answers to:

1.  Describe the `Error` type and how it's typically checked in Go (article 1).
2.  Why do you think the author in article 2 does not like the patterns shown
    under **Bad Usage of Errors**?
3.  Compare/contrast `defer`, `panic`, and `recover` in Go to exception handling
    in Java, including the `finally` clause (article 3).
4.  Skim article 4. Several posters mention error handling in languages like
    Haskell. We'll study this later.
5.  Debate among yourselves: Do you like the way Go handles errors? Why or why
    not?

Write your answers on your paper for class participation.
