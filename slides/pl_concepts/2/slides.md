---
date: 24 August 2017
title: Object Lifetime and Pointers
subtitle: CSCI 400
author: Colorado School of Mines
theme: Amsterdam
...

Why do we care?
---------------

Could affect:

-   \hl{Performance}
-   \hl{Reliability}
    -   e.g. Ease of debugging
-   \hl{Language choice}

Object Lifetime
---------------

-   \kwd{Lifetime of a variable}
    -   Time during which the variable is bound to a particular memory cell
-   Ruby built-in objects created when value assigned
    -   e.g. `x = 5`{.ruby}
    -   Other classes create with `new`{.ruby}
-   Factory methods also create objects
-   Ruby uses \hli{garbage collection}
    -   Destroys objects that are no longer reachable

Object Lifetimes
---------------

1.  \hl{Static}
2.  \hl{Stack dynamic}
3.  \hl{Explicit heap}
4.  \hl{Implicity heap}

Variables by Lifetime: (1) Static
---------------------------------

### Static

-   Bound to memory cells \hli{before execution begins}
-   Remains bound to same memory \hli{throughout execution}
-   All FORTRAN 77 variables, C `static`{.ruby} variables
    -   But \hli{not} C++ class variables

Variables by Lifetime: (1) Static
---------------------------------

-   \hli{Advantages}
    -   Efficiency -- direct addressing
    -   History-sensitive subprogram support (TODO: what?)
-   \hli{Disadvantages}
    -   Lack of flexibility (no recursion TODO???)
    -   Storage can't be shared among subprograms (TODOagain: what?)

Variables by Lifetime: (1) Static
---------------------------------

TODO: 'Quick Ex'?

Where are static vars stored?
-----------------------------

(Assuming C/C++)


