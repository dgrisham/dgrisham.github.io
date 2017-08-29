---
title: Ruby Data Types
subtitle: CSCI400
date: 29 August 2017
theme: Amsterdam
...

Color Key
---------

-   [\link{Clickable URL link}](https://www.youtube.com/watch?v=khMb3k-Wwvg)
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Array
-----

Array literals/initialization

```ruby
arr = [1,2,3]
arr2 = [[1,2], [3,4]]
arr3 = [8, "lcd", 0.1]
arr4 = (0..10).to_a # Range -> Array
empty1 = []
empty2 = Array.new
zeroes = Array.new(5, 0)
```

Array
-----

-   Arrays are \kwd{heterogeneous}
-   \# of elements
    -   `arr.length`{.ruby}, `arr.size`{.ruby}
-   Out of bounds access returns `nil`{.ruby}
-   Element accessors are similar to strings
-   Dynamic resizing
    -   Assign past end of array
-   `|`{.ruby}, `&`{.ruby} for union, intersection

\comment{Compare to Java/C++}

More Arrays
-----------

-   `words = %w(casualties of cool)`{.ruby}
    -   `["casualties", "of", "cool"]`{.ruby}
-   `<<`{.ruby} to append
-   Useful functionality
    -   `alphabet = ('A'..'Z').to_a`{.ruby}
    -   `alphabet.each { |c| print c }`{.ruby}
-   Other methods
    -   `clear`{.ruby}, `empty?`{.ruby}, `compact!`{.ruby}, `sort`{.ruby},
        `sort!`{.ruby}, `pop`{.ruby}, `push`{.ruby}, `reverse`{.ruby}, etc.

Symbol
------

-   \hli{Immutable}, [\link{interned}](https://en.wikipedia.org/wiki/String_interning) string
    (only one copy)
-   Commonly used as key in hash map
-   Symbol table
    -   Stores names of classes, methods, variables
    -   More efficient than storing as string
    -   Can be used with \hli{reflection}
-   Symbols preferred over strings as unique identifiers
-   Methods available to convert between string and symbol

\comment{Get used to symbols, they're very common}

Hashes
------

-   AKA maps, associative arrays
-   Best to use immutable objects as keys
    -   \comment{Required sometimes, e.g. Python}
-   Not covered: hash codes
    -   \comment{Hashes supported directly in Perl, Python, and Ruby; supported
        in class libraries of Java, C++, C\#}

Hashes
------

```ruby
colors1 = { :John => "blue", :Dave => "red" }
colors2 = { "John" => "blue", "Dave" => "red" }
colors3 = { John: "blue", Dave: "red" }

puts colors3[:John]

colors.each do |key, value|
    puts "#{key}'s favorite color is #{value}"
end
```

Array vs. Hash
--------------

-   Which is better if need to access items in order?
-   Which is useful for direct access?
-   Hash: useful for 'paired' data
    -   Similar to tuples (which Ruby doesn't have built-in)

Range
-----

-   Purpose
    -   Determine whether value is within range
    -   Iteration
-   Any object that implements `<=>`{.ruby} function
    -   `<=>`{.ruby} similar to Java's `CompareTo` -- why is this needed?
-   Bounds
    -   `1..10`{.ruby} includes `10`{.ruby}
    -   `1...10`{.ruby} excludes `10`{.ruby}

Range
-----

```ruby
coldware = 1945..1989
coldware.include? birthdate.year

(1..3).to_a # parenthesis required, otherwise just
            # applies to 3
```

\comment{Subrange introduce in Pascal, also used in Modula-2 and Ada. Others?}

Booleans, `nil`
---------------

-   `TrueClass`{.ruby} (`FalseClass`{.ruby}) singleton -- write as `true`{.ruby}
    (`false`{.ruby})
    -   `true != 1`{.ruby}, `false != 0`{.ruby}
-   `nil`{.ruby} means 'no value'
    -   Test directly (e.g. `x == nil`{.ruby}) or with `nil?`{.ruby} (e.g.
        `x.nil?`{.ruby})

Numeric Types
-------------

-   `FixNum`{.ruby}
    -   `Int`{.ruby} operations that fit in a machine word
-   `BigNum`{.ruby}
    -   Used for larger integers (`FixNum`{.ruby} converted automatically)
-   `Float`{.ruby}
    -   Floating points values
-   `Complex`{.ruby}
    -   Real + imaginary
-   `Rational`{.ruby}, e.g. `2/3`{.ruby}
