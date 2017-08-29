Data Types, Expressions, Control Flow and Unit Tests
====================================================

You will explore these topics with a partner.

Lesson: Data Types
------------------

Review: [Ruby Data Types](../../slides/ruby/1/a-data_types/slides.pdf)

On a piece of paper:

1.  Write a line of Ruby code that illustrates that arrays are heterogeneous
2.  Write a line of Java code that highlights the fact that Java arrays are
    homogeneous.
3.  Write a line of code that illustrates that ArrayList in Java can be
    heterogeneous

Symbols are ubiquitous in Ruby, but can be confusing at first. Read:

-   <http://www.troubleshooters.com/codecorn/ruby/symbols.htm#_What_are_symbols>
-   <http://www.randomhacks.net/2007/01/20/13-ways-of-looking-at-a-ruby-symbol/>

Add to your paper:

1.  Explain the statement "A Ruby symbol is an object with O(1) comparison".
2.  Name one common usage for a symbol

Do a quick Google-search to explore: How do Ruby's symbol compare to C`++`
enums? to Java enums?

Lesson: Expressions
-------------------

Review: [Ruby Expressions](../../slides/ruby/1/b-expressions/slides.pdf). From
the [Ruby demo files](demo_files) you downloaded in the Intro exercise, take a
look at [ruby_expressions.rb](demo_files/ruby_expressions.rb).

### Self Test

Explore, no need to record answers, but DO answer every question!

1.  Does Ruby have overloaded operators? Is there any difference between puts
    `a[0]` and puts `a.[](0)`?
2.  What is the effect of: `a.[]=(0, 5)`?
3.  What is an lvalue?
4.  How does parallel assigment work?
5.  Are constants really constant in Ruby?
6.  What does it mean to be right associative?
7.  What is a programming idiom?
8.  What is short-circuit evaluation?
9.  What can you do with the splat?
10. In a Ruby program, you see the name `whatever`. How would Ruby decide
    whether this is a variable or a method?

Control Flow
------------

Review: [Ruby Control Flow](../../slides/ruby/1/c-control_flow/slides.pdf). From
the downloaded files, take a look at
[ruby_control_flow.rb](demo_files/ruby_control_flow.rb).

**Slides 1-11**: Part of the popularity of Ruby stems from its expressive
syntax. Review these slides and play with the code corresponding code, through
the comment that says \#yield.

Add to your paper:

-   Slide 12 asks you to trace the code on the following slides
-   Be ready to discuss with the class when/why yield might be useful
-   Do the in-class challenge on slide 14
-   We'll explore blocks in more detail (slide 15) later

Ruby Unit Tests
---------------

**On your own** (not an in-class exercise).

The concept of unit tests is the same as other languages. Review [Ruby Unit
Tests](../../slides/ruby/1/d-unit_tests/slides.pdf). From the downloaded files,
take a look at [ruby_unit_test.rb](demo_files/ruby_unit_test.rb). The only
self-test is to be sure you understand why we need `assert_in_delta` rather than
just `assert_equal.`

*Note*: The hardest part of using Ruby unit tests is that the syntax changed
after Ruby 1.8. Be sure you have installed a later version of Ruby. Be sure that
the tests really run. You'll practice this in the [Ruby
Basics](../../assignments/ruby/1-basics/description.md) homework. If you have
issues, submit questions on Piazza.

Submit/Rubric
-------------

No submission. Keep your answers as a study guide.
