---
date: 29 August 2017
title: Ruby Control Flow
subtitle: CSCI400
theme: Amsterdam
...

Color Key
---------

-   [\link{Clickable URL link}](https://www.youtube.com/watch?v=UyoYf7rZVGI)
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Standard Control Flow
---------------------

-   \hl{Selection} statements
-   \hl{Iterative} statements
-   Unconditional branching
-   Not covered: Guarded commands

Conditionals
------------

```ruby
if expr1 # newline after expr
    # code
elsif expr2
    # code
...
else
    # code
end # `end` always required
```

\hl{Conditional is executed} if `expr`{.ruby} is \hli{not} `false`{.ruby} or
`nil`{.ruby}

Conditional return value
------------------------

Return value is last expression executed \hli{or} `nil`{.ruby}

```ruby
x = 5
# note the lack of `return`
name = if x == 1 then "Cyndi" else "Nancy" end
puts name
```

Expression Modifier
-------------------

`if expr then code end`{.ruby} equivalent to `code if expr`{.ruby}

Best practice: use latter form when `expr`{.ruby} is trivial or normally true

\comment{Perl also has this syntax}

Other conditionals: `unless`
----------------------------

```ruby
unless expr
    # code
end
# or
code unless expr
```

Other conditionals: `case`/`when`
---------------------------------

```ruby
tax = case income
    when 0..7550
        income * 0.1
    when 7550..30650
        income * 0.15
    when 3065..50000
        income * 0.25
    else
        income * 0.4
end
```

\comment{Compare to `switch`; consider readability}

Iteration
---------

+----------------+-----------------+
| `while`{.ruby} | `until`{.ruby}  |
+================+=================+
| ```ruby        | ```ruby         |
| while expr do  | until expr do   |
|     # code     |     # code      |
| end            | end             |
| # or           | # or            |
| code while expr| code until expr |
| ```            | ```             |
+----------------+-----------------+

\comment{Pascal had }`repeat...until...`{.pascal}

More Iteration
--------------

```ruby
# do is optional, can use newline
for var in collection do
    # code
end
```

```ruby
hash.each do |key, value|
    puts "#{key} => #{value}"
end
```

Iterators
---------

-   `<int>.times`{.ruby}
    -   `2.times { puts "again!" }`{.ruby}
-   `<enumerable>.each`{.ruby}
    -   `array.each { |x| puts x }`{.ruby}
-   `<enumerable>.map`{.ruby}
    -   `[5, 10, 15].map { |x| x * x * x }`{.ruby}
-   `<int>.upto`{.ruby}, `<int>.downto`{.ruby}
    -   `factorial = 1; 2.upto(20) { |x| factorial *= x }`{.ruby}
-   Make use of `yield`{.ruby} (next slide)

`yield`
-------

`yield`{.ruby} temporarily returns control from iterator to calling method

### Exercise

-   \q{Trace the code on the next two slides}
-   Format is flexible
    -   Draw arrows, etc. Just show you understand
-   \hl{Discuss} when/why might this be useful?
    -   We'll discuss as a class

`yield` example (1)
-------------------

`yield`{.ruby} temporarily returns control from iterator to calling method

```ruby
def test
    puts "You are in the method"
    yield
    puts "You are back in the method"
    yield
end

test { puts "You are in the block" }
```

\hli{Method must be invoked with a block} (which is the code that is
`yield`{.ruby}ed to)

`yield` example (1)
-------------------

\hl{Result of running code on previous slide:}

```
You are in the method
You are in the block
You are back in the method
You are in the block
```

`yield` example (2)
-------------------

```ruby
def test
    yield 5
    puts "You are in the method 'test'"
    yield 100
end

test { |i| puts "You are in the block: #{i}" }
```

`yield` example (2)
-------------------

```
You are in the block: 5
You are in the method test
You are in the block: 100
```

\comment{Java: caller controls iteration}

\comment{Ruby: iterator controls iteration}

Discussion
----------

When/why might `yield`{.ruby} be useful?

`yield` in-class challenge
--------------------------

-   Write code similar to '`yield`{.ruby} example 2' that:
    -   Displays the modulo 15 of all integers within `[100, 91]`
    -   Your `yield`{.ruby} expression should provide \hli{two} values
-   \hl{Hint:} in the output below, what changes and what stays the same?
```
100 modulo 15 is 10
99 modulo 15 is 9
98 modulo 15 is 8
97 modulo 15 is 7
96 modulo 15 is 6
```
-   Nothing to submit

Language Design: Importance of Blocks
-------------------------------------

[\link{Read this}](http://www.artima.com/intv/closures.html)

