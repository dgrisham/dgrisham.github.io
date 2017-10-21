Haskell: Assignment 1
=====================

Notes:

-   For all of the problems below, you *must* write a type signature for any
    function/value you write in your code.
-   You should turn in the **first two problems** on Canvas in a `.hs` file that
    has the functions you define for each part. These are due by the night of
    **Tuesday, October 24** (midnight).
-   You should *print out **Problem 3***, write your answer on that sheet, and
    turn it in on **Thursday, October 26** in class.
-   You can test your code yourself by loading your `.hs` file into `ghci`.

Problem 1 -- Factorial
----------------------

For each of the following sub-problems, you are going to write a
`factorial`{.hs} function that meets a specific requirement. The following is
relevant to both parts:

-   The input to the function is an `Int`{.hs}, $n$
-   The output of the function is the mathematical factorial of the input, $n!$,
    also an `Int`{.hs}
-   You *do not* have to handle negative input values -- assume the input is 0
    or greater.

### a.  Guard Expression

Write the `factorial`{.hs} function using a *guard expression*. You may want to
refer to the fibonacci function `fib`{.hs} in the lecture notes.

### b.  Pattern Matching

Write the `factorial'`{.hs} function using *pattern matching* (and no guards).
You may want to refer to the second fibonacci function `fib'`{.hs} from the
lecture notes.

*Note the `'`{.hs} at the end of the function name `factorial'`{.hs}, which
differentiates it from the function to wrote in part **a***.

\pagebreak

Problem 2 -- `Maybe`
--------------------

Haskell does not have an untyped empty value like `NULL`{.cpp} in C++,
`nil`{.ruby} in Ruby, `None`{.python} in Python, `null`{.hs} in Java, etc.
Instead, Haskell uses data types and polymorphism to reach a similar end. The
type used for this is `Maybe`{.hs}, which is defined as:

```haskell
data Maybe a = Nothing | Just a
```

`Nothing`{.hs} is Haskell's equivalent of `NULL`{.cpp}. But this type definition
looks kind of funny, primarily because of the `a`{.hs}.

Recall Haskell's general list type, `[a]`{.hs}. The `a`{.hs} is a *type
variable*, so one way to read `[a]`{.hs} is "a list of elements of any type".
The `a`{.hs} in `Maybe a`{.hs} is also a type variable. So, just as we can have
a list of `Int`{.hs}s with the type `[Int]`{.hs}, we can also have a `Maybe
Int`{.hs}.

Now turning to `Maybe`{.hs}'s constructors, we have `Nothing`{.hs} and
`Just a`{.hs}.

-   `Nothing`{.hs} is simply a constructor with no arguments -- by default, its
    type binding is `Nothing :: Maybe a`{.hs}, but within a particular context
    it may be `Nothing :: Maybe Int`{.hs}, `Nothing :: Maybe String`{.hs}, etc.
-   The `Just a`{.hs} constructor tells us that we can use the `Just`{.hs}
    constructor with an *argument of any type* (hence the type variable
    `a`{.hs}).

Let's look at a few examples using `Maybe`{.hs}'s constructors.

If we bind `Nothing`{.hs} to a symbol `n`{.hs} and we don't assign a type, like
so:

```haskell
n = Nothing
```

Then the compiler will infer `n`{.hs}'s type to be `Maybe a`{.hs}, since it has
no way to narrow down the type variable `a`{.hs} any further.

We could also force `n`{.hs} to be of a more specific type:

```haskell
n :: Maybe Int
n = Nothing
```

or

```haskell
n = Nothing :: Maybe Int
```

The compiler can infer a bit more about a binding that uses `Just`{.hs}:


```haskell
j = Just "hi"
```

In this case, Haskell will infer that `j`{.hs}'s type binding must be
`j :: Maybe String`{.hs}, since we provided a `String`{.hs} argument to the
`Just`{.hs} data constructor.

To see where `Maybe`{.hs} might be useful, consider the function
`head :: [a] -> a`{.hs}, which returns the first element of a list. What if the
input list is empty? `head`{.hs} wouldn't be able to return a value of the
expected type. In fact, if you called `head []`{.hs} in `ghci`, you'd get an
error.

Now imagine a function `headMaybe`{.hs} with the type binding:


```haskell
headMaybe :: [a] -> Maybe a
```

Example function calls:

```
headMaybe [1, 2, 3]
=> Just 1
headMaybe ['a', 'b', 'c']
=> Just 'a'
headMaybe []
=> Nothing
```

From these examples, we can see that `headMaybe`{.hs} returns
`Just <first_element>`{.hs} on success, and `Nothing`{.hs} on failure.

Define the function `headMaybe`{.hs} so that it behaves as described above.

*Hint: All you should use on the right-hand side (RHS) of your definition are
the constructors for `Maybe`{.hs} as well as the `head`{.hs} function mentioned
above.*

\pagebreak

Problem 3 -- Reduction
----------------------

Recall the `Peano`{.hs} number data type example from lecture:

```haskell
data Peano = Zero | Succ Peano
    deriving Show
```

In lecture, we wrote a particular definition for a function `add`{.hs} that
added two `Peano`{.hs}s together. Our definition was longer than it needed to
be, though. Here's a partial definition for a different form of the `add`{.hs}
function:

```haskell
add :: Peano -> Peano -> Peano
add Zero p = p
```

**a. Add *one* more case to the `add`{.hs} function's definition that completes
the definition and will successful add all `Peano`{.hs} numbers. Write the line
below.** *Hint: Think about the two fundamental cases in a recursive
function.*

\vspace{1.25cm}

**b. Using your completed definition of `add`{.hs}, write out the reduction
steps for the expression `add two one`{.hs}, where `two = Succ (Succ Zero)`{.hs}
and `one = Succ Zero`{.hs}.** Be sure to define your *reduction rules* before
you do the reduction steps (there should be **4 rules** in this case).

**Rules:**

\vspace{3.0cm}

**Steps:**

