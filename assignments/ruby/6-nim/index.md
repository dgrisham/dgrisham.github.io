Homework: Ruby Nim
==================

Purpose
-------

-   More Ruby! You will probably learn some new Ruby on your own (e.g. I used
    some bitwise operations)
-   See how Ruby reflection works

Preparation
-----------

-   You may work with a partner on this assignment.
-   Review the rules for Nim. There are various configurations and even
    different rules (do a google search for sites such as
    <http://www.archimedes-lab.org/game_nim/nim.html>).

Lesson
------

In this lesson you will implement the game of Nim. Some high-level requirements:

-   We will be using rules that are referred to as *normal play* which means
    that the player who takes the last stick wins (the game is often played in
    reverse, so that the player who takes the last stick loses).
-   Your game should work with any board configuration (although not all
    configurations will ensure the "smart" computer player always wins). We'll
    use two specific configurations that do work: \[1,3,5,7\] and \[4,3,7\].
    Feel free to define more.
-   At the beginning of the game, the user selects the board configuration.
-   The user will also select the computer opponent. One computer player is
    "dumb" and just makes random (but valid) moves. The other computer player is
    "smart" and is guaranteed to win assuming:
        a.  the board configuration has certain properties (you'll figure this
            out when you explore the strategy), and
        b.  the computer player goes second.
-   To ensure correctness, we will use both unit tests (for individual
    functions) and a special play mode where the smart computer will play the
    dumb computer

The list of potential "computer players" must be generated using reflection. How
will this work? One option is to represent the "computer player" as simply a
method that knows how to take a turn. To identify these methods via reflection,
I had each method include `computer_player` in its name. There are other
options. For example, you might have a Nim player class, then select all classes
that are subclasses. Or select all classes that "respond to" a particular
method.

A sample execution of the game is shown below.

```
Welcome to Nim!
1: [1, 3, 5, 7]
2: [4, 3, 7]
Select board configuration (1-2): 2

1: Smart Computer Player
2: Dumb Computer Player 
Select computer player (1-2): 1

Row 1: XXXX
Row 2: XXX
Row 3: XXXXXXX
Select the row (1-3): 3
Select the number of sticks to take (1-7): 7

Smart computer took 1 stick(s) from row 1.

Row 1: XXX
Row 2: XXX
Row 3: 
Select the row (1-3): 3

No sticks left in that row.

Select the row (1-3): 2
Select the number of sticks (1-3): 4

The number of sticks must be between 1 and 3.

Select the number of sticks (1-3): 3

Smart computer took 3 stick(s) from row 1.

Smart Computer Player wins the game!
Thank you for playing!
```

For the "face off" between the two computer players, you should create a
separate Ruby class named `nim_play_tester.rb`. This program should simply contain
a loop that plays the game 20 times. Instead of prompting for the board
configuration and computer players, you will just set the board configuration
(choose either board), set the dumb computer player as the first player, and set
the smart computer player as the second player. Then begin the game. You should
*not* display the board status, but you *should* display the sticks being taken,
as shown in the example output below (partial execution). Be sure to include a
message indicating who won.

```
Dumb computer took 7 stick(s) from row 4.

Smart computer took 3 stick(s) from row 3.

Dumb computer took 1 stick(s) from row 1.

Smart computer took 1 stick(s) from row 2.

Dumb computer took 1 stick(s) from row 3.

Smart computer took 1 stick(s) from row 2.

Dumb computer took 1 stick(s) from row 3.

Smart computer took 1 stick(s) from row 2.

Smart Computer Player wins the game!
Thank you for playing!

Dumb computer took 1 stick(s) from row 1.

Smart computer took 1 stick(s) from row 2.

Dumb computer took 7 stick(s) from row 4.

Smart computer took 3 stick(s) from row 3.

Dumb computer took 2 stick(s) from row 2.

Smart computer took 2 stick(s) from row 3.

Smart Computer Player wins the game!
Thank you for playing!
```

--------------------------------------------------------------------------------

The grader will redirect the output of your game into a file and use grep to
easily show the 20 game outcomes, as shown in the following example output.

```
$ ruby nim_play_tester.rb > results

$ grep 'wins' results
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
Smart Computer Player wins the game!
```

Rubric
------

This assignment is worth **75 points**.

### Normal Game Play

-   \(3) Prompt the user for the board configuration. The possible board
    configurations should be stored as a *class variable*.
-   \(10) List all the possible computer players and prompt the user to choose one.
    You **must** use reflection to determine this. **Ease of Grading**: put a
    comment at the top of `nim.rb` explaining how you used reflection.
-   Allow the players to take turns. Specifically:
    -   \(2) For convenience, you should display the board state at the beginning of the
        human player's turn. This can be a simple ascii display, as shown in the figure.
    -   \(2) Prompt the user and accept the row and number of sticks (or matches).
    -   \(5) Validate the selection (e.g. ensure the specified row has at least the
        specified number of sticks, otherwise display an error and accept another
        entry).
    -   \(2) Remove the specified number of sticks from the board.
    -   \(5) Display a message when the game is over indicating which player won.
-   \(5) The "dumb" computer player will randomly choose a valid row (i.e. one with
    sticks remaining) and number of sticks (i.e. no more than the number of sticks
    in that row).
-   \(10) The "smart" computer always wins.
-   \(8) Specifically, the player should win efficiently (i.e. not by randomly
    generating moves and testing them...figure out deterministically how to win).
    The smart algorithm should potentially work with *any* board configuration... so
    don't hard code decisions based on a configuration. To test this, try using your
    play tester with each of your two board configurations.
-   \(3) Code should be modular and have sufficient comments. **Ease of Grading**:
    Grader must be able to quickly look at your code and see that your smart
    algorithm is not just random. Be sure to comment your approach.

### Testing

-   \(10) Write sufficient unit tests to convince yourself that the functions within
    your smart computer algorithm are working as you expect. For example, I have
    four different methods in my smart computer player that I'm testing (each with
    several asserts).
-   \(10) Auto play option. Smart computer plays dumb computer, smart always wins.

*Hint*: There are a number of sites that discuss the strategy for Nim game, but
the one I followed most closely is:

-   [http://www.dgp.toronto.edu/\~ajr/270/probsess/03/strategy.html](http://www.dgp.toronto.edu/%7Eajr/270/probsess/03/strategy.html)

Submission
----------

For ease of grading, please:

-   Name the test file `nim_test.rb`
-   Name the auto play file `nim_play_tester.rb`
-   Name your main file `nim.rb`
-   Ensure the grader can execute your tests by running `ruby nim_test.rb`, can
    run auto play using `ruby nim_play_tester.rb` and can play the game by
    running `ruby nim.rb`.

Zip your files and submit on Canvas. If you worked with a partner, submit only
one copy, and be sure to include both names in the comments.
