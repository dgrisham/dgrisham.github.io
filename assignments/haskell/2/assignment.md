Haskell -- Assignment 2
=======================

**Update: All of the problems have now been added to this assignment. You'll
notice that I mention something about unit tests in the notes below -- I'll
release the unit tests file soon, along with instructions on how to use it,
but you can work on all of the problems in the meantime.**

**This assignment is worth 34 points.**

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
-   Write the line `module Assignment2 where` at the top of your file (and
    this line should not be indented). You will lose **4 points** if you don't
    have this line.

Problem 1 -- `zipWith'` (8 pts.)
--------------------------------

Recall the functionality provided by `map`, `zip`, and `zipWith`:

```
map not [True, False, True]
=> [not True, not False, not True]
=> [False, True, False]
```

*Note: The middle line of the `map` example above is meant to help you
understand how `map` works by breaking it down a bit.*

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

Problem 2 -- List Comprehensions (6 pts.)
-----------------------------------------

Define the following functions using *list comprehensions*.

*2 pts. each*

a.  `caps` should return all of the capital letters of the input list.

```
caps ['A', 'B', 'c', 'd, 'E']
=> ['A', 'B', 'E']
```

b.  `sumOdd` should calculate the sum of the odd numbers in a list.

```
sumOdd [1..5]
=> 9
```

c.  `negsInList` should calculate the number of negative elements in a list.

```
negsInList [1, 2, 3]
=> 0

negsInList [1, -2, -3]
=> 2
```

Problem 3 -- `maybeElem` (2 pts.)
---------------------------------

The `elem` function (included in the Haskell standard library, `Prelude`)
returns `True` if an element is in a list and `False` otherwise.

```
elem 1 [1, 2, 3]
=> True

elem 0 [1, 2, 3]
=> False
```

Write a function called `maybeElem` that returns `Just <value>` if the input
value is in the list and `Nothing` otherwise.

```
maybeElem 1 [1, 2, 3]
=> Just 1

maybeElem 0 [1, 2, 3]
=> Nothing
```

Problem 4 -- Expression Types (9 pts.)
--------------------------------------

*Each of these sub-problems relates to chapter 4 of LYAH.*

*3 pts. each*

**a. *as patterns***

Write a function named `courseMajor` that accepts a CSM course number and
returns a sentence about the major with the form
`"<course_num> is a <major> course"`. Assume that `<major>` is the first two
characters of the `<course_num>`. *You must use an **as pattern** in your
function definition.*

```
courseMajor "CSCI400"
=> "CSCI400 is a CS course"

courseMajor "PHGN100"
=> "PHGN100 is a PH course"
```

**b. *where-clause***

Write a function named `calcAreas` that takes a list of tuples of the form
`(<length>, <width>)` and returns a list of areas. *In your `calcAreas`
function, you must use a `where` clause to define a helper function.*

```
calcAreas [(3, 4), (6, 7), (1, 0)]
=> [12, 42, 0]
```

**c. *guards***

Write a function named `orderTwo` that takes a tuple of two orderable values of
the *same type* and returns a tuple with the values in ascending order. *You
must use a guard expression to define your function.*

*Hint: Read the above description carefully, the type signature is important
here and should be as general as possible.*

```
orderTwo (2, 3)
=> (2, 3)

orderTwo (3.5, 2)
=> (2, 3.5)

orderTwo ('b', 'a')
=> ('a', 'b')
```

Problem 5 -- Higher-Order Functions (9 pts.)
--------------------------------------------

*3 pts. each*

**a. `swap`, `swapAll`**

Write a function named `swap` that accepts a tuple and swaps the two elements.
Then, write a function called `swapAll` that works on a list of tuples. *You
must use `map` in your definition of `swapAll`.*

```
swap (4, 5)
=> (5, 4)

swapAll [(4, 5), (6, 4), (25, 36)]
=> [(5, 4), (4, 6), (36, 25)]
```

**b. `applyIfTrue`**

Write a function called `applyIfTrue` that takes 3 parameters: a function, a
value, and a boolean. If the boolean is `True`, then you should return the
result of applying the function to the value. Otherwise, just return the
original value.

```
applyIfTrue (*3) 5 True
=> 15

applyIfTrue (*3) 5 False
=> 15

applyIfTrue ((++) "No") " thanks" True
=> "No thanks"

applyIfTrue ((++) "No") " thanks" False
=> "No"
```

**c. `calcArea`**

Write a function called `calcArea` that accepts two lists, one of lengths and
one of widths, and returns a single list of areas.

```
calcArea [1, 2, 3] [4, 5, 6]
=> [4, 10, 18]

calcArea [0, 1.1, 2.2] [1, 3, 4]
=> [0, 3.3, 8.8]
```
