---
title: Ruby Methods, Procs, etc.
subtitle: CSCI400
theme: Amsterdam
date: 21 September 2017
...

Color Key
---------

-   [\link{Clickable URL link}]()
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Brief Refactor Exercise (1/2)
-----------------------------

\small

```ruby
def fib(limit)
  i = 1
  yield 1
  yield 1
  a = 1
  b = 1
  while (i < limit) do
    t = a
    a = a + b
    b = t
    yield a
    i = i + 1
  end
end
```

Brief Refactor Exercise (2/2)
-----------------------------

\small

```ruby
def fib(limit)
  a, b = 0, 1
  (1..limit).each do
    a, b = b, a + b
    yield a
  end
end
```

\comment{11 lines \ra 4 lines (of actual logic/content)}

Topics
------

-   \hl{Method arguments}
    -   Some new, some review
-   `Proc`{.ruby}

Method Arguments
================

Overview
--------

-   \hl{Default value}   
    -   Recall: `Hangman.new`{.ruby} vs. `Hangman.new "myWords.txt"`{.ruby}
-   \hl{Variable number of arguments}
    -   `def readwrite(*syms)`{.ruby}
-   \hl{Pass arguments in} `Hash`{.ruby}
-   \hl{Block as function argument}
    -   When method has `yield`{.ruby}

\comment{Some of this section is review, and some is new}

Default Value (1)
-----------------

```ruby
def title(name, len=3)
    name[0, len]
end
```

```ruby
puts title("Mr. Brandon McCartney")
puts title("Mrs. Doubtfire", 4)
```

Default Value (2)
-----------------

```ruby
# can use expression in default value
def shift(x, dx=x/100.0)
    x + dx
end
```

```ruby
puts shift(5)
puts shift(10, 1)
```

Variable Argument Count
-----------------------

-   Similar to `*`{.ruby} (\hli{splat})
    -   `a, *b = 1, 2, 3`{.ruby}
-   `*`{.ruby} before param in \hli{function definition}
    -   Param \ra array of 0 or more args
-   `*`{.ruby} before array param in \hli{function call}
    -   Param array \ra separate arguments

Variable Arg Examples
---------------------

\colsbegin
\col

```ruby
def limitedSum(max, *rest)
    total = rest.sum
    if total <= max
        total
    else
        max
    end
end
```

\col

```ruby
limitedSum(20, 1, 4, 5)
limitedSum(20, 10, 20, 30)

data = [1, 4, 5]
limitedSum(20, *data)
```

\colsend

Hashes for Arguments
--------------------

-   \hl{Argument order}
    -   Could break client's code if changed
-   \hl{Solution: send hash}

Hashes for Arguments
--------------------

```ruby
def http(config)
    if config.key?(:tls)
        puts "Using HTTPS"
    end
    if config.key?(:basic_auth)
        puts "Using HTTP with BasicAuth"
    end
end
```

```ruby






```

Hashes for Arguments
--------------------

```ruby
def http(config)
    if config.key?(:tls)
        puts "Using HTTPS"
    end
    if config.key?(:basic_auth)
        puts "Using HTTP with BasicAuth"
    end
end
```

```ruby
httpConfig = {
    :tls => true,
    :basic_auth => { "user" => "pass" }
}
http(httpConfig)
```

Blocks
------

-   Blocks are \hl{syntactic structures}
    -   \hli{Not objects}
-   \hl{Identified by...}
    -   Curly braces: `{ ... }`{.ruby}
    -   do/end keywords: `do .... end`
-   Can create \hli{objects that represent blocks}
    -   Okay, but \hl{why?}

`yield`{.ruby}
--------------

-   `yield`{.ruby} statement
    -   Gives control to \hli{user-specified block}

`yield`{.ruby} Example
----------------------

```ruby
def fib(limit)
  a, b = 0, 1
  (1..limit).each do
    a, b = b, a + b
    yield a
  end
end
```

```ruby
fib(10) { |x| puts "Fibonacci number: #{x}" }
```

Objects that Represent Blocks
-----------------------------

-   `Proc`{.ruby}
    -   Has block-like behavior
    -   \hl{But} can pass \hli{multiple procs} into function
-   \hl{Lambdas}\Noteref 
    -   Generally: \hli{anonymous functions}
    -   Ruby: lambdas are `Proc`{.ruby} instances
-   [\link{Blocks vs. Procs vs. Lambdas}](http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/)

\Note{We'll do lambdas in Haskell}

Implicit Block Argument
-----------------------

```ruby
def fib(limit)
  a, b = 0, 1
  (1..limit).each do
    a, b = b, a + b
    yield a
  end
end
```

```ruby
fib(10) { |x| puts x }
```

Explicit Block Argument
-----------------------

```ruby
# block arg must be last argument
# also, notice the `&` for the block arg
def fib(limit, &block)
  a, b = 0, 1
  (1..limit).each do
    a, b = b, a + b
    block.call(a) # could stil use `yield`
  end
end
```

```ruby
fib(10) { |x| puts x }
```

`Proc`{.ruby} Argument
----------------------

```ruby
# notice no `&` this time -- `Proc` is just an object
def fib(limit, proc)
  a, b = 0, 1
  (1..limit).each do
    a, b = b, a + b
    proc.call(a)
  end
end
```

```ruby
p = Proc.new { |x| puts x }
fib(10, p)
```

Block vs. `Proc`{.ruby}
-----------------------

What's the difference?

-   \hl{Block:} \hli{one-time use}
-   `Proc`{.ruby}: \hli{reusable}
    -   Pass to multiple functions
    -   Provide with library

Block and `Proc`{.ruby} Uses
----------------------------

-   \hl{Goal:} Encrypt file byte-by-byte
-   `while more data to read...`
    1.  `read a byte`
    2.  `encrypt byte (with block or Proc)`
    3.  `write byte`
-   `encrypt` step is \hli{up to user}

Real-World Example (1)
----------------------

```ruby
class RailsAppTest < ActiveSupport::TestCase
  test "start web server" do
    # sequence of instructions + assert
  end
end
```

`test`{.ruby} \comment{prints formatted results}

Real-World Example (2)
----------------------

```ruby
class Order < ActiveRecord::Base
  before_save
    :normalize_card_number,
    if: Proc.new { |order| order.paid_with_card? }
    # if: proc is a hash, same as { :if =>  proc }
end
```

`Proc`{.ruby} Exercise (1/2)
----------------------------

-   Write function `powers(max, proc1, proc2)`{.ruby}
    -   Applies `proc1`{.ruby} and `proc2`{.ruby} to integers $[1, max]$
-   See next slide for example output

`Proc`{.ruby} Exercise (2/2)
----------------------------

```
$ ruby procExample.rb
Calling powers -- square and cube
1 1 1
2 4 8
3 9 27
4 16 64
5 25 125

Calling powers -- square and fourth power
1 1 1
2 4 16
3 9 81
4 16 256
5 25 625
```
