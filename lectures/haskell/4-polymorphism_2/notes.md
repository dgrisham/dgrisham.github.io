Polymorphism
============

Lists
-----

*Continued from previous*

Recall the data constructors for a `[a]`{.hs} (list):

```haskell
[]  :: [a]
(:) :: a -> [a] -> [a]
```

### `head` and `tail`

Let's look at a few common list functions, and see how we can use pattern
matching to define them.

```haskell
head :: [a] -> a
tail :: [a] -> [a]
```

### Question

What do you think these functions do?

**Answer:**

-   `head`{.hs} returns first element of list
-   `tail`{.hs} returns all of list after first element

```haskell
head (x:xs) = x
tail (x:xs) = xs
```

Think about the pattern matching we did with other constructors, like
`Succ Peano`{.hs}, `Point Float Float`{.hs}, and tuples (e.g. `(x, y)`{.hs}).
We're doing the same thing here, except the constructor is now the infix
operator `:`{.hs}, so it looks kind of funny.

We can, of course, ignore some of these values on the LHS:

```haskell
head :: [a] -> a
head (x:_) = x

tail :: [a] -> [a]
tail (_:xs) = xs
tail []     = []
```

Let's consider a few calls to these (these are *reductions*, not valid Haskell):

```
head [3, 4] => head (3:[4]) => 3
tail [3, 4] => tail (3:[4]) => 4

head [3] => head (3:[]) => 3
tail [3] => tail (3:[]) => []
```

More Pattern Matching Examples
------------------------------

**TODO**

Polymorphic Data Types
======================

List
----

```{.haskell .example}
data List a = Nil | Cons a (List a)
```

### Question

What are the types of the `List`{.hs} constructors we just wrote?

**Answer:**

```haskell
Nil  :: List a
Cons :: a -> List a -> List a
```

Compare these to the constructors for `[a]`{.hs}:

```haskell
[]  :: [a]
(:) :: a -> [a] -> [a]
```

So the constructors we wrote have the properties:

-   `Nil`{.hs} is the 'zero value' for the `List a`{.hs} type
-   `Cons a (List a)`{.hs} means that the `Cons`{.hs} constructor has two
    arguments:
    1.  A value of any type (represented by the first `a`{.hs})
    2.  A `List a`{.hs}, where `a`{.hs} is of the same type as the first
        `a`{.hs}

The second constructor looks confusing, but just remember that the definition of
a data constructor consists of an identifier (`Cons`{.hs}, in this case)
followed by a sequence of the *types of the values that can be used as arguments
to the constructor*.

### Constructing a `List a`

```{.haskell .example}
empty :: List a
empty = Nil

emptyInt :: List Int
emptyInt = Nil

ints :: List Int
ints = Cons 1 (Cons 2 Nil) -- analogous to [1, 2]
```

### Question

How would you write the `head`{.hs} and `tail`{.hs} functions that we write for
`[a]`{.hs} for our `List a`{.hs} type? (Call them `headList`{.hs} and
`tailList`{.hs}.)

**Answer:**

```{.haskell .example}
headList :: List a -> a
headList (Cons x _) = x

tailList :: List a -> List a
tailList (Cons _ xs) = xs
tailList Nil         = Nil
```

Notice that our `headList`{.hs} function does *not* handle the `Nil`{.hs} case
(just as the `head`{.hs} function does not handle the `[]`{.hs} case). We'll
explore this more in the homework.
