Expressions
===========

Bindings
--------

*Value binding* in Haskell:

```haskell
x = 3
```

Compare to C:

```c
int x = 3;
```

### Question 1

What are we missing in the Haskell case?

**Answer:** *Type binding*

```{.haskell .example}
x :: Int
x = 3
```

Haskell compiler (`ghc`) can infer types for you based on their values, but:

-   Improves readability when you include them in your code
-   It can only do so much -- for example, it could figure out that `x = 3`{.hs}
    means `x`{.hs} is a number of some sort, but not that you want it to
    specifically be an `Int`{.hs} (as opposed to `Float`{.hs})

However, there are some cases where you may prefer that the compiler infers some
types for you (but this approach is less common).

### Immutability

Can't do this:

```haskell
x = 3
-- x = 4 -- value bindings are immutable, cannot do this!
```

Or this:

```haskell
x :: Int
-- x :: Float -- not allowed, type bindings are also immutable
```

Simple Function
---------------

```haskell
f x = x + 1
```

We're again missing a type binding.

```{.haskell .example}
f :: Int -> Int
f x = x + 1
```

*Note how similar this looks to the `x = 3`{.hs} example.* You can think of
`x = 3`{.hs} as a *function with 0 arguments*; also appropriate (and perhaps
more natural) to refer to it as a *value*.

Multiple Arguments
------------------

Now let's write a function with multiple arguments.

**Goal:** `add`{.hs} function

-   *Input*: Two `Int`{.hs} args
-   *Output*: Sum of the inputs

### Question 2

What should the value binding look like?

**Answer:**

```haskell
add x y = x + y
```

### Question 3

Okay, what about the type binding? Think about how we went from
`x :: Int`{.hs} to `f :: Int -> Int`{.hs}...

**Answer:**

```{.haskell .example}
add :: Int -> Int -> Int
add x y = x + y
```

Guards
------

Guards are the equivalent of `if`/`else`.

**Goal:** `max'`{.hs} function

-   *Inputs*: Two `Float`{.hs}s
-   *Output*: The larger of the two inputs

*Note: The `max`{.hs} function is predefined in Haskell, so we'll append a
single-quote to the function name and call ours `max'`{.hs}, which Haskell
allows.*

### Question 4

What should the type binding for this function look like?

**Answer:**

```haskell
max' :: Float -> Float -> Float
```

Here's one way to define this function:

```{.haskell .example}
max' :: Float -> Float -> Float
max' x y
    | x >= y = x
    | otherwise = y
```

The guard statement determines the appropriate *value binding* when this
function is called. Example functions calls:

```{.haskell .example}
m = max' 3.5 2.0 -- binds 3 to m, also binds `Float` type
n = max' 3.5 4.0 -- binds 4 to n, also binds `Float` type
```

Fibonacci
---------

Haskell supports recursion. Given that + above info, write a fibonacci function.

*Input*: Index of the fibonacci number to calculate.

*Output*: Fibonacci number at that index (*not* a list, just a single value).

Type signature?

```haskell
fib :: Int -> Int
```

Assumptions:

-   `fib 0`{.hs} and `fib 1`{.hs} equal `1`{.hs}.
-   The input is non-negative, so we don't have to handle cases like
    `fib (-1)`{.hs}.

```{.haskell .example}
fib :: Int -> Int
fib n
    | (n == 0) || (n == 1) = 1
    | otherwise            = fib (n - 1) + fib (n - 2)
```

Alternative way to write this: *pattern match* on the input value.

```{.haskell .example}
fib' :: Int -> Int
fib' 0 = 1
fib' 1 = 1
fib' n = fib (n - 1) + fib (n - 2)
```

We can do this whenever we have a *concrete value* to test the input value
against (in this case, `n == 0`{.hs} or `n == 1`{.hs}).
