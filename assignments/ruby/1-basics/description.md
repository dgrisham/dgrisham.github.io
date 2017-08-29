Homework: Ruby Basics
=====================

Purpose:
--------

-   Practice basic Ruby syntax

Preparation
-----------

-   Review the class notes
-   Do some practice tutorials
-   Download [this Ruby code template](src/basic_word_game.rb).
-   A useful description of symbols:
    <http://www.troubleshooters.com/codecorn/ruby/symbols.htm>

Lesson
------

The purpose of this exercise is to practice some specific Ruby syntax and
functionality. It is not intended as a creative or very realistic exercise. I
expect that you will be looking at the class slides while doing this exercise.
This is important because if the instructions say, for example, to use an
expression modifier, you will want to look at slide 6 of [the control flow
slides](../../../slides/ruby/1/c-control_flow/slides.pdf), and if it says to use
a conditional return value, you'll want to look at slide 5, etc.

Note that many of these requirements will be pretty simple, and just
encourage you to use cool Ruby syntax. The `yield` statement and unit test
will potentially take a bit more thought.

The context of this lesson is creating methods that could be used to
create a Scrabble-like word game. There are two aspects we're
addressing:

-   Calculating a score for a word
-   Displaying a "leader board" of the top scores

We are *not* creating a complete word game (you will be writing a
Hangman game soon, which will be more fun... but it won't use these
methods).

A sample execution of the program is shown below. Your output should
match this as closely as possible.

```
Showing a couple of word scores
Score for hello is: 7 (should be 7)
Score for banana is: 9 (should be 9)

Showing the leader board, various options

We have a Lone wolf
The first score is 100
There is no second score
There is no third score
Congratulations to Lone wolf

We have a Top Dog
The first score is 100
The second score is 90
There is no third score
Congratulations to Top Dog

We have a Top Dog
The first score is 100
The second score is 90
The third score is 80
Congratulations to Top Dog

We have a Top Dog
The first score is 100
The second score is 90
The third score is 80
The total of the remaining scores is 70
Congratulations to Top Dog

We have a Top Dog
The first score is 100
The second score is 90
The third score is 80
The total of the remaining scores is 130
Congratulations to Top Dog

Showing the quartiles
Quartile total: 190
Quartile total: 150
Quartile total: 110
Quartile total: 70

Unit tests follow...
Run options!

# Running tests:

.
Finished tests in 0.000000s, Inf tests/s, Inf assertions/s
1 tests, 3 assertions, 0 failures, 0 errors, 0 skips
```

Rubric
------

This lesson is worth 40 points. Be sure to follow the "you MUST"
instructions within the provided source template.

Points | Metric
:----: | :-----
2      | `word_scores` method
5      | `letter_counts` method
10     | `leader_board` method
2      | `display_score` method
6      | `create_scores` method
6      | `get_quartiles` method
2      | `display_quartiles` method
6      | Unit test for `word_scores`
1      | Adheres to simplicity of grading criteria

For simplicity of grading, please:

-   Name your program `word_game.rb`
-   Ensure you can run your program from the command line as:
    `ruby word_game.rb`

*Note*: For any assignment which lists 'simplicity of grading' criteria,
failure to follow the directions *will* result in loss of points. Amount
of deduction will depend on factors such as being a repeat offender.

Also remember the grading policy: Programs submitted for grading *must*
run. Do not submit a buggy program that doesn't run. It is much better
to submit a working program that only meets part of the requirements. If
you need help, post on Piazza!

Submit
------

Submit your `.rb` file on Canvas.
