CSCI400 -- 11/30 Handout
========================

Recap
-----

In the
[lecture](http://www.scs.stanford.edu/16wi-cs240h/slides/parsing-slides.html),
we constructed our own *parsers* and *parser combinators*, where 'parser
combinators' basically means 'functions that can be used to combine parsers'. In
the lecture, our combinators were `andThen` and `stuff`, which we then related
to the functions in the `Monad` typeclass: `(>>=)` ('bind') and `return`.

```haskell
-- same purpose as >>=
andThen :: Parser s a -> (a -> Parser s b) -> Parser s b
andThen parse next = \input ->
  case parse input of
    Nothing          -> Nothing
    Just (a, input') -> next a input'

-- same purpose as return
stuff :: a -> Parser s a
stuff a = \input -> Just (a, input)
```

These functions, `andThen` and `stuff`, allowed us to take a parser that looked
like this:

```haskell
versionDumb :: Parser String (Int, Int)
versionDumb = \input ->
  case string "HTTP/" input of
    Nothing -> Nothing
    Just (_,rest1) ->
      case number rest1 of
        Nothing -> Nothing
        Just (maj,rest2) ->
          case string "." rest2 of
            Nothing -> Nothing
            Just (n,rest3) ->
              case number rest3 of
                Nothing -> Nothing
                Just (min,rest4) -> Just ((maj,min),rest4)
```

and instead write it like this:

```haskell
version2 :: Parser String (Int, Int)
version2 =
  string "HTTP/" `andThen` \_ ->
  number         `andThen` \maj ->
  string "."     `andThen` \_ ->
  number         `andThen` \min ->
  stuff (maj,min)
```

While this is certainly better than `versionDumb`, it's still not that pretty to look at.

`do` Notation
-------------

Let's assume that we'd implemented the `Monad` typeclass for our `Parser` type.
As a reminder, the `Monad` typeclass looks like this:

```haskell
class Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  return :: a -> m a
```

This means that we'd have to implement the `(>>=)` and `return` functions for
our `Parser` type. We can leverage the functions we've already written here:

```haskell
instance Monad (Parser s) where
  (>>=)  = andThen
  return = stuff
```

The `andThen` and `stuff` functions behaved *exactly* as we'd want `(>>=)` and
`return` to, so we just use those functions in defining the `Monad` typeclass
instance for our parser type.

In doing this, we'd be able to rewrite our `version2` parser to use these
functions by replacing `andThen` with `>>=` and `stuff` with `return`:

```haskell
version3 :: Parser String (Int, Int)
version3 =
  string "HTTP/" >>= \_ ->
  number  		 >>= \maj ->
  string "."     >>= \_ ->
  number         >>= \min ->
  return (maj,min)
```

This is just as ugly though -- all we've done so far is rename a couple of functions.

Now we come to something that you may have seen around, but we haven't talked
about yet: `do` notation. `do` notation is simply *syntactic sugar for
expressions that are built using the* `Monad` *functions* `(>>=)` *and*
`return`*.* We can use `do` notation to rewrite `version3` as:

```haskell
version4 :: Parser String (Int, Int)
version4 = do
  string "HTTP/"
  maj <- number
  string "."
  min <- number
  return (maj, min)
```

Note that, as far as the compiler is concerned, `version4` is *exactly the same*
as `version3`. The compiler would simply de-sugar `version4` to `version3`,
because `do` notation is just syntactic sugar.

You can use `do` notation for any function that returns a type that is a part of
the `Monad` typeclass, which our parser type is now. This provides a means of
using the `Monad` design pattern without the ugly syntax.

## Applicative Parsing

`do` notation gives us one way to clean up our parser definitions. The thing
about `do`, though, is that it's 1. fairly straightforward to use, but 2. it's
difficult to really understand what it's doing.

So let's approach this from a different angle. Let's write our parsers using a
few other typeclasses, namely `Functor`, which gives us the `(<$>)` ('fmap')
operator, and `Applicative`, which gives us the `(<*>)` ('apply') operator and a
few others (namely, `(*>)` and `(<*)`). We'll also see the `Alternative`
typeclass, which gives us `(<|>)` -- you'll get an idea of how this operator
works from the chapter reading. We'll call this style 'applicative Parsec'.

Applicative Parsec will allow us to take parsers that look like this:

```haskell
majorVersion :: Parser String Int
majorVersion = do
  string "HTTP/"
  maj <- number
  return maj
```

And rewrite them like this:

```haskell
majorVersion :: Parser String Int
majorVersion = string "HTTP/" *> number
```

As another example, consider a `Person` data type:

```haskell
data Person = Person Name Age
type Name   = String
type Age    = Int
```

Given parsers for a `Name` and `Age`, called `p_name` and `p_age`, resp.:

```haskell
-- definitions not given, just type signatures
p_name :: Parser Name
p_age  :: Parser Age
```

*Note: The type we've been using for parsing has been `Parser s a`, where `s` is
the type of the input to be parsed (`String` for us) and `a` is the result of
the parsing, AKA the type of the value that the parser holds for us. When we
write parsers for the assignment, the `s` will be removed and we'll just have
`Parser a` as the generic parser type -- this just means that the fact that
we're always parsing a `String` is implicit in the `Parser` type itself, so we
don't include the additional `s` type variable.*

We can write a parser for a `Person` by combining these two parsers. Using `do`
notation, this would look like:

```haskell
p_person :: Parser Person
p_person = do
  name <- p_name
  age  <- p_age
  return $ Person name age
```

Translating this to use the applicative Parsec style would give us:

```haskell
p_person :: Parser Person
p_person = Person <$> p_name <*> p_age
```

You might think one of these is cleaner than the other, but the latter form is
the one we'll be using on the second half of the project.

From here, you should read [the `Parsec` chapter of Real World
Haskell](http://book.realworldhaskell.org/read/using-parsec.html). `Parsec` is a
parsing library in Haskell. The one we'll actually be using is
[`megaparsec`](https://hackage.haskell.org/package/megaparsec-6.2.0), but
they're similar enough that the book chapter should give you a solid start.
*Note that the chapter starts off by using* `do` *notation to define parsers,
then moves to the notation that we want to use, which is 'applicative Parsec'*.
However, it explains applicative Parsec using `do` notation, so it's helpful to
understand both.


