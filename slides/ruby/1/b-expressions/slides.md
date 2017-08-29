---
date: 29 August 2017
title: Ruby Expressions & Operators
subtitle: CSCI400
theme: Amsterdam
...

Color Key
---------

-   [\link{Clickable URL link}](https://www.youtube.com/watch?v=n3SxjX--x3U)
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Method Invocation
-----------------

-   `puts "yes"`{.ruby}
    -   Global method, provided by `Kernel`{.ruby}
-   `Math.sqrt 2`{.ruby} test
    -   `Math`{.ruby} object, method `sqrt`{.ruby}
-   `message.length`{.ruby}
    -   Object `message`{.ruby}, method `length`{.ruby}, no args

\comment{Compare to other languages}

Method Invocation
-----------------

-   `a.each { |x| puts x }`{.ruby}
    -   Object `a`{.ruby}, method `each`{.ruby}, block arg
-   `a[0] = a[1]`{.ruby}
    -   `a.[](0)`{.ruby}, object `a`{.ruby},  method `[]=`{.ruby}, arg
        `0`{.ruby}
    -   `a.[](1)`{.ruby}, object `a`{.ruby},  method `[]`{.ruby}, arg
        `1`{.ruby}
-   `x + y`{.ruby}
    -   `x.+(y)`{.ruby}

\comment{Compare to other languages}

Assignment
----------

-   `lvalue = rvalue`
    -   `lvalue` must be address, `rvalue` must be value

```ruby
x = 1
x += 1 # 'abbreviated assignment pseudooperators'
x, y, z = 1, 2, 3 # parallel assignment
x = y = 0 # chained assignment, right-associative
MAX = 5; MAX = 6 # changing a 'constant' -- not
                 # really, but Ruby gives warning
```

`||=`
-----

-   \hl{Goal}: assign array if it exists, otherwise assign a new one
    -   `results = results || []`{.ruby}
-   `results ||= []`{.ruby}
    -   How does this work? (Recall: Short-circuit evaluation)
    -   `lvalue` must be `nil`{.ruby} or `false`{.ruby}
-   Example of a Ruby \hli{idiom}
    -   \hl{Programming idiom}: means of expressing recurring construct or
        simple task. Important for fluency in a language.

More Parallel Assignment
------------------------

```ruby
x, y = y, x     # swap
x = 1, 2, 3     # x => [1,2,3]
x, y = [1, 2]   # same as x = 1; y = 2
a, b, c = 1, 2  # a = 1; b = 2; c = nil
x, *y = 1, 2, 3 # x = 1, y = [2, 3]
*x, y = 1, 2, 3 # x = [1, 2]; y = 3
```

-   `*`{.ruby} \comment{is called 'splat'; can only have one per assignment}

Operators
---------

-   Typical \hl{associativity rules}
    -   Left \ra right, except assignment and `**`{.ruby}
    -   Sometimes unary operators associate right \ra left
-   Typical \hl{precedence}
    -   Parentheses
    -   Unary operators
    -   `**`{.ruby} (if language supports it)
    -   `*`{.ruby}, `/`{.ruby}, `%`{.ruby}
    -   `+`{.ruby}, `-`{.ruby}
-   APL is different: all ops have equal precedence and associate right \ra left
    (can override these rules with parenthesis). \comment{Would this be more or
    less confusing?}

Ambiguity
---------

-   Local variables and method names start with lowercase letter
-   So...how does Ruby distinguish between the two?
-   If prior assignment \ra variable. Otherwise \ra method invocation.

Conditional Expressions
-----------------------

-   C, C`++`, Perl, Javascript, Ruby all have these
-   Often use \hli{ternary operator} (`?:`{.ruby})

Example:

```ruby
average = (count == 0) ? 0 : sum / count
# above is the same as:
if count == 0
    average = 0
else
    average = sum / count
```
