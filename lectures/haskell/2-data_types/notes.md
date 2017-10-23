Data Types
==========

**Note**: You can ignore the lines after each data declaration that say
`deriving ...`{.hs} -- these are there to make it easier for you to play with
the examples. If you're curious, though, those lines have to do with type
classes.

Simple Data Declaration
-----------------------

Basic data type declaration:

```{.haskell .example}
data Bool' = True' | False'
    deriving (Show, Eq)
```

-   `Bool'`{.hs} is the name of our data type
-   `True'`{.hs} and `False'`{.hs} are the *data constructors*

*Note: `Bool`{.hs} is already defined in Haskell, which is why the example codes
adds a `'`{.hs} to all of the types/constructors/functions in this section.*

Then we can use the constructors to create instances of this type:

```{.haskell .example}
true :: Bool'
true = True'

false :: Bool'
false = False'
```

Let's write a few of the functions that are common for booleans:

1.  `not'`{.hs}
2.  `and'`{.hs}, `or'`{.hs}
3.  `xor'`{.hs}

### `not`

```{.haskell .example}
not' :: Bool' -> Bool'
not' True'  = False'
not' False' = True'
```

### `and`

First pass:

```haskell
and' :: Bool' -> Bool' -> Bool'
and' False' False' = False'
and' False' True'  = False'
and' True'  False' = False'
and' True'  True'  = True'
```

Better:

```{.haskell .example}
and' :: Bool' -> Bool' -> Bool'
and' True'  True'  = True'
and' _     _       = False'
```

### `or`

First pass:

```haskell
or' :: Bool' -> Bool' -> Bool'
or' False' False' = False'
or' False' True'  = True'
or' True'  False' = True'
or' True'  True'  = True'
```

Better:

```{.haskell .example}
or' :: Bool' -> Bool' -> Bool'
or' False'  False'  = False'
or' _     _         = True'
```

### `xor`

First pass:

```haskell
xor' :: Bool' -> Bool' -> Bool'
xor' False' False' = True'
xor' False' True'  = False'
xor' True'  False' = False'
xor' True'  True'  = True'
```

```haskell
xor' :: Bool' -> Bool' -> Bool'
xor' False' False' = True'
xor' True'  True'  = True'
xor' _     _     = False'
```

We can reduce this by one more line (of actual logic), but not with pattern
matching (assumes we had a `==`{.hs} equality comparison function for
`Bool'`{.hs}s):

```{.haskell .example}
xor' :: Bool' -> Bool' -> Bool'
xor' b1 b2
    | b1 == b2  = True'
    | otherwise = False'
```

Purpose of this example:

-   Pattern matching can *only* compare *concrete values of a given input*
-   Pattern matching can be very concise, but is limited in its application

Data Type with Parameters
-------------------------

To add parameters to a data constructor, simply list each of the *types* of the
parameters after the constructor name:

```haskell
-- Person has Name and Age
data Person = Person String Int
```

Note that the *data constructor* (RHS) may have the same name as the *data type*
(LHS).

`String`{.hs} and `Int`{.hs} are vague, though. Let's clarify by declaring a
couple of *type synonyms*.


```{.haskell .example}
data Person = Person Name Age
    deriving Show
type Name = String
type Age = Int
```

Then we can create a `Person`{.hs}:

```{.haskell .example}
bigL = Person "Lamont Coleman" 24
```

### Question

What if we wanted to pattern match on a `Person`{.hs}?

**Answer:** We do the same thing we did with other data types: we pattern match
against *concrete values of the correct type*.


```{.haskell .example}
bob = Person "Bob" 50

trueIfBob50 :: Person -> Bool
trueIfBob50 (Person "Bob" 50) = True
trueIfBob50 (Person _     _ ) = False

trueIfBob :: Person -> Bool
trueIfBob (Person "Bob" _) = True
trueIfBob (Person _     _) = False

trueIfOld :: Person -> Bool
trueIfOld (Person _ age) = age > 24

trueIfOldBob :: Person -> Bool
trueIfOldBob (Person "Bob" age) = age > 24
trueIfOldBob (Person _     _  ) = False

-- `head` returns first element of string/list
firstInitial :: Person -> Char
firstInitial (Person name _) = head name
```

*Note: Whenever we don't care about a particular input value, we use an `_` to
say "I don't care what the input value to this parameter is, and I'm not going
to use it on the RHS of the function so don't bother giving it a name".*

### Tuples vs. Data Constructors

Note that we could also use a tuple to make a single data type out of multiple
values. For example, we could define a `Point`{.hs} as a type synonym of a
tuple of `Float`{.hs}s:

```haskell
type Point = (Float, Float)

point :: Point
point = (1.1, 2.4)
```

The data constructor analog would look like:

```haskell
data Point = Point Float Float
    deriving Show

point :: Point
point = Point 1.1 2.4
```

The difference comes down to judgement and specific cases, but here are the main
thoughts to keep in your mind:

-   A *type synonym* is simply a different name for a type, so the synonym is
    interchangeable with the original type.
-   A good rule of thumb is to make anything in your code that is especially
    meaningful/important into it's own data type (rather than a synonym).

### Type Synonym Example

Let's look at a case where a type synonym fits very well. Imagine we had the
`Point`{.hs} data type we defined above, along with these functions:

```haskell
getX :: Point -> Float
getX (Point x _) = x

getY :: Point -> Float
getY (Point _ y) = y
```

Now let's say we want to change the `Float`{.hs} arguments in the `Point`{.hs}
constructor to be `Int`{.hs}s instead:

```haskell
data Point = Point Int Int
```

However, this breaks our `getX`{.hs} and `getY`{.hs} functions, because they
each try to extract a `Float`{.hs} from a `Point`{.hs}, *not* an `Int`{.hs}.

A type synonym can help us here. Let's define the type `Coordinate`{.hs} to mean
the same thing as `Float`{.hs}:

```{.haskell .example}
data Point = Point Coordinate Coordinate

type Coordinate = Float
```

Now our `Point`{.hs} contructor accepts two `Coordinate`{.hs}s. Our `getX`{.hs}
and `getY`{.hs} now look like:

```{.haskell .example}
getX, getY :: Point -> Coordinate
getX (Point x _) = x
getY (Point _ y) = y
```

If we came back later wanted to change the `Coordinate`{.hs} type to be
`Int`{.hs} instead of `Float`{.hs}, we would only have to change a single line:

```haskell
type Coordinate = Int
```

And since the types of the `Point`{.hs} constructor and the `getX`{.hs},
`getY`{.hs} functions refer to `Coordinate`{.hs}, we don't have to change
anything else and everything should still work.

This example was somewhat contrived though, as there very well may be a part of
the code somewhere that is dependent on `Float`{.hs} and changing the meaning of
`Coordinate`{.hs} to `Int`{.hs} might break that. A very simple case:

```haskell
point = Point 3.4 5.6
```

If we tried to declare this `point`{.hs} value but `Point`{.hs} was expecting
two `Int`{.hs} coordinates, then our code wouldn't compile.

Data Constructor Types
----------------------

Like most of what we've dealth with in Haskell, data constructors have types.

### Question

a.  What is the type of `True'`{.hs}?

**Answer:** `Bool'`{.hs}

(We can verify in `ghci` with `:t True'`.)

b.  What is the type of the *constructor* `Person`{.hs}?

Consider how we created a `Person`{.hs}:

```haskell
bob = Person "Bob" 50
```

**Answer:** `Person :: Name -> Age -> Person`{.hs}

This looks a lot like a function!

Recursive Data Types: Peano Numbers
-----------------------------------

The *peano numbers* are a way to represent integers using only a zero value and
a successor function.

```{.haskell .example}
data Peano = Zero | Succ Peano
```

We have two data constructors here

-   `Zero`{.hs}, which has no arguments
-   `Succ`{.hs}, which takes a single argument of type `Peano`{.hs}
    -   This makes `Peano`{.hs} a *recursively-defined data type*

### Question

Given:

```{.haskell .example}
zero = Zero
```

a.  How do we create a value `one`{.hs} that is the successor of `Zero`{.hs}?
    How about `two`{.hs}?

**Answer:**

```haskell
one = Succ zero
two = Succ one
```

b.  How else could we constructor `two`{.hs}?

```haskell
two = Succ (Succ zero)
-- or
two = Succ (Succ Zero)
```

### Question

How can we (exhaustively) convert these into the numbers we're used to? Start
with the type signature: `peanoToInt :: Peano -> Int`{.hs}

**Answer:**

```haskell
peanoToInt :: Peano -> Int
peanoToInt Zero = 0
peanoToInt (Succ Zero) = 1
peanoToInt (Succ (Succ Zero)) = 2
-- this could go on awhile...
```

### Increment/decrement functions

**Goal:** Function `increment`{.hs} that returns the successor of the input
`Peano`{.hs}.

```{.haskell .example}
increment :: Peano -> Peano
increment p = Succ p
```

**Goal:** Function `decrement`{.hs} that returns the predecessor of the input
`Peano`{.hs} number. The predecessor of `Zero`{.hs} is still `Zero`{.hs} (we
have no way to represent negatives).

```{.haskell .example}
decrement :: Peano -> Peano
decrement (Succ p) = p
decrement Zero     = Zero
```

### `add` function for Peano numbers

Let's try something a little more fun.

**Goal:** Function `add`{.hs} that returns the sum of two `Peano`{.hs}s.

### Question

a.  What should the type signature be?

```haskell
add :: Peano -> Peano -> Peano
```

b.  What cases do we have for this function?

First pass:

```haskell
add Zero Zero = undefined
add Zero (Succ p) = undefined
add (Succ p) Zero = undefined
add (Succ p1) (Succ p2) = undefined
```

How might we implement the bodies of these?

```haskell
add Zero Zero = Zero
add Zero (Succ p) = Succ p
add (Succ p) Zero = Succ p
add (Succ p1) (Succ p2) = Succ (Succ (add p1 p2))
```

We can simplify that form into:

```haskell
add Zero p = p
add p Zero = p
add (Succ p1) (Succ p2) = Succ (Succ (add p1 p2))
```
