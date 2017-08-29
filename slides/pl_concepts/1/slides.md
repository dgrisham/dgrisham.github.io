---
date: 24 August 2017
title: Language Principles
subtitle: CSCI 400 -- Lecture 1
author: Colorado School of Mines
theme: Amsterdam
...


Binding
=======

The Concept of Binding
----------------------

-   \kwd{Binding:} an association/mapping
    -   Type to variable: `int x`{.c}
    -   Operation to symbol: `x * y`{.c}, `*ptr`{.c}
    -   Function to definition: `int main() { ... }`{.c}
-   \kwd{Binding time:} time at which binding takes place
-   \kwd{Bindings} may be
    -   *Static* or *dynamic*
    -   *explicit* or *implicit*

Possible Binding Times (1)
--------------------------

-   \hli{Language design time}
    -   Bind operator symbol (e.g. `+`) to meaning/operation
        -   `sum = sum + count`
        -   `sum = "Hello" + name`
-   \hli{Language implementation time}
    -   Bind type to representation
        -   `char` \ra 8 bits, etc.
-   \hli{Compile time}
    -   Bind variable to type
        -   `int sum`{.c}

Possible Binding Times (2)
--------------------------

-   \hli{Link time}
    -   Bind library subprogram to code
        -   `std::cout << x`{.c}
-   \hli{Load time}
    -   Bind a C `static` variable to memory address
-   \hli{Runtime}
    -   Bind a non-static local variable to a memory address

Static vs. Dynamic Binding
--------------------------

-   A \kwd{static} binding...
    1.  First occurs \hli{before runtime}
    2.  \hl{and} remains \hli{unchanged} throughout execution
-   A \kwd{dynamic} binding...
    1.  First occurs \hli{during execution}
    2.  \hl{or} it can \hli{change during execution}


Static vs. Dynamic
==================

Static vs. Dynamic: Usage
-------------------------

Show up in various contexts:

-   \hl{Variable typing}
-   Variable lifetime
-   Variable scope
-   Polymorphism
    -   Overloaded operators vs. late binding

\comment{Not to be confused with `static` keyword used in OO}

Dynamic Type Binding
--------------------

-   Type \hl{not} specified by \hl{declaration}
    -   Javascript, PHP, Ruby, Python
-   Specified through assignment statement
    -   `list = [2, 4.33, 10, 15]`{.python}
    -   `list = 17.3`{.python}

Dynamic Type Binding
--------------------

-   Advantages
    -   Flexibility (**generics**)
        -   e.g. Duck typing
-   Disadvantages
    -   High cost (**run-time descriptors**)
    -   Compiler can miss many type errors

Explore Generics
----------------

-   Read this:
    -   <https://en.wikipedia.org/wiki/Generics_in_java>
-   With a partner
    -   Read the definition of a \hl{type variable}
    -   Look at how `List` is defined (section: **Motivation**)
        -   \q{What is the type variable? How is it used?}
    -   Read/understand the `Entry` class (section: **Generic class definitions**)

Explore Generics
----------------

-   Read this:
    -   <http://www.tutorialspoint.com/cplusplus/cpp_templates.htm>
-   Discuss the `Stack` example
-   Syntax not important, but understand templates/their purpose

Assume you're desigining a language with dynamic typing
-------------------------------------------------------

-   \q{How would you implement dynamic types?}
    -   \q{What data structure(s) would you use?}
-   \q{How does this impact code in this language?}
    -   Consider *efficiency*, *reliability*
-   Now consider challenges with `+`
    -   `total = 3 + 5`
    -   `message = "hello " + "world"`
    -   `something = "count" + 3 + 5`
    -   \q{Would these be a challenge for either a compiler or runtime system?}

Dynamic Typing Reliability
--------------------------

### Issue

```{.python}
i = x # desired, x is scalar
i = y # typed accidentally, y is array
```

-   Possibly very difficult to find source of error
-   Well-implemented static typing can catch this


Strong vs Weak Typing
======================

Definitions
-----------

\hli{Definitions of strong/weak typing are not precise.}

-   \kwd{Strong typing}
    -   Generally, \hli{compiler error} if value does not meet expected type
    -   \hl{Dynamically typed language:} might be considered strongly typed if
        type errors are \hli{prevented at runtime}
-   \kwd{Weak typing} 
    -   Types can be used interchangeably

Features regarded as 'weaker'
-----------------------------

-   \hl{Implicit type conversations}
-   Pointers\Noteref
-   Untagged unions\Noteref

\Note{covered later}

Type Conversions
----------------

-   \hl{Widening} conversions
    -   Exact or close-approximation to all of values in original type
    -   `byte` \ra `short` \ra `int` \ra `long` \ra `float` \ra `double`
-   \hl{Narrowing} conversions
    -   Cannot include all values of original type
    -   `double` \ra `float` \ra `long` \ra `int` \ra `short` \ra `byte`

Type Conversions: Dangerous?
----------------------------

-   \hl{Widening conversions may lose accuracy}
    -   32-bit `int` \ra 32-bit `float` (Lose 2 digits of precision, `float`
        uses 8 bits for exponent)
-   Conversions should be used with care
    -   Warnings should not be ignored
-   \hl{Strongly typed languages minimize implicit type conversions}

Implicit Type Conversions
-------------------------

-   Language will try to convert types behind-the-scenes if necessary
    -   Programmer must be aware
    -   Compiler/interpreter should inform programmer
-   More \hl{implicit type conversions} \ra considered more \hl{weakly typed}
    -   C supports more implicit conversions than Java

Explore Implicit Conversions
----------------------------

<http://en.cppreference.com/w/cpp/language/implicit_conversion>

-   \q{Write a line of code that illustrates one of the scenarios}
-   Section: **Array to pointer conversion**
    -   \q{Draw a picture and 1-2 lines of code that illustrate}
    -   \q{e.g. code might show how to access a value before and after
        conversion}

Explore Implicit Conversions
----------------------------

<https://www.securecoding.cert.org/confluence/pages/viewpage.action?pageId=3416>

-   *Did you know*: C`++` will do an implicit conversion if there is a
    single-arg constructor that will do the needed conversion?


More on Types
=============

Type Safety
-----------

-   \hl{The extent to which a PL discourages/prevents type errors}
-   \kwd{Type error}
    -   Erroneous or undesirable program behavior
    -   Caused by discrepancy between different data types
    -   e.g. passing `int` to function that expects a `string`
-   \kwd{Type enforcement}
    -   \hli{Static:} compile time
    -   \hli{Dynamic:} runtime

Explicit vs. Implicit
---------------------

-   \kwd{Explicit:} stated by programmer
-   \kwd{Implicit:} determined by language
-   Contexts
    -   \hl{Type declaration}
    -   Variable lifetime

\comment{Note: These are {\it not} the same as static/dynamic.}

Explicit/Implicit Declaration
-----------------------------

-   \kwd{Explicit declaration}
    -   Program statement used for declaring variable types.
        -   `int count;`{.c}
-   \kwd{Implicit declaration}
    -   \hl{Default mechanism} for specifying variable types.
-   Both create \hli{static bindings} to types
    -   Type doesn't change during execution

Implicit Declaration
--------------------

-   Dynamic typing (e.g. Python, Ruby, Lisp)
    -   \hl{No} type annotations
    -   Typechecking at \hli{runtime}
    -   Writeability at the \hli{cost} of Reliability
-   Static type-inference (e.g. Haskell, Rust, OCaml)
    -   \hl{Optional} type annotations
    -   \hli{Compiler} type-checks program
    -   \hli{Balance} between writeability and reliability


Other Concepts
==============

Keywords vs. Reserved Words
---------------------------

### \kwd{Keyword}

-   \hl{Has a special meaning in a particular context}
-   \hl{Can be used as a variable name}
-   Older languages
    -   Algol, PL/I, Fortran

Keywords vs. Reserved Words
---------------------------

### \kwd{Reserved}

-   \hl{Can't be used as variable name}
-   COBOL has ~400, Java has ~50
-   \hl{Advantage:} May avoid confusion
-   \hl{Disadvantage:} Awareness of language parts you aren't even using

Keywords vs. Reserved Words
---------------------------

-   Potentially valid Fortran:
    -   `if if then then else else`
-   Java: `goto` is...
    -   \hl{Reserved} (you can't use it)
    -   \hl{Not a keyword} (language doesn't use it)
-   Functions in libraries are neither keywords nor reserved words
    -   Can sometimes cause confusion

Unconditional Branching
-----------------------

-   Transfers execution control to specified place in program
-   Topic of one of the most heated debates in 1960s/70s
-   Well-known mechanism: `goto`
    -   Concern: Readability, reliability (maintenance)
    -   Most modern languages do not have `goto`
-   Languages with `goto`
    -   Assembly languages, C
    -   C# -- limited to `switch` statements

Links
-----

-   [Tony Hoare on the harm of `NULL`](https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare)
    -   This page might be kind of confusing -- you want the video on the top
        right
-   [Edgar Dijkstra on the harm of `goto`](http://www.u.arizona.edu/~rubinson/copyright_violations/Go_To_Considered_Harmful.html)

