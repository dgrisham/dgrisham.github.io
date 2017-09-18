---
title: Ruby Modules
subtitle: CSCI400
theme: Amsterdam
date: 7 September 2017
...

Color Key
---------

-   [\link{Clickable URL link}](https://www.youtube.com/watch?v=esxxpR4SVPU)
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Example Code Files
------------------

[\link{Download Ruby module examples}](./modules.zip)

Open Classes
============

Open Classes
------------

Client can \hli{append} to class definition

-   Add methods and variables
-   \hli{Can overwrite existing methods}

[\link{Open Classes and Encapsulation}](https://stackoverflow.com/questions/4184821/do-rubys-open-classes-break-encapsulation)

Open Classes Example
--------------------

```ruby
# ruby_open_classes-1.rb
class Pikachu
  attr_accessor :name, :level
  def initialize(name, level)
    @name, @level = name, level
  end
end
```

```ruby








```

Open Classes Example
--------------------

```ruby
# ruby_open_classes-1.rb
class Pikachu
  attr_accessor :name, :level
  def initialize(name, level)
    @name, @level = name, level
  end
end
```

```ruby
# ruby_open_classes-2.rb
require_relative "ruby_open_classes-1.rb"
class Pikachu
  def attack
    puts "#{name} used thundershock!"
  end
end
```

Liskov Substitution Principle
-----------------------------

-   \hli{Subtypes must be substitutable} for base class
    -   \hl{Goal:} Don't break when calling parent method on child
-   \hl{Open classes}
    -   Objects must behave similarly after changes to class

LSP Violation Example 1
-----------------------

```ruby
# run in irb
puts (1/2)
require "mathn"
puts (1/2)
```

\q{What class was modified in this example?}

LSP Violation Example 2
-----------------------

```ruby
# cat.rb
class Cat
  attr_accessor :age
  def old?
    @age > 10
  end
end
```

```ruby







```

LSP Violation Example 2
-----------------------

```ruby
# cat.rb
class Cat
  attr_accessor :age
  def old?
    @age > 10
  end
end
```

```ruby
# main.rb
require_relative "cat.rb"
class Cat
  def old
    puts "Cats never grow old..."
  end
end
```

Modules
=======

Modules
-------

Named group of methods, constants, and class variables

-   \hli{All} classes are modules
-   \hli{Not} all modules are classes
    -   Can't be \hli{instantiated} or \hli{subclassed}
-   \hl{Purpose}
    -   \hli{Namespaces} and \hli{mixins}

Purpose 1: Namespace
--------------------

[\link{Skim this}](https://en.wikibooks.org/wiki/Introduction_to_Programming_Languages/Scoping_with_Namespaces)

\q{How do we specify a namespace in:}

1.  \q{Java?}
2.  \q{C++?}

\comment{For exam: Care more about purpose, not syntax}

Namespace in Ruby
-----------------

-   Class methods have implicit namespace
-   What about \hli{non-object} functions?
    -   \hl{Java:} Create a class with static method
        -   e.g. `Math.abs`{.java}
    -   \hl{Ruby}
        -   Global methods \ra \hli{naming conflicts}
        -   Solution: Module (provides namespace)

Example from Text
-----------------

```ruby
module Base64
  def self.encode(data)
    # ...
  end
  def self.decode(text)
    # ...
  end
end # end of module
```

```ruby
text = Base64.encode(data)
data = Base64.decode(text)
```

\comment{See:} `ruby_modules-1.rb`

Purpose 2: Mixins
-----------------

[\link{Skim this}](https://en.wikipedia.org/wiki/Mixin)

[\link{And this}](https://en.wikipedia.org/wiki/Multiple_inheritance#The_diamond_problem)

-   \q{What's one purpose/goal of a mixin?}
-   \q{What is the {\it diamond problem} and how do mixins avoid it?}
-   \q{Think: How is this similar/different from Java interfaces?}

\comment{Above questions are fair exam material}

Multiple Inheritance: Problem
-----------------------------

Child with \hli{two parents} (e.g. C++)

-   \hl{Purpose:} Child has \hl{is-a} relationship with both
-   \hl{Issue:} Parents implement same method (\hli{diamond problem})
-   \hl{Solution:} Limit classes to single parent

Alternative to Multiple Inheritance
-----------------------------------

-   Class incorporates methods from multiple entities...
    -   ...\hli{without} entire class hierarchy
-   Examples
    -   \hl{Java:} interfaces
    -   \hl{Ruby:} \hli{Modules as mixins}

Module Mixins
=============

Mixins in Ruby
--------------

-   Module with instance methods
    -   Can be \hli{mixed into} other classes
    -   Eliminates need for multiple inheritance
-   Examples
    -   `Enumerable`{.ruby}
        -   Defines iterators that make use of `each`{.ruby}
    -   `Comparable`{.ruby}
        -   Defines `<`{.ruby}, `>`{.ruby}, `==`{.ruby}, etc. in terms of
            `<=>`{.ruby}

Mixin Example 1 (1/2)
---------------------

```ruby
module FlyingCreature
  def fly
    puts "Flying! Speed: #{@speed}"
  end
end








```

\comment{See:} `ruby_modules-2.rb`

Mixin Example 1 (1/2)
---------------------

```ruby
module FlyingCreature
  def fly
    puts "Flying! Speed: #{@speed}"
  end
end

class Bird
  include FlyingCreature
  def initialize
    @speed = 5
  end
end
```

\comment{See:} `ruby_modules-2.rb`

Mixin Example 1 (2/2)
---------------------

```ruby
tweety = Bird.new
tweety.fly
puts "tweety is a flying creature? "\
     "#{tweety.is_a? FlyingCreature}"
```

\comment{See:} `ruby_modules-2.rb`

Mixin Example 2 (1/2)
---------------------

```ruby
module FlyingCreature
  def fly
    puts "Flying! Speed: #{@speed}"
  end
end









```

\comment{See:} `ruby_modules-2.rb`

Mixin Example 2 (1/2)
---------------------

```ruby
module FlyingCreature
  def fly
    puts "Flying! Speed: #{@speed}"
  end
end

class Mammal
  # ...
end
class Bat < Mammal
  include FlyingCreature
  # ...
end
```

\comment{See:} `ruby_modules-2.rb`

Mixin Example 2 (2/2)
---------------------

```ruby
bat = Bat.new
bat.fly
puts "bat is a flying creature? "\
     "#{bat.is_a? FlyingCreature}"

batman = Mammal.new
puts "batman is a flying creature? "\
     "#{batman.is_a? FlyingCreature}"
```

\comment{See:} `ruby_modules-2.rb`

Mixins: Best Practice
---------------------

[\link{Skim}](https://matt.aimonetti.net/posts/2012/07/30/ruby-class-module-mixins/)

-   \q{When should you {\it not} use a class?}
-   \q{Do we create instances of modules?}
-   \q{How do we use module instance methods?}

Other
=====

Modules vs. Interfaces
----------------------

On your own: [Ruby Modules vs. Java Interfaces](https://stackoverflow.com/questions/575920/is-a-ruby-module-equivalent-to-a-java-interface)

\comment{Not exam material}

Singleton Method Example
------------------------

```ruby
class Person
  def initialize(name)
    @name = name
  end
end
```

```ruby
shugo = Person.new("Shugo")
matz = Person.new("Matz")

def matz.design_ruby; puts "I designed Ruby!"

matz.design_ruby
shugo.design_ruby # error
```
