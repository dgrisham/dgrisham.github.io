Ruby Classes and Objects
========================

You will explore these topics with a partner.

Preparation
-----------

Start by downloading the [Ruby `Class` demo files](./ruby-class_demo_files.zip).
Most of the larger code examples in this file can be found in these files so
that you can run them in the terminal to view the output.

One you are finished with all of the content, complete the
[Self-Test](#self-test) at the bottom of this document. There is nothing to
submit, you may keep your answers as a study guide.

Language Design -- Classes
--------------------------

Relevant topics:

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
    -   *Always* private
    -   *Must* include getters/setters
    -   **Encapsulated:** other classes can't access data directly
-   Reflection and open classes subvert this encapsulation

### Compare to Java

In Java, the default visibility of a class variable is to the package the class
is a part of. You can also declare class vars as `public`. Because of these two
points, Java is *not* strictly encapsulated.

Best practice in Java is to make instance variables private. We can see why if
we consider the public attributes of a class as an API (**A**pplication
**P**rogramming **I**nterface) that outside programs will interact with. For
example, we probably want to write the class in a way that makes it easy to
update in the future without causing the calling code to fail.

Given this perspective, it might start to make sense why we use getters and
setters. If the calling code interact with a class variable directly, then
updates to the class may break the calling code in certain ways; getters and
setters can act as mediators here. In particular:

-   A setter should accept some input from the user and update the class in a
    controlled way. This allows the class implementor to ensure that all input
    from the user is *sanitized* (cleaned up/formatted as the class expects).
-   If the internals of the class change in some way, the definition of the
    getters/setters may also change, but the **way in which the calling code
    calls the getters/setters doesn't have to change**. This means that the
    class implementation can change, but the users using the class will not have
    to change their code to account for the updates.

Object Creation
---------------

-   Every class inherits method `new`
    -   Calls `allocate` to get space (cannot override)
    -   Calls `initialize` to create instance variables
-   Often convenient to provide default parameters for `initialize`

    ```ruby
    def initialize(x, y, z=0)
        @x, @y, @z = x, y, z
    end
    ```

### Simple Class

**Open/run the `ruby_classes-1.rb` file in the provided files**

Here's an example of a simple `Cat` class, complete with getters and setters:

```ruby
class Cat
    def initialize(name, age)
        @name, @age = name, age
    end

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

### Operator Overloading and Metaprogramming

**Open/run the `ruby_classes-2.rb` file in the provided files**

```ruby
class Bottle
    attr_accessor :ounces
    attr_reader :label

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def add(other)
        Bottle.new(@label, @ounces+other.ounces)
    end

    def add!(other)
        @ounces += other.ounces
        other.ounces = 0
    end

    def split!(scalar)
        newOunces = @ounces / scalar
        @ounces -= newOunces
        Bottle.new(@label, newOunces)
    end

    def +(amount)
        Bottle.new(@label, @ounces + amount)
    end

    def to_s
        "(#{label}, #{ounces})"
    end
end
```

Notice the `attr_accessor :ounces` and `attr_reader :label` lines at the top of
the file. These are examples of *metaprogramming* in Ruby -- they are convenient
ways of telling the interpreter that we want simple getters and/or setters for
these two attributes.

For example, the line `attr_accessor :ounces` is equivalent to:

```ruby
def ounces
    @ounces
end

def ounces=(value)
    @ounces = value
end
```

And we can try running the code to see how it behaves (try running the provided
file in the terminal to s ee the output of the following):

```ruby
b = Bottle.new("Tab", 16)

puts b.label
b.ounces = 20
puts "b is #{b}"

puts "\nresult of b2 = b.split! 4"
b2 = b.split! 4
puts "b is #{b}"
puts "b2 is #{b2}"

puts "\nresult of b3 = b.add(b2)"
b3 = b.add(b2)
puts "b3 is #{b3}"
puts "b2 is #{b2}"

puts "\nresult of b.add!(b2)"
b.add!(b2)
puts "b is #{b}"
puts "b2 is #{b2}"

puts "\nresult of b4 = b3 + 10"
b4 = b3 + 10
puts "b4 is #{b4}"

puts "\nresult of b4 = b4 + 10"
b5 = b4.+ 10
puts "b5 is #{b5}"
```

Polymorphism
------------

Wikipedia: *Polymorphism* (from the Greek 'many forms') is the provision of a
single interface to entities of different types.

A **polymorphic type** is one whose operations can also be applied to values of
some other type(s).

We'll see 3 types of polymorphism:

1.  Ad-hoc
    -   e.g. operator-overloading
2.  Parametric
    -   e.g. generics in Java, duck typing in Ruby
3.  Subtyping
    -   e.g. parent-child relationships where child overrides parent methods

### Ad-hoc Polymorphism

If a function denotes different and potentially heterogenous implementations
*depending on a limited range of individually specified types and combinations*,
it is called **ad-hoc polymorphism**.

Ad-hoc polymorphism is supported in many languages using *function overloading*
-- same function name, but behavior is different depending on number and/or
types of parameters.

See: <http://stackoverflow.com/questions/154577/polymorphism-vs-overriding-vs-overloading>

### Parametric Polymorphism

If the code is written without mention of any specific type and thus can be used
transparently with any number of new types, it is called **parametric
polymorphism**. There may be some restriction on the types that are accepted,
such as "the input type must support comparison (`<`, `>`, `==`)".

A *type parameter* or *type variable* may be used as a placeholder for an actual
type, e.g. `LinkedList<T>` in Java, where `T` is the type variable.

In object-oriented programming, this is often referred to as **generic
programming**.

See: <https://stackoverflow.com/questions/10179449/what-is-parametric-polymorphism-in-java-with-example>

### Duck Typing

**Open/run the `ruby_classes-3.rb` file in the provided files**

"If it walks like a duck and quacks like a duck, it must be a duck."

Basically, any object whose class definition supports the required method will
work. Let's see an example involving 3 classes -- `Bottle`, `Can`, and `Cat`:

```ruby
class Bottle
    attr_accessor :ounces
    attr_reader :label

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def add(other)
        Bottle.new(@label, @ounces+other.ounces)
    end

    def to_s
        "(#@label, #@ounces)"
    end
end

class Can
    attr_accessor :ounces

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def to_s
        "(#@label, #@ounces)"
    end
end

class Cat
end
```

Notice that the `Bottle` and `Can` classes both have an `ounces` attribute,
but the `Cat` class does not. Based on that, consider the following code:

```
b = Bottle.new("Tab", 16)

c = Can.new("Coke", 12)
b2 = b.add(c)
puts "Result of b2 = b.add(c)"
puts "b2 is #{b2}"

cat = Cat.new
b3 = b.add(cat)
```

Object Class
------------

Some example Ruby code:

```ruby
x = 1
x.instance_of? Fixnum # => true
x.instance_of? Numeric # => false (even though subclass)

x_is_a? Fixnum # => true
x_is_a? Numeric # => true
x_is_a? Comparable # => true
x_is_a? Object # => true

x.class == Fixnum # => true
x.class == Numeric # => false
```

Object Type
-----------

In Ruby:

-   The class of an object doesn't change
-   Type is more fluid -- includes set of behaviors (i.e., methods it responds
    to -- duck typing)
    -   Can check with `respond_to?`
-   In other words, Class != Type...whoa

Object Equality
---------------

In Ruby:

-   `equal?` checks addresses
    -   Like `==` in Java
-   For `Object`, `==` is synonym for `equal?`
-   Most classes override `==`
    -   Similar to `equal` in Java

Equality Example
----------------

**Open/run the `ruby_classes-4.rb` file in the provided files**

```ruby
class Bottle
    attr_accessor :ounces
    attr_reader :label

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def ==(other)
        return false if ! other.instance_of? Bottle
        return @ounces == other.ounces && @label == other.label
    end

    alias eql? ==
end

class Can
    attr_accessor :ounces

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end
end
```

Running some examples:

```ruby
b = Bottle.new("Tab", 16)
b2 = Bottle.new("Tab", 16)
b3 = Bottle.new("Tab", 12)
b4 = Bottle.new("Coke", 16)

puts "b.equal?(b2) #{b.equal?(b2)}"
puts "b == b2 #{b == b2}"
puts "b == b3 #{b == b3}"
puts "b == b4 #{b == b4}"
puts "b.eql?(b2) #{b.eql?(b2)}"
puts "b.eql?(b3) #{b.eql?(b3)}"

c = Can.new("Tab", 16)
puts "b == c #{b == c}"

puts "\nNumeric equality"
x = 1.0
y = 1
puts "x == y #{x == y}"
puts "x.eql? y #{x.eql? y}"

puts "\n=== used mostly in case statements"
puts "(1..10) === 20 #{(1..10) === 20 }"
puts "(1..10) === 5 #{(1..10) === 5 }"
```

More Object Equality
--------------------

A few more details regarding equality in Ruby:

-   Numeric classes will do type conversions when used with `==`
-   `eql?` is like `==`, but no implicit type conversion
    -   `1.eql? 1.0` =&gt; false
-   Can alias `eql?` with `==`
    -   You can see an example of this in the `Bottle` class in [Equality
        Example](#equality-example)

More object comparison
----------------------

In Ruby, `===` is conventionally used as the *case subsumption operator*. That's
a weird term -- basically, `a === b` answers the question: "If `a` describes a
set, would `b` be a member of that set?"

A few examples:

```ruby
(1..10) === 5 # => true, 5 is in the range
/\d+/ === "123" # => true, matches regex
String === "string" # => true, s is instance of String
Integer === 5.0 # => false, 5.0 is not an Integer
```

It might be useful to read `===` as 'contains' or 'accepts'.

See: <https://stackoverflow.com/questions/4467538/what-does-the-operator-do-in-ruby>

Type-safe Methods
-----------------

**Open/run the `ruby_classes-5.rb` file in the provided files**

The following re-implements the code from the [Duck Typing](#duck-typing)
section with manual type checking to catch any issues with the input types to
`Bottle`'s methods. In particular, read the three `Bottle.add` functions:

```ruby
class Bottle
    attr_accessor :ounces
    attr_reader :label

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def add(other)
        raise TypeError, "Bottle argument expected " unless other.is_a? Bottle
        Bottle.new(@label, @ounces+other.ounces)
    end

    def add2(other)
        raise TypeError, "Bottle argument expected " unless other.respond_to? :ounces
        Bottle.new(@label, @ounces+other.ounces)
    end

    def add3(other)
        Bottle.new(@label, @ounces+other.ounces)
        rescue
            raise TypeError, "Cannot add with an argument that doesn't have ounces"
    end

    def to_s
        "(#@label, #@ounces)"
    end
end

class Can
    attr_accessor :ounces

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def to_s
        "(#@label, #@ounces)"
    end
end

class Cat
end
```

We can again test the code to see what happens:

```ruby
b = Bottle.new("Tab", 16)
c = Can.new("Coke", 12)

puts "result of b2 = b.add(c) - error!"
b2 = b.add(c)

puts "result of b2 = b.add2(c)"
b2 = b.add2(c)
puts "b2 is #{b2}"

puts "result of b2 = b.add3(c)"
b2 = b.add3(c)
puts "b2 is #{b2}"

cat = Cat.new
puts "result of b2 = b.add3(cat) - error!"
b2 = b.add3(cat)
```

More Overloading
----------------

**Open/run the `ruby_classes-6.rb` file in the provided files**

Examples of overloading the `each` and `[]` functions:

```ruby
class Bottle
    attr_accessor :ounces
    attr_reader :label

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def each
        yield @label
        yield @ounces
    end

    def [](index)
        case index
            when 0, -2 then @label
            when 1, -1 then @ounces
            when :label, "label" then @label
            when :ounces, "ounces" then @ounces
        end
    end
end
```

And running a few tests:

```ruby
b = Bottle.new("Tab", 16)

puts "Using each"
b.each {|x| puts x }

puts "\n Access by [ix] with overloaded []"
puts b[0]
puts b[-2]
puts b[1]
puts b[-1]

puts "\n Access by [field name] with overloaded []"
puts b["label"]
puts b[:label]
puts b["ounces"]
puts b[:ounces]
```

Object Comparisons
------------------

In order for a Ruby class to be considered `Comparable`, is must implement the
`<=>` operator (referred to as 'spaceship'). In implementing `<=>`, the class
also gets definitions of `<`, `<=`, `==`, `>=`, and `>` for free (all defined in
terms of `<=>`), but these can be overriden if desired (e.g. for efficiency).

Comparison Example
------------------

**Open/run the `ruby_classes-7.rb` file in the provided files**

```ruby
class Bottle
    include Comparable

    attr_accessor :ounces
    attr_reader :label

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def hash
        code = 17
        code = 37 * code + @label.hash
        code = 37 * code + @ounces.hash
        code
    end

    def <=>(other)
        return nil unless other.instance_of? Bottle
        @ounces <=> other.ounces
    end
end

```ruby
b = Bottle.new("Tab", 16)
b2 = Bottle.new("Tab", 12)
b3 = Bottle.new("Coke", 16)
b4 = Bottle.new("Tab", 16)

puts "b == b2 #{b == b2}"
puts "b < b2 #{b < b2}"
puts "b > b2 #{b > b2}"
puts "b == b3 #{b == b3}"
puts "b == b4 #{b == b4}"
```

Class Methods and Variables
---------------------------

**Open/run the `ruby_classes-8.rb` file in the provided files**

Recall that `@@` is used to prefix *class variables* in Ruby -- variables that
have a single instance that is shared by all instances of the class. Ruby also
has *class methods*, which are methods that can be called via the class itself
(rather than objects/instances of the class). These are declared by
`self.<method_name>`.

Example:

```ruby
class Bottle
    attr_accessor :ounces
    attr_reader :label
    MAX_OUNCES = 64
    @@numBottles = 0

    def initialize(label, ounces)
        @label = label
        @@numBottles += 1
        if ounces > MAX_OUNCES
            @ounces = MAX_OUNCES
        else
            @ounces = ounces
        end
    end

    def Bottle.sum(bottles)
        total = 0
        bottles.each {|b| total += b.ounces }
        total
    end

    def to_s
        "(#@label, #@ounces)"
    end

    def self.report
        puts "Number of bottles created: #@@numBottles"
    end
end
```

`@@numBottles` is a class variable, while `report` is a class method. The
following code illustrates how they work:

```ruby
bottles = Array.new
bottles[0] = Bottle.new("Tab", 16)
bottles[1] = Bottle.new("Tab", 16)
bottles[2] = Bottle.new("Coke", 16)
bottles[3] = Bottle.new("Tab", 20)

puts "Total ounces: #{Bottle.sum bottles}"
b = Bottle.new("Sprite", 72)
puts b

b.report
Bottle.report
```

Summary
-------

Whew, that was a lot of information. You can always refer back to this file/the
related demo files when you're doing assignments.

A few additional topics that aren't covered here, but might be useful:

-   `dup`
-   `clone`
-   `initialize_copy`
-   Marshalling
    -   Create from serialized data

Self-Test
---------

1.  What does it mean to be *strictly encapsulated*?
2.  What's the method name of the 'constructor' in Ruby?
3.  What's the difference between a variable named `y` and one named `@y`?
4.  As in Java, instance variables should be declared inside the class but
    outside any method. True / False
5.  What's the purpose of the `to_s` method?
6.  Regarding `ruby_classes-1.rb` (Section [Simple Class](#simple-class))
    -   Does the output make sense to you?
    -   Why doesn't the 'getter' for `name` need a `return` statement?
    -   What does `attr_reader` do?
7.  Regarding `ruby_classes-2.rb` (Section [Operator
    Overloading and Metaprogramming](#operator-overloading-and-metaprogramming))
    -   Does the output make sense?
    -   What's the difference between `add` and `add!`
    -   What function is implicitly called by `Bottle.new`?
8.  Does C++ support ad-hoc polymorphism? Explain your answer.
9.  Give an example of parametric polymorphism in Java.
10. Regarding `ruby_classes-3.rb` (Section [Duck Typing](#duck-typing)) -- Be
    sure you understand this!
    -   Use this example to explain *duck typing* (and don't just say "If it
        walks like a duck..." - how does this example show it?)
11. What's the difference between `instance_of?` and `is_a`?
12. To see the value of `respond_to`, and have some comparison between Ruby and
    Java, you might take a quick look at:
    <https://blogs.kde.org/2005/10/08/java-reflection-vs-ruby-respondto>
13. Regarding `ruby_classes-4.rb` (Section [Equality
    Example](#equality-example))
    -   Does the output make sense?
    -   What does the `alias` statement do?
    -   This example overrides `==`. What function would you override in Java to
        have a similar effect?
14. Regarding `ruby_classes-5.rb` (Section [Type-safe
    Methods](#type-safe-methods))
    -   Does the output make sense?
    -   We'll talk more about exceptions in an upcoming lecture, but what can
        you figure out just by looking at this code?
15. Regarding `ruby_classes-6.rb` (Section [More
    Overloading](#more-overloading))
    -   Does the output make sense?
    -   Can you explain how the yield works in the `each` method?
    -   Why are there so many options for `[]`? Do you understand them all?
16. Regarding `ruby_classes-7.rb` (Section [Comparison
    Example](#comparison-example))
    -   Does the output make sense?
    -   What Java function is the spaceship operator similar to?
17. Regarding `ruby_classes-8.rb` (Section [Class Methods and
    Variables](#class-methods-and-variables))
    -   Does the output make sense?
    -   What does `@@` mean?
    -   What's the syntax for a class method?

Submit/Rubric
-------------

Nothing to submit. If you don't finish during class, I *strongly* recommend you
finish on your own.
