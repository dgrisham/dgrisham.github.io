---
title: Ruby Reflection
subtitle: CSCI400
theme: Amsterdam
date: 16 September 2017
...

Color Key
---------

-   [\link{Clickable URL link}](https://www.youtube.com/watch?v=tW8FKkVnqng)
-   \q{Write down an answer to this for class participation}
-   \comment{Just a comment -- don't confuse with yellow}

Reflection
----------

a.k.a. \hli{introspection}

Program can examine/modify its own state

-   Set variables
-   Call methods
-   Add new methods
-   Define new objects

Objects getting existential...
------------------------------

\colsbegin

\col

-   What class am I?
    -   `o.class`{.ruby}
-   Am I an X? (synonyms)
    -   `o.is_a?`{.ruby}
    -   `o.kind_of?`{.ruby}
-   What else can I do?
    -   `o.methods`{.ruby}

\col

-   Who's my parent?
    -   `o.superclass`{.ruby}
-   Can I do this?
    -   `o.respond_to?`{.ruby}
-   What are my variables?
    -   `o.local_variables`{.ruby}
    -   `o.global_variables`{.ruby}
    -   `o.instance_variables`{.ruby}

\colsend

Design Philosophy
-----------------

> As to why both is\_a? and kind\_of? exist: I suppose it's part of Ruby's
> design philosophy. Python would say there should only be one way to do
> something; Ruby often has synonymous methods so you can use the one that
> sounds better. It's a matter of preference. It may partly be due to Japanese
> influence: I'm told that they will use a different word for the same number
> depending on the sentence in order to make it sound nicer. Matz may have
> carried that idea into his language design.\
-   Some guy on StackOverflow

[\link{Source}](https://stackoverflow.com/questions/3893278/ruby-kind-of-vs-instance-of-vs-is-a)

Example
-------

```ruby
class Cat
  def initialize(name, age)
    @name = name
    @age = age
  end
  def purr
    puts "purrr"
  end
```

```ruby






```

Example
-------

```ruby
class Cat
  def initialize(name, age)
    @name = name
    @age = age
  end
  def purr
    puts "purrr"
  end
end
```

```ruby
cat = Cat.new("Fluffy", 6)
puts cat.class
puts "Cat? #{cat.is_a? Cat}"
puts "String? #{cat.is_a? String}"
puts "Kind of cat? #{cat.kind_of? Cat}"
```

Example 2
---------

```ruby
class Cat
  def show_local
    x = 5
    local_variables.each do |var|
      puts var
    end
  end
end
```

```ruby






```

Example 2
---------

```ruby
class Cat
  def show_local
    x = 5
    local_variables.each do |var|
      puts var
    end
  end
```

```ruby
cat.instance_variables.each do |var|
  puts var
end
cat.show_local
```

Instance Variable Manipulation
------------------------------

Look up: `instance_variable_set`{.ruby}, `instance_variable_get`{.ruby}

Why might we do this?
---------------------

```ruby
class MyTest < Minitest::Test
  test_something
    # ...
  end
end
```

`test_something`{.ruby} \comment{gets run automatically, but how?}

Ok, why else?
-------------

-   Consider a game program
    -   User has powerful game piece
    -   Rolls die, is able to spawn new object of same type
-   How can we create a new instance of that class?
    -   `player.class.new(params)`

Sounds pretty useful!
---------------------

-   [\link{What is reflection, + why is it useful?}](https://stackoverflow.com/questions/37628/what-is-reflection-and-why-is-it-useful)
    -   Skim up to `dump` method example (3rd answer)
-   \q{Briefly describe something cool you can do with reflection}

Cool, anything else?
--------------------

-   Ruby on Rails & Active Record
-   \hl{Object-relational mapper} (ORM)
    -   Database table:
        -   Rows = objects
        -   Columns = instance vars
-   Objects act as \hli{interface} to database

Simple example
--------------

[\link{Open and run: message\_framework.rb}](src/message_framework.rb)

Another use of Reflection
-------------------------

-   Given an \hli{arbitrary} object...
    1.  Prompt user for input
    2.  Modify object using that input

In-Class Challenge
------------------

Use reflection + user input to create class instance

```ruby
Enter the information for your Pikachu
Enter the name: Sparky
Enter the level: 5
Sparky is a level 5 Pikachu
```

[\link{Start with this}](src/pikachu.rb)

More Challenge Details
----------------------

-   \hli{Write a function}\Noteref that...
    -   Accepts an object
    -   \hli{Uses reflection} to prompt user for input
    -   \hli{Uses reflection} to store user input in object
-   Can verify with `puts <object>`{.ruby}

\Note{Not a class method}

Challenge Solution
------------------

[\link{Download}](src/pikachu_reflection.rb)

Questions to consider...
------------------------

-   What other languages have reflection?
-   Is it used for different purposes depending on the language?

