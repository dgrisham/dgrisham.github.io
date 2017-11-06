Lambdas
=======

Lambdas are essentially *nameless functions*. They can be confusing to look at
initially, but are quite useful once you get the hang of them.

Recall Ruby's blocks:

```ruby
(1..10).each { |x|
    puts x + 1
}
```

You can think of the block `{ |x| puts x + 1 }`{.hs} as an anonymous function of
sorts -- or, perhaps slightly more accurately, as an anonymous `Proc`{.hs}. It's
a syntactic structure that accepts some number of inputs and operates on those
inputs, but doesn't have a name associated with it.

Lambda's are kind of similar to blocks, or at least as similar as anything in
Haskell can be to something in Ruby. Consider the following line:

```haskell
\x -> x + 1
```

This is a simple example of a lambda function -- the result of that line is a
function itself, but it doesn't have a name. We can get the type of that thing
in `ghci`:

```
> :t (\x -> x + 1)
(\x -> x + 1) :: Num a => a -> a
```

Even though the function doesn't have a name, the `arguments`{.hs} are named (in
this case, we just have one argument: `x`{.hs}. The `\`{.hs} says that we're
about to define a lambda function, then we provide a space-separated list of
arguments, then a `->`{.hs} followed by the function body.

We could use the lambda function by (you can run this in `ghci`):

```
> (\x -> x + 1) 5
6
```

So we create a function with a single argument, then we provide the argument
`5`{.hs} to that function.

If we wanted multiple arguments:

```haskell
(\x y -> x + y + 1)
```

And we could call it by:

```
> (\x y -> x + y + 1) 3 4
8
```

What's the point?
-----------------

The previous examples were fairly trivial/contrived. However, consider the
following function definition:

```haskell
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f xs ys = map f' $ zip xs ys
  where
    f' (x, y) = f x y
```

Notice that we had to use a `where`{.hs} clause to define the `f'`{.hs}
function. However, we're only using this function once, and it's relatively
simple, so why give it a name?

Let's redefine `zipWith'`{.hs} to use an anonymous function:

```haskell
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f xs ys = map (\(x, y) -> f x y) $ zip xs ys
```

Note that we can do pattern matching on the arguments of the lambda function,
just like we can with any other function. In this case, we're pattern matching
on the tuple constructor.

Function Composition
====================

Here's a weird function:

```haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
(f . g) x = f (g x)
```

The easiest way to think about this function is that it takes in two functions
as arguments, and returns a new function which is the composition of the input
functions. Following that reasoning, it's informative to rewrite the type
signature as:

```haskell
(.) :: (b -> c) -> (a -> b) -> (a -> c)
```

```haskell
minList :: Ord a => [a] -> a
minList xs = head $ sort xs
```

Think of `head $ sort x`{.hs} as "apply the function `head`{.hs} to the result
of applying the function `sort`{.hs} to the list `xs`{.hs}".

We could also write `minList`{.hs} as:

```haskell
minList :: Ord a => [a] -> a
minList xs = head . sort $ xs
```

Think of `head . sort $ x`{.hs} as "create a new function `head . sort`{.hs},
then apply that new function to the list `xs`{.hs}". `(.)`{.hs} has *higher
priority* than `($)`{.hs}, so you can think of the order of operations as
`(head . sort) $ xs`{.hs}. `head`{.hs} is the first argument to the `(.)`{.hs}
function, `sort`{.hs} is the second, and `xs`{.hs} is the argument we supply to
the resulting function `head . sort`{.hs}.

Or, equivalently, we could leave the `xs`{.hs} out altogether:

```haskell
minList :: Ord a => [a] -> a
minList = head . sort
```

This is similar to the previous case, but with a shorter explanation:
"`minList`{.hs} is the result of composing the `head`{.hs} and `sort`{.hs}
functions".

Note that **all 3 of the above definitions of `minList`{.hs} are equivalent**.
They're simply meant to help you think about how `(.)`{.hs} works.

A common design pattern in haskell is to combine multiple functions with
composition to create a new function:

```haskell
maxList :: Ord a => [a] -> a
maxList = head . reverse . sort
```

`(.)`{.hs} is right-associative, so `head . reverse . sort`{.hs} is equivalent
to `head . (reverse . sort)`{.hs} -- `reverse . sort`{.hs} will result in a
function with the type `Ord a => [a] -> [a]`{.hs}, then we compose `head`{.hs}
with that function.

This will sort a list from smallest to largest, reverse the list, then grab the
first element.

Typeclasses
===========

Overview
--------

Recall the two types of polymorphism in Haskell: *parametric polymorphism*, and
*ad-hoc polymorphism*. Ad-hoc polymorphism is provided by Haskell's typeclasses.

Essentially, typeclasses are a way of providing function/operator-overloading.
An example of a typeclass is `Eq`{.hs}:

```haskell
class Eq a where
  (==) :: a -> a -> Bool
```

Just as in the type signatures for polymorphic functions that we've seen, we
have a type variable here: `a`{.hs}. You can read this typeclass definition as:
"In order for an arbitrary type `a`{.hs} to satisfy the `Eq`{.hs} typeclass,
there must exist a function `(==)`{.hs} for type `a`{.hs} with the type
signature `(==) :: a -> a -> Bool`{.hs}."

So far, we've only shown how to define the typeclass itself. Now we can define
*instances* of that typeclass. For example, if we want `Bool`{.hs} to satisfy
the `Eq`{.hs} typeclass, we would write:

```haskell
instance Eq Bool where
  True  == True  = True
  False == False = True
  _    == _    = False
```

*As an aside, recall that `(==)`{.hs} is an infix function, which lets us define
it as we did above. So the following two lines are equivalent:*

```haskell
True == True = True
-- is the same as
(==) True True = True
```

Now that we've defined the typeclass instance `Eq Bool`{.hs}, we can use a
`Bool`{.hs} as an argument to any function that imposes the `Eq`{.hs} *class
constraint* on the relevant type variable:

```haskell
listElem :: Eq a => a -> [a] -> Bool
listElem x xs = x `elem` xs
```

Consider the following call to this function:

```haskell
result = listElem True [False, False, True]
```

Looking back at the type signature for `listElem`{.hs}, we see that the type
variable `a`{.hs} is `Bool`{.hs} in this specific function call (imagine
replacing all of the `a`{.hs}'s in the type signature of `listElem`{.hs} with
`Bool`{.hs}). That means the type constraint says that the typeclass instance
`Eq Bool`{.hs} *must* be defined (which we did previously).

Hierarchical Typeclasses
------------------------

We can also use existing typeclass instances to define new ones. For example,
given the `Eq`{.hs} typeclass above, we might want to say something like "If you
have a tuple of values whose types are instances of the `Eq`{.hs} typeclass,
then you can compare the tuples themselves as well." You can do this with:

```haskell
instance (Eq a, Eq b) => Eq (a, b) where
  (x1, y1) == (x2, y2) = x1 == x2 && y1 == y2
```

The `(Eq a, Eq b)`{.hs} part is another set of class constraints and says that
the types `a`{.hs} and `b`{.hs} must both be instances of `Eq`{.hs} in order for
this typeclass instance `Eq (a, b)`{.hs} to work. If you look at the second
line, `(x1, y1) == (x2, y2) = x1 == x2 && y1 == y2`{.hs}, you should see why
this is the case: basically, in order to define `(==)`{.hs} for the tuples, we
must be able to call the `(==)`{.hs} function on the elements of the tuples.

We can also add a class constraint to a typeclass *definition*:

```haskell
class Eq a => Ord a where
  (<), (<=), (>=), (>) :: a -> a -> Bool
  max, min             :: a -> a -> a
```

The `Eq a => Ord a`{.hs} part says "in order for some type `a`{.hs} to be an
instance of the `Ord`{.hs} type class, it must also be an instance of the
`Eq`{.hs} typeclass".

`Deriving`
----------

Consider the following data declaration:

```haskell
data Person = Person Name Age
type Name = String
type Age = Int
```

If we loaded this code into `ghci`, created a `Person`{.hs}, then tried to print
it:

```
> bob = Person "Bob" 27
> print bob

<interactive>:6:1: error:
    • No instance for (Show Person) arising from a use of ‘print’
    • In the expression: print person
      In an equation for ‘it’: it = print person
```

The issue here is that `Person`{.hs} needs to be an instance of the `Show`{.hs}
typeclass so that the `print`{.hs} knows how to convert a `Person`{.hs} to a
`String`{.hs}.

We could do this manually:

```haskell
instance Show Person where
  show (Person name age) = "Person " ++ show name ++ " " ++ show age
```

And now we won't get an error:

```
> print person
Person Bob 27
```

Both fields of `Person`{.hs} (`Name`{.hs} and `Age`{.hs}) are both already
instances of `Show`{.hs}. It would be nice if the compiler could infer that we
want to simply print out the name of the constructor and each of its values,
without having to full define the `Show Person`{.hs} instance ourselves.

In fact, we can do just that by adding to our data declaration:

```haskell
data Person = Person Name Age
  deriving Show

type Name = String
type Age = Int
```

The `deriving`{.hs} keyword tells the compiler to define a default instance of a
typeclass. In this case, we're using `deriving Show`{.hs} to tell the compiler
that we want it to automatically create a `Show Person`{.hs} instance for us.
The result will be exactly the same as the instance we defined ourselves
previously:

```
> person = Person "Bob" 27
> print person
Person Bob 27
```

We can derive a few other types as well, like `Eq`{.hs}:

```haskell
data Person = Person Name Age
  deriving (Eq, Show)
```

```
> youngBob = Person "Bob" 27
> oldBob = Person "Bob" 60
> youngBob == oldBob
False
> oldBob == oldBob
True
```

The automatically created `(==)`{.hs} for the `Person`{.hs} type simply compares
each of the fields, `Name`{.hs} and `Age`{.hs}.
