Higher-Order Functions
======================

Currying
--------

Consider a single-argument function with the type signature:

```haskell
f :: Char -> Int
```

When you call `f`{.hs} on some `Char`{.hs}, you get an `Int`{.hs} result. You
can think of this as filling in the `Char`{.hs} argument of function `f`{.hs}.

Likewise, if we had a function with two arguments and one output:

```haskell
add :: Num a => a -> a -> a
add x y = x + y
```

We call this function by filling in both of the arguments:

```haskell
add 3 4
```

This is the same as writing:

```haskell
(add 3) 4
```

The `add 3`{.hs} is a *partially applied function* that has the type
`Int -> Int`{.hs}. This means that we could do the following:

```haskell
addThree :: Int -> Int
addThree = add 3
```

This works because functions in Haskell are *curried*, which means they take in
a single argument at a time and produce a new function as a result (then that
new function might accept another argument, and so on).

Here's another example of currying:

```haskell
maxZero :: (Num a, Ord a) :: a -> a
maxZero = max 0
```

Consider the type signature of `max`{.hs}:

```haskell
max :: Ord a => a -> a
```

Notice that the type variable in the signature for `maxZero`{.hs} is *more
constrained* than the type variable for `max`{.hs} -- the type of the input to
`maxZero`{.hs} has to be both a `Num`{.hs} *and* and `Ord`{.hs}, rather than
just an `Ord`{.hs}. When we partially applied the function by writing
`max 0`{.hs}, we put a further constraint on the future inputs (namely that the
next input had to also be a `Num`{.hs}, since `0`{.hs} is a `Num`{.hs}).

Here's an example of a partially applied function used with `map`{.hs}:

```
map (*3) [1, 2, 3]
=> [3, 6, 9]
```

Here, the partially applied function is `(*)`{.hs}, which we provided with a
single argument, `3`{.hs}.

We could also write a function that triples the elements of *any* list:

```haskell
tripleMap = map (*3)
```

Consider a call to this function:

```haskell
tripleMap [1, 2, 3]
```

Thanks to *referential transparency*, we can replace `tripleMap`{.hs} with its
definition to get a better idea of how this works:

```
tripleMap [1, 2, 3]
=> map (*3) [1, 2, 3]
```

### Question

What is the type of `tripleMap`{.hs}?

**Answer**:

```haskell
tripleMap :: Num a => [a] -> [a]
```

This is another case where the partial function application restricted the
function signature a bit, in this case forcing the types of the elements of the
input/output lists to satisify the `Num`{.hs} typeclass.

`filter`
--------

Let's look at one more useful higher-order function, `filter`{.hs}:

```haskell
filter :: (a -> Bool) -> [a] -> [a]
```

Consider the type signature, along with the following example calls:

```
filter (> 3) [1,2,3,4,5]
=> [4, 5]

filter even [10,9..0]
=> [10, 8, 6, 4, 2, 0]
```
