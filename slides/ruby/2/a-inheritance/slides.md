---
date: 05 September 2017
title: Ruby Inheritance
subtitle: CSCI400
theme: Amsterdam
...

Color Key
---------

-   [\link{Clickable URL link}](https://www.youtube.com/watch?v=5Xr83DFlzjU)
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Class Participation
-------------------

Get out a piece of paper, we'll be tracing some code today.

[\link{Code files (follow along with the slides)}](./inheritance.zip)

Basics
======

Extending Class Behavior
------------------------

-   Can create subclasses (\kwd{inheritance})
-   May include/inherit methods from modules (\hl{mix-ins})
-   Clients of class may also extend the class
    -   Open classes
    -   Adding singleton method to individual object

Inheritance
-----------

-   Every class has a single immediate superclass
    -   `class Student < Person`{.ruby}
    -   `Object`{.ruby} is the default superclass
-   `BasicObject`{.ruby} is the parent of `Object`{.ruby}
    -   Few methods, useful for wrapper classes
    -   Can create completely separate hierachy
        -   e.g. `BasicObject`{.ruby} is not a superclass of `Kernel`{.ruby}

Inheritance and Instance Variables
==================================

Inheritance and Instance Variables
----------------------------------

-   Instance variables (IVs)
    -   Are defined \hli{within class methods}
    -   Are created upon assignment (`@age = 0`{.ruby})
    -   Every Ruby object has them
-   \ra \hl{Instance variables have nothing to do with inheritance}
-   However...
    -   If all IVs defined in `initialize`{.ruby}, inheritance appears to work
        as expected

Example: Variable 'Inherited'
-----------------------------

\colsbegin

\colw{0.55}

```ruby
class Person
    def initialize(name)
        @name = name
        puts "initializing"
    end
end
class Student < Person
    def to_s
        puts "Name: #{@name}"
    end
end
s = Student.new("Cyndi")
puts s
```

\col
\colsend

\comment{See:} `ruby_inheritance-1a.rb`

Example: Variable 'Inherited'
-----------------------------

\colsbegin

\colw{0.55}

```ruby
class Person
    def initialize(name)
        @name = name
        puts "initializing"
    end
end
class Student < Person
    def to_s
        puts "Name: #{@name}"
    end
end
s = Student.new("Cyndi")
puts s
```

\col

-   Technically, `@name`{.ruby} \hli{not inherited}
    -   But `initialize`{.ruby} \hli{is} called \ra creates `@name`{.ruby}
    -   \hli{Appears} that variable is inherited
-   \comment{An instance variable created in a parent method that the child
    does not call will {\it not} exist}

\colsend

\comment{See:} `ruby_inheritance-1a.rb`

Example: Variable Not 'Inherited'
---------------------------------

\colsbegin
\colw{0.55}

```ruby
class Person
  def initialize(name)
    @name = name
    puts "initializing"
  end
  def setupEmail(email)
    @email = email
  end
  def sendEmail()
    puts "Emailing #{@email}"
  end
end
```

\colw{0.55}
\colsend

\comment{See:} `ruby_inheritance-1b.rb`

Example: Variable Not 'Inherited'
---------------------------------

\colsbegin
\colw{0.55}

```ruby
class Person
  def initialize(name)
    @name = name
    puts "initializing"
  end
  def setupEmail(email)
    @email = email
  end
  def sendEmail()
    puts "Emailing #{@email}"
  end
end
```

\colw{0.55}

```ruby
class Student < Person
  def to_s
    puts "Name: #{@name}"
  end
end
```
\colsend

\comment{See:} `ruby_inheritance-1b.rb`

Example: Variable Not 'Inherited'
---------------------------------

\colsbegin
\colw{0.55}

```ruby
class Person
  def initialize(name)
    @name = name
    puts "initializing"
  end
  def setupEmail(email)
    @email = email
  end
  def sendEmail()
    puts "Emailing #{@email}"
  end
end
```

\colw{0.55}

```ruby
class Student < Person
  def to_s
    puts "Name: #{@name}"
  end
end
```

\q{Trace: What is displayed?}

```ruby
p = Person.new("Devin")
p.setupEmail("dev@mines.edu")
s = Student.new("Gene")
p.sendEmail
s.sendEmail
```
\colsend

\comment{See:} `ruby_inheritance-1b.rb`

Inheritance and Methods
=======================

Inheritance and Overriding
--------------------------

-   Child class can override parent methods
-   Methods
    -   ...are bound \hli{dynamically} (when executed)
    -   ...not statically (when parsed)
-   Methods like `to_s`{.ruby} and `initialize`{.ruby} are automatically
    inherited (from `Object`{.ruby})\Noteref

\Note{If you don't know all of the methods of the parent class, you may
accidentally override a method!}

Language Comparison
-------------------

Run `ruby_inheritance-1.rb`

-   Does Java automatically call parent constructor?
    -   [\link{Read}](https://stackoverflow.com/questions/6318628/when-do-you-need-to-explicitly-call-a-superclass-constructor)
-   Compare to C++
    -   [\link{Read}](https://stackoverflow.com/questions/120876/what-are-the-rules-for-calling-the-superclass-constructor)
-   \q{Questions}\Noteref 
    1.  \q{In Java, when you do need to explicitly call the parent ctor?}
    2.  \q{In C++, why don't they use a keyword like} `super` \q{to call th
            parent ctor?}

\Note{Not exam topics}

Language Comparison
-------------------

Assume you're writing a C++ program with:

1.  Parent named `Bug`{.cpp}, child named `Mosquito`{.cpp}
2.  A method in both parent/child named `bite`{.cpp}

-   \q{What do you need to make sure this is bound dynamically?}
-   \q{What happens if this is not bound dynamically?}
    -   \q{Write a few lines of C++ (on paper) to illustrate}

[\link{Helpful reminder}](https://stackoverflow.com/questions/2391679/why-do-we-need-virtual-functions-in-c)

Big Picture
-----------

Usually, when dealing with an OO language...

-   Inheritance is a part of the language
-   There's a way to ensure parent/child vars are initialized
-   Child classes can call parent class methods
-   Child classes can override parent methods
    -   Runtime: \hli{dynamic/late binding}
    -   Compile time: \hli{static/early binding}

Override Parent Method
----------------------

\colsbegin
\colw{0.6}

```ruby
class Person
  def initialize(name)
    @name = name
  end
  def introduce
    puts "Hi, I'm #{@name}"
  end
end

class Student < Person
  def introduce
    puts "I'm a student and "\
         "my name is #{@name}"
  end
end
```

\col
\comment{See:} `ruby_inheritance-2a.rb`

\colsend

Override Parent Method
----------------------

\colsbegin
\colw{0.6}

```ruby
class Person
  def initialize(name)
    @name = name
  end
  def introduce
    puts "Hi, I'm #{@name}"
  end
end

class Student < Person
  def introduce
    puts "I'm a student and "\
         "my name is #{@name}"
  end
end
```

\col

```ruby
joe = Person.new("Joe")
joe.introduce
jamie = Student.new("Jamie")
jamie.introduce
```

\comment{See:} `ruby_inheritance-2a.rb`

\colsend

Ruby Method Visibility
----------------------

1.  \hl{Public}
    -   Methods are \hli{public by default}
    -   `initialize`{.ruby} is implicitly private (called by `new`{.ruby})
2.  \hl{Private}
    -   Only visible to \hli{other methods} of the class/subclass
    -   Implicitly invoked on `self`{.ruby}
3.  \hl{Protected}
    -   Like private, but can be invoked on \hli{any instance} of class
    -   Allows objects of same type to share state (used infrequently)

\comment{These only apply to methods!}

\comment{Instance vars are private, constants are public}

Method Visibility Example 1
---------------------------

\colsbegin
\colw{0.55}

```ruby
class X
  # public methods by default
  def fn
    # ...
  end
  protected :fn
  def helper
    # ...
  end
  private :helper
end
```

\colw{0.55}
\colsend

Method Visibility Example 1
---------------------------

\colsbegin
\colw{0.55}

```ruby
class X
  # public methods by default
  def fn
    # ...
  end
  protected :fn
  def helper
    # ...
  end
  private :helper
end
```

\colw{0.55}

-   Can override visibility ([\link{reference}](https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Classes#Private))
    -   \footnotesize `private_class_method :new`{.ruby}
-   `private`{.ruby} and `protected`{.ruby}
    -   Guard against unintended use\Noteref

\footnotesize\Note{But, with metaprogramming, it's possible to call these methods}

\colsend

Method Visibility Example 2 (1/2)
---------------------------------

\colsbegin
\colw{0.6}

```ruby
class Person
  def initialize(name)
    @name = name
    puts "initializing"
  end

  def talk_to(friend)
    puts "Talking to #{@friend}"
  end
  private :talk_to
end
```

\col
\colsend

\comment{See:} `ruby_inheritance-2b.rb`

Method Visibility Example 2 (2/2)
---------------------------------

\colsbegin
\colw{0.6}

```ruby
class Person
  def initialize(name)
    @name = name
    puts "initializing"
  end

  def talk_to(friend)
    puts "Talking to #{@friend}"
  end
  private :talk_to
end
```

\col

```ruby
p = Person.new("Yeezy")
p.talk_to("Weezy")
```

\colsend

\comment{See:} `ruby_inheritance-2b.rb`

Abstract Class Methods
----------------------

-   Implicitly defined in Ruby
-   Parent class calls methods that child must define

Example: Abstract Class Methods (1/3)
-------------------------------------

```ruby
class AbstractGreeter
  def greet
    puts "#{greeting} #{who}" # call abstract methods
  end
end
class WorldGreeter < AbstractGreeter
  def greeting; "Hello"; end
  def who; "Jerry"; end
end
```

\comment{See:} `ruby_inheritance-3.rb`

Example: Abstract Class Methods (2/3)
-------------------------------------

```ruby
class AbstractGreeter
  def greet
    puts "#{greeting} #{who}" # call abstract methods
  end
end
class WorldGreeter < AbstractGreeter
  def greeting; "Hello"; end
  def who; "Jerry"; end
end
```

\q{\small What makes AbstractGreeter an abstract class?}

\q{\small How does this compare to Java? C++?}

\comment{See:} `ruby_inheritance-3.rb`

Example: Abstract Class Methods (3/3)
-------------------------------------

```ruby
WorldGreeter.new.greet
AbstractGreeter.new.greet
AbstractGreeter.new.say_hi
```

\comment{See:} `ruby_inheritance-3.rb`

Example: Chaining Methods (1/3)
-------------------------------

\colsbegin
\col

```ruby
class Person
  def initialize(name)
    @name = name
  end
  def introduce
    puts "Hi, I'm #{@name}"
  end
end
```

\colw{0.62}
\colsend

\comment{See:} `ruby_inheritance-4.rb`

Example: Chaining Methods (2/3)
-------------------------------

\colsbegin
\col

```ruby
class Person
  def initialize(name)
    @name = name
  end
  def introduce
    puts "Hi, I'm #{@name}"
  end
end
```

\colw{0.62}

```ruby
class Student < Person
  def initialize(name)
    super(name)
    @major = major
  end
  def introduce
    super
    puts "I'm studying #{@major}"
  end
end
```

\colsend

\comment{See:} `ruby_inheritance-4.rb`

Example: Chaining Methods (3/3)
-------------------------------

```ruby
p = Person.new("Lauryn")
p.introduce
s = Student.new("Shawn", "Poetry")
s.introduce
```

\comment{See:} `ruby_inheritance-4.rb`

Class Variables
===============

Class Variables -- Review
-------------------------

-   When did we use `static`{.cpp} class vars in Java/C++?
-   Ruby class variables can be used for similar purposes

Example: Class Variables (1/2)
------------------------------

\colsbegin
\colw{0.56}

```ruby
class Person
  def initialize(name)
    @name = name
    @@thing2 = "water"
  end
  def show
    puts "Person: #{@@thing1}"
  end
end
```

\colw{0.6}

```ruby
class Student < Person
  def make_thing1
    @@thing1 = "oil"
  end
  def show
    puts "Student: #{@@thing1}"\
         " and #{@@thing2}"
  end
end
```

\colsend

\comment{See:} `ruby_inheritance-5.rb`

Example: Class Variables (2/2)
------------------------------

```ruby
a = Person.new("Amy")
b = Student.new("Bob")
# create class variable `thing1`
b.make_thing1
b.show
# all students can access `thing1`
c = Student.new("Charlie")
c.show
# parent cannot access `thing1`
a.show # error
```

\comment{See:} `ruby_inheritance-5.rb`

Class Instance Variables
------------------------

May want to explore on your own [\link{Class vs.\ Class-instance variables}](https://stackoverflow.com/questions/3802540/difference-between-class-variables-and-class-instance-variables)\Noteref

\Note{Not on exam}
