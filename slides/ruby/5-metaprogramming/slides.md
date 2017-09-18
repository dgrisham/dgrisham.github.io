---
title: Ruby Metaprogramming
subtitle: CSCI400
theme: Amsterdam
date: 21 September 2017
...

Color Key
---------

-   [\link{Clickable URL link}](https://www.youtube.com/watch?v=L2avV9ZGE3A)
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Overview
========

Metaprogramming
---------------

-   \hl{Treating programs as data}
    -   Writing \hli{programs that write programs} (!)
-   Common application: \hl{domain-specific languages} (\hl{DSL})

TODO: include "you've all heard of at least one Ruby DSL" question?

Familiar Example (1/2)
----------------------

```ruby
class Pikachu
    attr_accessor :name
    attr_reader :level

    def initialize(name, level)
        @name = name
        @level = level
    end
end
```

Familiar Example (2/2)
----------------------

Let's replicate `attr_*`

Check out [\link{this Ruby source file}](src/easy_access.rb)

Quick Exercise
--------------

-   \hl{Goal:} Create small class with a few instance vars
-   Start with source file on previous slide
    -   Use to create getters/setters
-   \hli{Hint:} `require_relative` and `include`

`require` and `include`
-----------------------

### Recall

-   `require`
    -   Like `include` in other languages (e.g. C++)
    -   Runs another source file
    -   Ensures its not `require`d twice
-   `include`
    -   Imports modules for use as \hli{mix-ins}

DSL Overview
============

Domain-Specific Language
------------------------

-   \hl{General-purpose language} (\hl{GPL})
    -   Used to solve problems in many domains
    -   E.g. Python, Java, Ruby, C++, Haskell, ...
-   \hl{Domain-specific languages)
    -   Used to solve problems within in \hli{specific domain}

DSL Examples
------------

Language            | Domain
--------            | ------
HTML                | Web pages
Mathematica         | Symbolic math
GraphViz            | Drawing graphs
VHDL                | Hardware description
YACC                | Define parsers
Regular Expressions | Lexers
SQL                 | Relational-database queries

Internal vs. External DSL
-------------------------

-   \hl{Internal DSL}
    -   AKA \hli{embedded} DSL
    -   DSL \hli{within} a (more) general-purpose language
-   \hl{External DSL} (\hl{eDSL})
    -   \hli{Independent} of any other language
    -   Compiled/interpreted (like a GPL)

[\link{Short post describing the distinction}](https://martinfowler.com/bliki/DomainSpecificLanguage.html)

\comment{Don't need to know the difference for exam}

eDSL Example
------------



