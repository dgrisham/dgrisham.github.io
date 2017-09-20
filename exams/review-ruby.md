Ruby + PL Concepts Exam Review
==============================

Bloom's Taxonomy
----------------

Bloom's Taxonomy of Education Objects - Cognitive Domain. Placing
questions in specific categories is not that important, but this should
give you an idea of the types of questions.

### BL1: Remembering

-   Syntax, e.g. how to do string interpolation. Not stressed much, mostly you
    will have to read code and remember syntax.
-   Simple facts, such as all classes in Ruby are modules (but not all modules
    are classes).

### BL2: Understanding.

-   Trace code that illustrates some concept, such as `yield`

### BL3: Applying.

-   Given a regular expression, which of several example strings would be valid

### BL4: Analyzing.

-   Explain why recursion is not possible in a language that uses *only* static
    variable lifetimes.
-   Analysis tasks often require you to use what you know about a topic to make
    logical inferences (i.e. the answer may not be found directly on a slide)

### BL5: Evaluating.

-   Comparison tasks, such as describe one difference between a Ruby module that
    is used as a mixin and a Java interface. Describe one similarity.

### BL6: Creating.

-   Make up an example to illustrate a concept, such as immutable data
    structure, heterogeneous array, reference vs. pointer types, etc.

Exam Topics
-----------

### Factors influencing language design (*not on exam*, included as overview of course)

-   Language Evaluation Criteria
    -   Readability
    -   Writeability
    -   Reliability
    -   Cost
-   Topic exploration: expressivity & orthogonality
-   Trade-offs between criteria
-   Computer architecture influences
-   Programming methodology influences
-   Compiled vs. interpreted vs. hybrid

### Ruby Program Structure

-   Statements vs. expressions
-   Block structure

### Data Considerations - Be sure to review!

-   Object lifetime
    -   Static
    -   Stack dynamic
    -   Explicit heap dynamic
    -   Implicit heap dynamic
-   Pointers (usage, issues, etc.)
-   Pointers vs. References
    -   Pointer arithmetic
    -   Assignment
    -   Implicit dereferencing
    -   Explicit dereferencing
    -   Java has reference types, C++ has both
-   Variables, constants, and other program names
    -   Keywords vs. Reserved words
    -   Binding
    -   Explicit vs. implicit declaration
    -   Symbols (Ruby, e.g. `:name`)

### Data types

-   Type conversions
-   Data types in Ruby
    -   Numeric options
    -   Strings: interpolation, mutable
    -   Arrays
    -   Hashes
    -   Ranges
    -   Boolean values

### Functions/methods

-   *Assignment*
    -   Pseudooperators, parallel, lvalue/rvalue
-   *Operators*
    -   Arity, precedence, associativy

### Control Flow

-   Selection
-   Iteration
-   Iterators
-   Ruby yield
-   **Blocks and Procs**
-   Unconditional branching
-   Expression modifier (Ruby syntax)

### Classes

-   Instance variables
-   Encapsulation
-   Object creation
-   Polymorphism -- review Java & C++
    -   From Jan 17 lecture (TODO: remove this date, link actual lecture)
-   Operator overloading
-   **Duck typing**
-   Object class/type
-   Object equality
-   Type-safe methods
-   Object comparisons
-   Class methods and variables

### Extending classes

-   Subclass/Inheritance
    -   Instance variables not inherited
    -   Method visibility
    -   Overriding parent methods
    -   Abstract classes
    -   Chaining methods
    -   Class variables
-   **Modules** - important!
    -   Module vs. Class
    -   Use as namespace
    -   Use as mixin
    -   Diamond Problem in C++
-   Client extensions
    -   Open classes: LSP
    -   Singleton method

### Metaprogramming

-   Reflection
    -   Purpose/uses
    -   Introspection
    -   Reflection methods
-   Internal vs. External DSL
-   `instance\_eval`

### Exception handling

-   Java vs. C++
-   Exception propagation
-   Checked vs. unchecked exceptions (Java)
-   `finally` (Java)
-   Exceptions in Ruby
    -   `raise`, `rescue`
    -   *Not* `throw`/`catch`

### Unit testing

-   Like JUnit3, Minitest
-   Use epsilon for floating point

### Other

-   Regular expressions
-   Character class
    -   e.g. `[0-9]`, `[a-zA-Z]`, `[\^0-9]`, `[aeiou]`
-   Special character classes, only:
    -   `/./`: match any character except newline
    -   `/\\d/`: matches digit, equivalent to `[0-9]`
-   Repetition
    -   `+`: matches one or more occurrences of preceding expression
    -   `?`: matches zero or one occurrence
    -   `*`: matches zero or more
    -   `/\d{3}/`: matches 3 digits
    -   `/\d{3,}/`: matches 3 or more digits
    -   `/\d{3,5}/`: matches 3, 4 or 5 digits
-   Alternatives, e.g. `/cow|pig|sheep/`
-   Anchors
    -   `\^` or `\A` start of line
    -   `\$` or `\Z` end of line
-   You do *not* need to memorize Ruby-specific features (e.g., `Regexp` class)
