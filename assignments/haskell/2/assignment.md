Haskell -- Assignment 2
=======================

**This assignment is not yet finished, problems will continue to be added until
this message is removed. But you can start working on the problems that are
here.**

Notes:

-   You *must* write type signatures for all functions/values you define.
-   This assignment will be graded with unit tests, so for each problem **be
    sure you use the exact function name given in the problem statement to
    define your function**.
-   **No credit** will be given if you submit an assignment that will not load
    the test file. So, if you cannot get a test to pass:
    1.  Submit a file that includes *only* passing functions.
    2.  Submit a revised unit test file that only includes tests for your
        passing functions.
-   Name your file `assignment_2.hs`.
-   Write the line `module Assignment2 where` at the top of your file. You will
    lose **4 points** if you don't have this line.

Problem 1 -- `zipWith'`
-----------------------

Recall the functionality provided by `map`, `zip`, and `zipWith`:

```
map not [True, False, True]
=> [not True, not False, not True]
=> [False, True, False]
```

```
zip [1, 2, 3] ['a', 'b', 'c']
=> [(1, 'a'), (2, 'b'), (3, 'c')]
```

```
zipWith (+) [1, 2, 3] [4, 5, 6]
=> [(+) 1 4, (+) 2 5, (+) 3 6]
=> [5, 7, 9]

zipWith (&&) [True, True] [False, True]
=> [(&&) True False, (&&) True True]
=> [False, True]
```

*Note: Remember, `+` and `&&` are just symbols that represent infix
functions. When we use them as `(+)` and `(&&)`, we're calling them as
prefix functions rather than infix functions.*

Also recall their type signatures:

```haskell
map :: (a -> b) -> [a] -> [b]
zip :: [a] -> [b] -> [(a, b)]
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
```

Implement `zipWith` using `map` and `zip`. **Call your function `zipWith'` so
that the name doesn't conflict with the existing `zipWith` function.**

Problem 2 -- List Comprehensions
--------------------------------

Define the following functions using *list comprehensions*.

*2 pts. each*

1.  `sumOdd` should calculate the sum of the odd numbers in a list.

    ```
    sumOdd [1..5]
    => 9
    ```

2.  `negsInList` should calculate the number of negative elements in a list.

    ```
    negsInList [1, 2, 3]
    => 0
    negsInList [1, -2, -3]
    2
    ```

