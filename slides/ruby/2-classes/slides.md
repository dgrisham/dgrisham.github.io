---
date: 31 August 2017
title: Ruby Classes and Objects
subtitle: (And other languages...)
author: CSCI400
theme: Amsterdam
...

Color Key
---------

-   [\link{Clickable URL link}](https://www.youtube.com/watch?v=IBaqh75Mi9s)
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Language Design -- Classes
--------------------------

TODO: clean this up

-   Classes and objects (vs. prototypes)
-   Instance variables/encapsulation
-   Objects
    -   Creation
    -   Equality/comparison
    -   Type
        -   Type-safety
        -   Type conversions
-   Classes
    -   Methods
    -   Variables
-   Inheritance -- another lecture

Encapsulation
-------------

-   Protect instance variables from outside forces
    -   i.e., other classes
-   Ruby is \hli{strictly encapsulated}
    -   Always private
    -   \hli{Must} include getters/setters
    -   \hl{Encapsulated:} other classes can't access data directly
-   Reflection and open classes subvert this encapsulation\Noteref

\Note{covered later}

Compare to Java
---------------

-   Package by default (TODO: ?)
-   Can declare public
-   Best practice: Make instance variables private
-   Why?
    -   Provide data validity (can only update via setter)
    -   Easy to change internal data representation (getters act as interface)

\comment{Based on the above, Java is {\it not} strictly encapsulated}

Object Creation
---------------

-   Every class inherits method `new`{.ruby}
    -   Calls `allocate`{.ruby} to get space (cannot override)
    -   Calls `initialize`{.ruby} to create instance variables
-   Often convenient to provide default parameters for `initialize`{.ruby}

    ``` {.ruby}
    def initialize(x, y, z=nil)
        @x, @y, @z = x, y, z
    end
    ```

Simple Class
------------

\columnsbegin
\col

``` {.ruby}
class Cat
    def initialize(name)
        @name = name
    end
    def to_s
        "Cat: #{@name}"
    end
    def name
        @name
    end
    def name=(input)
        @name=input
    end
end
```

\col

``` {.ruby}
c = Cat.new("Fluffy") 
puts c                
puts c.name           
c.name = "Bob"        
```

-   `new`{.ruby} calls `initialize`{.ruby}
-   `to_s`{.ruby} like Java's `toString`{.java}
-   Result of \hli{last expression} in function is \hli{returned}
-   `@`{.ruby} indicates \hli{instance variable}

\columnsend

Simple Class
------------

You can see a slightly more complete `Cat`{.ruby} class here:
[Cat](src/ruby_classes-1.rb)


Operator Overloading, etc.
--------------------------

Check out this Ruby class: [Bottle](demo_files

