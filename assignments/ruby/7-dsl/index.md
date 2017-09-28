Homework: Ruby Domain-Specific Language (DSL)
=============================================

Purpose
-------

-   Ruby metaprogramming
-   Create a domain-specific language
-   Explore Ruby error handling
-   Learn to solve a problem by analogy

Preparation
-----------

-   Pick a partner (highly recommended)
-   Download and review the [example Quiz
    code](../../../slides/ruby/5-metaprogramming/src/quiz.zip) from lecture.

Some useful links about DSL:

-   [http://jroller.com/rolsen/entry/building\_a\_dsl\_in\_ruby](%20http://jroller.com/rolsen/entry/building_a_dsl_in_ruby)
-   <http://www.infoq.com/news/2007/06/dsl-or-not>
-   <http://www.valibuk.net/2009/03/domain-specific-languages-in-ruby/>
-   [This link explains MiniTest
    Assertions](http://stackoverflow.com/questions/7296600/proper-assert-raise-unit-testing-and-use-of-exception-class),
    including `assert_raise`

An interesting [video on
metaprogramming](http://www.youtube.com/watch?v=SAEiCkixrdE)

Lesson
------

You've been hired to write a system for a local company (*Just Do It Sports*)
that sells sporting goods and related items. This company *loves* promotions...
so they have lots of freebies. Some of their promotions involve partnerships
with local artists, writers and merchants (e.g. ski resorts). For example, they
carry books that are self-published by local writers, and when a purchase is
made, they pay commission.

The company is also dreaming big, and thinks that if you can make a product
that's flexible enough to meet their needs, it will probably be suitable to sell
to other sporting goods stores. (You, of course, would negotiate for a major
share of the proceeds if that actually happens!)

The first problem *Just Do It* needs help with is processing orders. They
control their process with a set of "business rules" such as the following:

-   When a book is purchased, create a packing slip for the shipping department
    and a duplicate copy for the royalty department.
-   When a ski pass is purchased, send an email to the purchaser and a
    notification to the ski resort.
-   When a book or ski video is purchased, pay commission.
-   When a ski video is purchased, create a packing slip for the shipping
    department and include a free first aid video
-   When a membership to the store's discount club is purchased, activate the
    membership and send an email to the purchaser
-   When ski boots are purchased, include a certificate for a discount on boot
    fitting.
-   When a ski helmet is purchased, fill out a warranty card

You're feeling like this is somewhat complex, but doable. Then you find out
there are two more pages of rules like these *and* the rules change regularly.
Furthermore, when rules change they need to be implemented within a day. You're
getting ready to panic, when you remember a cool topic from your Programming
Languages class: Domain-Specific Languages!

You remember that a DSL is just a mini language that serves a special purpose.
DSLs are often used for boring stuff like configuration files, but in this case,
you plan to create a mini "language" to describe the business rules. The
language will include statements with the syntax:

`action <action_type>, <parameter>`

where each `<action_type>` relates to some activity like printing a packing
slip, sending an email, etc. The `<parameter>` is optional.

These statements will be associated with products (similar to how, in the Quiz
example, answers were associated with a question). A sample DSL file is shown
below. Notice that the rules for a product do not have to be all together in the
file (e.g. the membership rules come between different rules related to books).

```
product 'book'
action 'packing_slip', 'shipping'
action 'packing_slip', 'royalty'

product 'book'
action 'activate'

product 'book'
action 'pay', 'commission'
```

*Figure 1: Sample DSL Rules file*

You run this idea past a friend, who says "Wait a minute, aren't DSLs vulnerable
to attack?" Yes, you agree, but in this case you will be the one using the DSL
(you wouldn't want some external party to write your business rules, would you?)
And you're sure this will impress the customer, because with just a few lines of
"code" entered into a text file, you can easily modify how the business
operates. Want to stop paying commission? Delete the line that says pay
commission. Want to add a free video to another product? Add a line to your
file. The customer will think it's magic!

But your friend is persistent. "Sure, you're going to write the rules," he says.
"But shouldn't there be some type of error handling? What if you don't write the
rule in the right format? After all, in a real language the compiler will ensure
your syntax and grammar are correct...don't you need to do some of that?"

Well of course! But these rules have a simple structure...is a compiler really
necessary? No, you decide...you'll just put in sufficient error handling to
ensure the format of each statement is correct. And this will also give you a
chance to practice exception handling in Ruby. Very cool.

### Your Challenge

The end goal is to have a program that:

Includes a main menu that allows users to load different rules files, process
orders, and quit

Prompts the user for the name of a business rules file (will allow the store to
have temporary rules for a weekend sale, for example)

Reads in a set of business rules (format similar to Figure 1 above)

-   Stores the data in some usable format (e.g. I used a hash). This is similar
    to storing the questions and answers for the Quiz example.
-   Displays an error message and aborts if the rule format is bad.

Processes orders

-   The user will be prompted for a product type.
-   If the product is valid, display the actions (e.g. pay commission)
    associated with that product. NOTE: In a real system, each action would do
    some real work, such as printing a packing slip, or really sending an email.
    For now, we're just displaying a message so that we can test our DSL.
-   If the product is not valid, display an error message but allow the user to
    continue.

Figures 2 and 3 show sample sessions. Notice:

-   "membership" has different actions, depending on which rules file was
    loaded,
-   An error message is displayed when an invalid product (i.e. giraffe) is
    entered,
-   Either an upper or lower case D may be used to end processing orders,
-   Business rules files should have an extension of `.txt`. To reduce typing,
    user may enter the filename with or without `.txt` and the program will
    append `.txt` only if needed,
-   An error message is displayed if the filename is invalid,
-   An error message is displayed if the format of the rules file is incorrect.

```
<<<< Main Menu >>>>
1. Load rules
2. Process orders
3. End
Your option: 1

Enter filename containing rules: JustDoIt

<<<< Main Menu >>>>
1. Load rules
2. Process orders
3. End
Your option: 2

Enter product type or 'D' (done) to end: membership

Processing order for a: membership
---- Activating membership
---- Emailing purchaser

Enter product type or 'D' (done) to end: d

<<<< Main Menu >>>>
1. Load rules
2. Process orders
3. End
Your option: 1

Enter filename containing rules: MtnLover.txt

<<<< Main Menu >>>>
1. Load rules
2. Process orders
3. End
Your option: 2

Enter product type or 'D' (done) to end: membership

Processing order for a: membership
---- Activating membership

Enter product type or 'D' (done) to end: giraffe

Undefined product: giraffe
```

*Figure 2: Normal operation*

Error handling example:

```
<<<< Main Menu >>>>
1. Load rules
2. Process orders
3. End
Your option: 1

Enter filename containing rules: stuff

Invalid filename! Pleae try again.

<<<< Main Menu >>>>
1. Load rules
2. Process orders
3. End
Your option: 1

Enter filename containing rules: badRules

Undefined action in rules file: activiate Aborting...

Please contact tech support for more assistance.
```

*Figure 3: Error handling*

### Extra Hints and Requirements

#### Getting Started

As with all programming, it's good to start slow. The first step is to
*thoroughly* understand the Quiz example. If you don't, there's much less chance
of being successful with this program, because it's like the Quiz program but
with a twist (or two).

I suggest that your first step should be to load the business rules. This is
similar to [questionsv1.rb](supplements/questionsv1.rb).

#### Errors in the rules file

Your program must handle the situation where there is an error in the rules
file. For example, assume your rule file includes the following lines:

```
product 'membership'
action 'activiate'
```

The action in this case should be `activate`, but there's a typo (what in the
world is activiate??). The code that loads the business rules must catch this
type of error and display a message. Furthermore, you *must* use exception
handling. Note that Ruby throws a `NameError` if you try to call a method that
does not exist...that's the exception you'll need to catch and handle with a
helpful error message (see the example of processing `badRules` above).

Note that if an invalid filename is entered, the program displays an error
message and continues (so user can enter a correct name). But if there is an
error loading the rules, the program should abort. How should you do that in a
way that's testable? By raising an exception. For example, I have a method named
`load_rules`. If a `NameError` is thrown, I first "handle" it by printing a
message that the action is not defined. I then raise the same error...so that
the method that called `load_rules` is aware of the problem. In my code, this is
where I display "Please contact tech support for more assistance". I expect some
Piazza questions related to exception handling!

We of course want to include unit tests for loading the rules. Just as in Java,
you can ensure that an exception is thrown. In Ruby you can use `assert_raise`
to ensure that a `NameError` is thrown.

#### Storing product rules

Your program should include some type of `Product` class, similar to the
`Question` class in the example. In the Quiz program, each `Question` object
includes the text of the question and an array of objects of type `Answer`. What
should be stored for each Product?

#### Processing orders

So how do you print the appropriate actions for a product? Remember that we want
to be able to quickly change how an order is processed...so we do *not* want a
method that says "if this is a book, print a packing slip for shipping, print a
packing slip for royalties, pay commission." Instead, we want the actions that
we've stored for the product to determine what happens. Each action (e.g.
`packing_slip`, `pay`, `activate`) should correspond to a method. Note that some
actions require parameters (e.g. `packing_slip 'shipping'`) and some do not
(e.g, `activate`).

In other words, we need to link the "actions" from our mini-language to method
calls. How can we do that? That is, how can we convert the string we read from
our file (e.g. `activate`) to a method call? And how can we store both an action
and a parameter, then pass that parameter to the method when it's called? (note:
these issues are part of the "twist" that makes this different from the simple
Quiz example)

A few hints (this is not intended as a complete solution, just pointers toward a
direction...Piazza is good for questions, after you've given it some more
thought. It's also not required that you use any of these...although it's likely
you'll use at least some):

-   I used `to_sym`{.ruby} to convert strings to symbols
-   I used `respond_to?`{.ruby} for error handling
-   I used `instance_eval`{.ruby} to call the appropriate method.
-   I made use of a `singleton`{.ruby} class called `orderRules`{.ruby} to store
    the hash of rules

#### Unit Testing

You will need a unit test for loading the file. What tests would convince you
that the files are loaded correctly? (Brainstorm on Piazza if you're not sure.)

You will need a unit test related to error handling.

Rubric
------

This lesson is worth **90 points**.

### Rules files

-   \(2) Create at least two "valid" files (e.g. I have `JustDoIt` and `MtnLover` in
    my example execution)
-   \(1) Rules files should includes all rules listed at the top of the assignment
    (may have some in one file, some in the other...and some additional rules, for
    example like the two membership rules in Figure 2)
-   \(1) Create a file with a bad action. Name this file `badRules.txt`.
-   You may want to create another rules file for your unit tests. I created a
    file named `simpleRules.txt` with only a few products, to simplify testing.

### Defining the rules

-   \(2) Define at least six types of products (include all products from the example
    at the top of this assignment, plus others as you desire)
-   \(4) Include actions with and without parameters
-   \(4) Be able to add rules to a product (like book example)

### Main Menu

-   \(2) Displays options
-   \(2) Ensures valid option is entered
-   \(2) Calls appropriate method or exits program

### Loading the rules

-   \(5) Prompt the user for the filename. Add a .txt extension if needed.
-   \(4) Display an error message (but don't abort) if file does not exist
-   \(5) Define the methods needed to load the business rules file (similar to
    `questionsv1.rb`)
-   \(10) Store the rules in a suitable data structure
-   \(5) Abort with appropriate message if loading the rules fails (must use
    exceptions)

### Processing the orders

-   \(4) Prompt the user and accept a product
-   \(4) Display error message if product not defined (i.e. if no rules were loaded
    for that product). Program does not abort (like `giraffe` example in Figure 2).
-   \(15) If product is defined, display the associated actions
-   \(3) Loop ends when sentinel value (e.g. `d` or `D`) is entered

### Unit tests

-   \(5) Include a test for loading a simple set of rules
-   \(3) Include a test for loading rules with a bad action

### Execution and Style

-   \(4) Include sufficient comments
-   \(3) Include a readme file so the grader can easily determine how to run your
    program and your unit tests. If your instructions tell the grader to edit your
    source code for any purpose (e.g. to use a different rule file), there will be a
    3-point deduction. You should set up your unit tests so they do not require the
    entire program to be executed. (Hint: Make your code more modular; it's good
    practice!)

Submit
------

Zip your `.rb` and `.txt` files and submit on Canvas. Be sure to include your
partner's name (if you have one).

Acknowledgment
--------------

Inspiration for this lab came from a Code Kata by Dave Thomas.
