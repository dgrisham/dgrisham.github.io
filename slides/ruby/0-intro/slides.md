---
title: Ruby Intro
subtitle: CSCI400
theme: Amsterdam
...

Valuable Reference
------------------

**The Ruby Programming Language**, Flanagan and Matsumoto (creator of Ruby)

\graphicw{img/ruby_book.jpg}{1.5in}

Getting Started
===============

Option 1: REPL
--------------

1.  Open `irb` (interactive ruby)
2.  Try out a ruby command, e.g.
    -   `puts "Who you callin' pinhead?"`{.ruby}
    ```
    Who you callin' pinhead?
    => nil
    ```
    -   `puts` returns `nil`

Option 2: Scripting
-------------------

1.  Open a text editor
2.  Write ruby commands, e.g. 
    -   `puts "My god...it's full of stars!"`{.ruby}
3.  Save file as `demo1.rb`
4.  Open git bash: `ruby demo1.rb`
    -   Must be in same directory as `demo1.rb`

Ruby: General Structure
=======================

Aside: Expressions vs. Statements
---------------------------------

-   \hli{Expressions produce a value}
-   \hli{Statements} generally \hli{do something}
    -   May contain expressions (distinction sometimes blurry)
    -   [\link{Expression vs. statements in Python}](http://stackoverflow.com/questions/4728073/what-is-the-difference-between-an-expression-and-a-statement-in-python)

Ruby Program Structure
----------------------

-   Basic unit is \hli{expression}
-   \hl{Primary expressions}
    -   `true`, `false`, `nil`, `self`, number/string literals, variable
        references
-   \hl{Expression types}: arithmetic, boolean

Ruby Program Structure
----------------------

Code can be organized using:

-   Blocks
-   Methods
-   Classes
-   Modules

Program Execution
-----------------

-   Ruby is a \hli{scripting} language
    -   No special `main` method
    -   Script start at a line 1, execute all lines in order
-   A method/class is defined when the definition is read/executed
    -   \hl{Method calls must come {\it after} the method's definition}

Ruby Expression Structure
-------------------------

-   \hl{Whitespace}: mostly ignored
-   \hl{Expression separators}: newline
-   If statement doesn't fit on one line...
    1.  Insert newline after operator, period, or comma
    2.  \hl{or} escape the newline \Noteref

\Note{Think: How does interpreter recognize tokens/statements?}


Ruby: Basic Constructs
======================

Block Structure
---------------


```ruby
# Block surround by {}
10.times { puts "hello" }
```

```ruby
x = 5
unless x == 10
    # this is the start of an `unless` block
    print x # 'body' of the block
end # this ends an `unless` block
```

\comment{Blocks can be nested. Indent for clarity.}

Ruby Comments
-------------

```ruby
# This is a comment
```

\hl{or}

```ruby
=begin
This is a longer comment. =begin/=end must be
at the start of a line.
=end
```

Variables/Methods
-----------------

-   \hl{Valid variable name identifiers}
    -   letters, numbers, _
    -   Cannot start with number
    -   \hli{Global var:} start with `$`
    -   \hli{Instance, class vars:} start with `@`, `@@` resp.)
-   Conventions
    -   `?`: End method name with `?` if returns boolean
    -   `!`: End method name with `?` if dangerous
-   \hl{Constants, classes, modules:} begin with `A-Z`

Ruby Data Types: Numbers
------------------------

### Numeric

-   `Integer` -- allows base 8, 16, 2
    -   Fixnum: Fit in 31 bits
    -   Bignum: Arbitrary size
-   `Float`
    -   Includes scientific notation
-   `Complex`
-   `BigDecimal`
    -   Uses decimal rather than binary representation
-   `Rational`

A few number-related details
----------------------------

-   `div`: integer division
    -   `7.div 3`{.ruby}
-   `fdiv`: floating point division
    -   `7.fiv 3`{.ruby}
-   `quo`: rational division
    -   In `irb`, try: `(1.quo 3).class`{.ruby}
-   `-7/3 = -3`{.ruby} in Ruby, `-2` in Java/C`++` ([\link{explanation}](https://stackoverflow.com/questions/19873917/why-are-negative-numbers-rounded-down-after-division-in-ruby))
-   Float limits: See `INFINITY`, `MAX` in [\link{this link}](https://ruby-doc.org/core-2.2.0/Float.html)
-   Numbers are immutable (as you'd expect)

Ruby Data Types: Strings
------------------------

-   \hl{String literals}: \hli{single quote}
    -   `'A ruby string'`{.ruby}
    -   `'Don\'t call me Shirley.'`{.ruby}
    -   Only escape `'` or `\`
    -   Newlines are embedded if multi-line
-   \hl{String literals}: \hli{double quote}
    -   Normal escape sequences (`\t`, `\n`, etc.)
    -   \hl{String interpolation}
    ```ruby
    w = 5
    h = 4
    puts "The area is #{w*h}"
    ```

More on strings (1)
-------------------

-   In Ruby, strings are \hli{mutable}
-   `+`: concatenation (interpolation often preferred)
    ```ruby
    age = 32
    puts "I am " + age.to_s
    ```
-   `<<`: append
    ```ruby
    s = "Hello"
    s << " World"
    puts s
    ```

More on strings (2)
-------------------

-   Substring
    -   `puts s[0, 5]`{.ruby}
-   `*`: repeats string
    -   `puts "Alright" * 14`{.ruby}
-   `length`: returns length of `s`
    -   `puts s.length`{.ruby}

Characters
----------

-   Strings of length 1
    -   Changed from Ruby 1.8 \ra 1.9

Methods
-------

-   No `()` needed for function calls. Try:
    -   `"hello".center 20`{.ruby}
    -   `"hello".delete "lo"`{.ruby}
-   Note: if using `()`, \hli{don't put space after function name}
    -   `f (3+2)+1 != f (3+2)+1`{.ruby}
-   Best practice?
    -   [\link{Some thoughts}](https://stackoverflow.com/questions/340624/do-you-leave-parentheses-in-or-out-in-ruby)

String access
-------------

-   Cases with examples
    -   `[i] # puts s[0], puts s[-1]`{.ruby}
    -   `[i, len] # puts s[0, 4]`{.ruby}
    -   `[i..j] # puts s[0..3]`{.ruby}

String Access: Quick Exercise
-----------------------------

-   Try:
    -   `s = "Sunday, Monday, Tuesday, Wednesday,`{.ruby}
        `"Thursday, Friday"`{.ruby}
    -   Extract `"Sunday"`, `"Monday"`, and `"Friday"`
    -   Figure out how to turn `s` into `["Sunday", "Monday", ...
        "Friday"]`{.ruby} [\link{(Hint)}](https://ruby-doc.org/core-2.2.0/String.html#method-i-split)
-   Play with [\link{the Ruby basics file}](https://github.com/dgrisham/csci400/class_exercises/ruby/demo-files/ruby_basics.rb)
-   Nothing to submit, no right answers -- just play!

Get Started
-----------

Do [\link{Ruby intro
homework}](https://github.com/dgrisham/csci400/class_exercises/ruby/0-intro.md)
