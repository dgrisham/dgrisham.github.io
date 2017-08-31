Ruby Classes and Objects
========================

Language Design -- Classes
--------------------------

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
-   Ruby is *strictly encapsulated*
    -   Always private
    -   *Must* include getters/setters
    -   **Encapsulated:** other classes can't access data directly
-   Reflection and open classes subvert this encapsulation

\Note{covered later}

Compare to Java
---------------

-   Package by default (TODO: ?)
-   Can declare public
-   Best practice: Make instance variables private
-   Why?
    -   Provide data validity (can only update via setter)
    -   Easy to change internal data representation (getters act as interface)

*Based on the above, Java is not strictly encapsulated*

Object Creation
---------------

-   Every class inherits method `new`
    -   Calls `allocate` to get space (cannot override)
    -   Calls `initialize` to create instance variables
-   Often convenient to provide default parameters for `initialize`

    ```ruby
    def initialize(x, y, z=nil)
        @x, @y, @z = x, y, z
    end
    ```

Simple Class
------------

Here's an example of a simple `Cat` class, complete with getters and setters:

```ruby
class Cat
# DON'T declare instance variables here!
    # ctor is named initalize
    def initialize(name, age)
        # instance variables begin with @
        @name, @age = name, age
    end

    # to_s is similar to toString
    def to_s
        "(#@name, #@age)"
    end

    # getters
    def name
        @name
    end

    def age
        @age
    end

    # setters
    def name=(value)
        @name=value
    end

    def age=(value)
        @age=value
    end
end
```

And now we can play with the class:

```ruby
c = Cat.new("Fluffy", 2)
puts c
puts c.name

c.age = 5
puts c.age
puts c.to_s
```

A few things to note:

-   `new` calls `initialize`
-   `to_s` like Java's `toString`
-   *Return value of last expression* in a function is *returned*
-   `@` indicates *instance variable*

Simple Class
------------

You can see a slightly more complete `Cat` class here:
[Cat](src/classes-1.rb)


Operator Overloading, etc.
--------------------------

Check out this Ruby class: [Bottle](src/classes-2.rb)

