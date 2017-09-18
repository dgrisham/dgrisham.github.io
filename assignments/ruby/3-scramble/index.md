Homework: Ruby Scramble
=======================

Purpose
-------

-   More experience with Ruby
-   Operator overloading - `[]`
-   Understand Ruby open classes

Preparation
-----------

-   Be sure to finish the Hangman assignment
-   This info about [open
    classes](http://rubylearning.com/satishtalim/ruby_open_classes.html) may be
    helpful.

Lesson
------

For this assignment you'll create another simple word game. As shown in the
figure below, when you start Scramble the first word will appear with the
letters in random order (i.e., scrambled). The user guesses the word, and a
message displays to indicate whether it is correct. The user may then continue
or quit.

Unlike the Hangman game, the words in this game will be presented in order, not
randomly. The specific order doesn't matter (e.g., you can do it in the order
read from the file, or sorted, etc.). The point is to overload and use the `[]`
operator to access the words (i.e., if you have an object of type Words named
words, you can access as `words[0]`, `words[1]`, etc.).

The game ends when the user chooses not to continue *or* when the end of the
list of words is reached (an appropriate message should be displayed).

Sample execution:

```
Scrambled word: plape

What's the word?
apple
That is correct!

Continue? (Y/N)
y
Scrambled word: nnabaa

What's the word?
naanab
Sorry, that's not correct.

Continue? (Y/N)
n
```

Extra Requirements:

-   Your `Words` class should *not* extend the `Array` class. It is likely,
    however, that your Words class will *contain* an array (i.e. a "has-a"
    relationship, rather than an "is-a" relationship).
-   To experience Ruby's open class paradigm, you will *not* extend the `Words`
    class. Instead, you will add the `[]` operator to the `Words` class from
    inside the `scramble.rb` file. Yes, this may feel odd... that's why you
    should try it!

Rubric
------

This lesson is worth **18 points**.

 Points  | Metric
:------: | :-----
   2     | Initialize a Words object
   2     | Overload the \[\] operator in the Words class (but in the Scramble file)
   5     | Display a scrambled word
   2     | Access words in order using \[\]
   4     | Allow the user to continue or quit
   3     | Appropriate messages for correct guess, incorrect guess, and reaching the end of the list of words

Submit
------

For simplicity of grading, please:

-   Name your program `scramble.rb`
-   Use relative path names for the words files...**do not** include a complete
    path that will only work on your system.
-   The grader should be able to play scramble by typing `ruby scramble.rb` at
    the command line.

Zip your `.rb` files (new scramble + original words) and `.txt` files and submit
on Canvas.
