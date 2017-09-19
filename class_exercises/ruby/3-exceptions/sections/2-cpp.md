C++
===

Background
----------

Mechanisms for exception handling were added to C++ in 1990. Exceptions
themselves are user- or library- defined -- the language itself does not provide
any actual exceptions, just means of handling them.

Catching Exceptions
-------------------

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

Throwing Exceptions
-------------------

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

Concrete Example
----------------

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

Unhandled Exceptions and Propagation
------------------------------------

An unhandled exception is *propagated* to the calling function, and this
propagation continues up to the `main` function if it goes unhandled. If no
matching handler is found through the entire propagation, the default handler
(`unexpected`) is called. This default handler simply terminates the program.
(*Note:* The default handler may be replaced by a user-defined handler, which
must be a `void` function that takes no parameters).

### Propagation Example

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

Download the [example program](../src/exceptions.cpp) and run it to see out it
works. To build, try `g++ exceptions.cpp`.

Exercise
--------

**Note: You can skip this exercise for now so that you have time to get through
all of the class exercise today, but be sure to come back and complete this
later.**

Modify the program so that it has another exception named
`FailingInputException`. If the user inputs a grade less than 60, the program
should display a message that we don't allow failing grades and then continue
accepting grades. The totals should be revised so that only 4 totals are
displayed.

### Original code execution

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

### Revised code execution

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
