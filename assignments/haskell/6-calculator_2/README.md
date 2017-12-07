Final Project, Part 2 -- Haskell Calculator
===========================================

**This assignment is due Thursday, December 14 by 11:59:59 pm. You may work with
a partner on this project.**

Overview
--------

In the second part of this project, you'll be adding a new feature to the
calculator -- functions. Example of how this will work:

```
> n := 1
> f(x, y) := x * y - n
> f(3, 2)
5.0
```

You will implement this feature almost entirely from scratch. You'll be provided
the relevant data constructors, then you will add to the evaluator, executor,
*and* the parser.

Types
-----

You'll have to update the `Stmt`, `Expr`, and `Val` types with additional data
constructors to support functions.

### Stmt

You should modify the `Stmt` data declaration with

1.  The data constructor `FuncStmt String [String] Expr`.
2.  Add `Eq` to the list of derived typeclasses so that your code will run with
    the tests.

After these modifications, your declaration should look like:

```haskell
data Stmt = SetStmt String Expr
          | SeqStmt [Stmt]
          | FuncStmt String [String] Expr
  deriving (Eq, Show)
```

The `FuncStmt` constructor is used to represent a function definition. The
semantics of the arguments are:

-   `String` -- The name of the function.
-   `[String]` -- A list of the names of the function's arguments.
-   `Expr` -- The body of the function, which is an expression.

For example, the function `f(x, y) := x + y` would have the following `Stmt`
representation:

```
FuncStmt "f" ["x","y"] (AddExpr (VarExpr "x") (VarExpr "y"))
```

### Expr

You should modify the `Expr` data declaration with

1.  The data constructor `AppExpr String [Expr]`.
2.  Add `Eq` to the list of derived typeclasses so that your code will run with
    the tests.

After these modifications, your declaration should look like:

```haskell
data Expr = NumExpr      Float
          | ConstExpr    String
          | VarExpr      String
          | AddExpr      Expr Expr
          | SubtractExpr Expr Expr
          | MultiplyExpr Expr Expr
          | DivideExpr   Expr Expr
          | AppExpr      String [Expr]
  deriving (Eq, Show)
```

The `AppExpr` constructor is used to represent a function application (i.e.
'calling' a function). The semantics of the arguments are:

-   `String` -- The name of the function being applied.
-   `[Expr]` -- The arguments for the function application.

For example, the function application `f(1, pi)` would have the following `Expr`
representation:

```
AppExpr "f" [NumExpr 1.0, ConstExpr "pi"]
```

### Val

You should modify the `Val` data declaration by adding the data constructor
`CloVal [String] Expr Env`.

After this modification, your declaration should look like:

```haskell
data Val = NumVal Float
         | CloVal [String] Expr Env
         | ExnVal String
  deriving Eq
```

`CloVal` is necessary to give us a way to store a function in the calculator's
environment (since the `Env` is a mapping from `String` to `Val`). The key in
the environment would be the function's name, and the value would be the
`CloVal`.

The `CloVal` constructor is used to represent a *closure*. A closure is a record
that stores the information that the evaluator needs when evaluating an
`AppExpr` -- the names of the function arguments, the function body, and the
environment at the time the function was created. The semantics of the arguments
are:

-   `[String]` -- A list of the names of the function's arguments.
-   `Expr` -- The body of the function, which is an expression.
-   `Env` -- The environment at the time the function was created.

For example, if there are no variables defined in the environment, the function
definition `f(x, y) := x + y` would have the following `Val` representation:

```
CloVal ["x","y"] (AddExpr (VarExpr "x") (VarExpr "y")) H.empty
```

where `H.empty` is an empty `Env`.

On the other hand, if the following input is ran:

```
> i := 2
> j := 3
> f(x, y) := x + y
> k := 4
```

Then, the environment stored with the `CloVal` would contain entries for `i` and
`j`, but not for `k` (since `k` was not in the environment at the time the
`CloVal` for `f` was created). This allows you to use variables that were
defined prior to the function within the function expression. For example, you
can run:

```
> n := 1
> f(x) := x + n
```

The environment stored in the `CloVal` would contain the mapping from `n` to
`NumVal 1.0` -- then, when evaluating the expression stored with the `CloVal`,
which is `AddExpr (VarExpr "x") (VarExpr "n")`, you can lookup the value of `n`
in the environment associated with the `CloVal` for the function `f`.

You should also modify your `Show Val` instance to handle `CloVal`:

```haskell
instance Show Val where
  show (NumVal x) = show x
  show (ExnVal e) = "Error: " ++ e
  show (CloVal params body env) = "<" ++ show params ++ ", "
                                      ++ show body   ++ ", "
                                      ++ show env    ++ ">"
```

Parser
------

**You must write your parsers in the Applicative form as laid out in the Real
World Haskell reading (Chapter 16). This means that you should not use any `do`
blocks and you should use operators like `<$>`, `<*>`, and `<|>`.**

*Note: In the discussion below, whenever we say that a parser 'returns' a value,
we're referring to the type of the value that the parser holds after it
successfully parses input. So we'd say that a parser of type* `Parser Line`
*returns a* `Line`*. This is simply a term we use for convenience which does not
necessarily have a greater meaning outside of this context.*

Let's go over parts of the parser that you have already.

The approach to writing parsers that we've discussed involves taking 1. simple
parsers, and 2. parser *combinators* (operators to combine parsers) to build
more complex parsers.

Consider the highest-level parser we have in this file, `p_line`:

```haskell
p_line :: Parser Line
p_line =  Stmt <$> try p_stmt
      <|> Expr <$> p_expr
```

First consider the type, `Parser Line` -- roughly, this means that `p_line`

1.  knows *how to parse* all of the information necessary to create a value of
    type `Line`, and
2.  also knows *how to create* a value of type `Line` from that parsed input.

On to the body of `p_line`, we see that this parser tries to run the `p_stmt`
parser on its input. `p_stmt` has the type `Parser Stmt`. If `p_stmt` succeeds,
then we transform the result into a `Line` by applying the `Stmt` data
constructor to the result (which is what `Stmt <$> p_stmt` does). Otherwise, if
`p_stmt` fails, then the parser tries to run `p_expr` on the input. If `p_expr`
succeeds, then we transform the result into a `Line` by applying the `Expr` data
constructor to the result.

Now let's consider another parser, but from the bottom-up rather than top-down.

```haskell
p_varExpr :: Parser Expr
p_varExpr = VarExpr <$> p_var

p_var :: Parser String
p_var = some $ oneOf ['a'..'z']
```

First consider the `p_var` parser. `p_var` has the type `Parser String`, which
means it parses input into a `String` value (and returns that `String`). It is
built out of two parsers from the [Megaparsec
library](https://hackage.haskell.org/package/megaparsec-6.2.0): `oneOf` ([link
to
documentation](https://hackage.haskell.org/package/megaparsec-6.2.0/docs/Text-Megaparsec-Char.html#v:oneOf))
and `some` ([link to
documentation](https://hackage.haskell.org/package/parser-combinators-0.2.0/docs/Control-Applicative-Combinators.html#v:some)).
`oneOf` accepts a list of characters as its argument and creates a parser that
succeeds when it can parse a single one of those characters from the input.
`some` takes a parser that parses anything and creates a parser that can parse a
sequence of the same thing (and puts the results in a list). So, in this case,
the `oneOf ['a'..'z']` parser succeeds when it can parse a single lowercase
character, and `some $ oneOf ['a'..'z']` succeeds when it can parse a sequence
of lowercase characters (i.e. a `String` made up of only lowercase characters).

`p_varExpr` then applies the `VarExpr` constructor to the `String` that `p_var`
parses.

This is the general approach to writing parsers using `megaparsec` -- you take
the primitive parsers/functions that `megaparsec` provides, then combine them in
various ways to build up parsers for your use-case.

You'll have to modify this parser to support the new `Stmt` and `Expr`
constructors that we've added, namely `FuncStmt` and `AppExpr`.

### FuncStmt

Write a parser called `p_funcStmt` that parses a `FuncStmt`. There will be 3
primary sub-parsers that will be necessary for you to write for this.

The **first** of these sub-parsers should parse and return a function name. For
our calculator, a valid function name starts with a lowercase letter then is
followed by zero or more characters that may be lowercase letters, uppercase
letters, numbers, or underscore.

Examples of valid function names: `f`, `test`, `funcTest_1`.

Examples of invalid function names: `_f`, `1test`, `FuncTest_1`.

The **second** of these parsers should parse a `(`, followed by a
comma-separated list of zero or more variable names (which represent the
function argument names) that may be surrounded by any number of spaces,
followed by a `)`. It should return a list containing the argument names as a
list of strings (`[String]`).

Between the second and third parsers, you'll have to parse a `:=`.

The **third** of these sub-parsers should parse and return an expression (the
body of the function). You should use `p_expr` for this.

Note that spaces will not automatically be handled by your parsers -- if you
want to parse a specific string, like `":="`, and ignore any surround spaces,
you can use the the `symbol` function (already defined in `src/Parser.hs`) which
creates a parser that parses the provided string as well as any spaces
before/after that string.

### AppExpr

Write a parser called `p_appExpr` that parses an `AppExpr`. We'll leave it to
you to figure out the details of this one.

### Integrating your parsers

Once you define `p_funcStmt` and `p_appExpr`, you'll have to integrate it into
the rest of the parser (though, before you do, you can check that they work by
themselves with `stack test`).

Note that, when integrating both of these, you may or may not need the `try`
function -- see the Real World Haskell reading for a refresher on what `try` is
for.

To integrate `p_funcStmt`, you'll have to add it as one of the options for the
`p_stmt'` parser (*not* the `p_stmt` parser -- this is the result of a design
decision I made to make the parser output a bit simpler for you on the previous
part of the project).

To integrate `p_appExpr`, you'll have to add it as one of the options for the
`atom` parser. `atom` represents the list of basic `Expr` types that can appear
on either side of an operator (like `+`). The expression parser itself is
constructed by a function that `megaparsec` provides called `makeExprParser`.
You shouldn't have to do anything other than update the `atom` parser, and
everything should work around that.

Executor
--------

You'll have to update `exec` to handle `FuncStmt` and update the environment
with the appropriate `CloVal`.

Evaluator
---------

You'll have to update `eval` to handle `AppExpr`. Along with evaluating
`AppExpr` based on user-defined functions as described above, you should also
support two built-in functions: `sin` and `cos`. Thus, the user should be able
to do the following:

```
> sin(pi)
-8.742278e-8
> cos(0)
1.0
```

When the user inputs one of these functions, you should use the `sin` and `cos`
functions in Haskell's `Prelude` to calculate the result. You should only have
to add code to the evaluator to support this functionality.

As a helper function for the `sin` and `cos` functionality, you must also
implement a function called `liftNumFunc`. This has a similar purpose to
`liftNumOp` from the previous part, and has the type signature:

```
liftNumFunc :: (Float -> Float) -> Val -> Val
```

If the `Val` input isn't a `NumVal`, this function should return
`ExnVal "Cannot lift."` just like `liftNumOp` did.

Even though there aren't tests for this function, it *is required* to write this
and the TA will be checking for it.

Error Handling
--------------

You do *not* have to handle the case where the user provides the wrong number of
arguments to a function. That is, the following case:

```
> f(x, y) := x + y
> f(1)
```

Will not be tested.

### Evaluating AppExpr

When the first argument of the input `AppExpr` refers to a value that isn't a
`CloVal`, `eval` should return an `ExnVal` with the string
`"Can only apply CloVals."`.

When the first argument of the input `AppExpr` isn't in the environment, `eval`
should return an `ExnVal` with a string of the form
`"Function name <name> is not defined."`, where `<name>` is the name that
couldn't be found.

You can assume function calls always have the correct number of arguments -- we
will not be testing any other case.

Tests
-----

You should use this [updated test file](./Spec.hs) to test this project. It
includes all the same tests from the previous part, along with additional tests.
You can use it to tests the parsers independently before integrating them into
the rest of the parser.

Your program should also successfully run with [this simple test
script](./test.sh). You can run this with `./test.sh` (if it doesn't run the
first time, you first have to modify the permissions with `chmod +x test.sh`).
There are only 2 tests, and they both run a sequence of commands into your
program and check that the output is as expected. You can think of these as
basic integration tests that ensure your program works as expected when multiple
components are tested together (as opposed to the tests in `test/Spec.hs`, which
are more like unit tests). Check out the file if you want to see what cases it's
testing, because it's not as verbose as `stack test`.

### Additional Updates

There are a couple of updates you'll have to make to your project to get it to
work with the new tests. Download [this cabal file](./calculator.cabal) and
replace yours with that. You also need to add the parsers that you're
implementing to the export list of the `Parser` module so that they can be
tested individually. To do this, open `src/Parser.hs` and change the top of the
file so that it looks likes this:

```haskell
module Parser
  ( runParser
  , p_line
  , p_funcStmt
  , p_appExpr
  )
```

If you do this, you'll have to define `p_funcStmt` and `p_appExpr` or you'll get
an error when trying to run the tests. You can temporarily define them as:

```haskell
p_funcStmt :: Parser Stmt
p_funcStmt = undefined

p_appExpr :: Parser Expr
p_appExpr = undefined
```

Logistics
---------

### Grading

**This assignment is worth 175 points.**

*150 points* are allocated to passing all of the required tests, and *25 points*
are allocated to code quality/readability/comments.

### Submission

Run `stack sdist` and submit the resulting file to Canvas. Remember to put your
partner's name in the submission comments if you have one.

Extra Credit
------------

As before, feel free to add additional features to the program for extra credit
points (but you should talk to me about it first). Ideas:

-   Support `let` expressions for temporary variable bindings, which would let
    you write expressions like: `let z := 1 in z` (much like Haskell's `let`
    expressions). This would also be useful for functions, e.g.
    `f(x) := let y := sin(x) in x * y`.
-   Ensure that functions are called with the correct number of arguments. So,
    defining `f(x, y) := x + y` then calling `f(0)` would output
    `Error: Function f expects 2 args, got 1.`.
-   Support default values for function arguments, e.g. `f(x := 0) := x + 1`
    (here, `f()` would evaluate to `1` and `f(1)` would evaluate to `2`).
-   Make the expression evaluation lazy, rather than strict. If you do this, you
    also have to decide whether you want to use *static* or *dynamic* lexical
    scoping -- the latter is more difficult to implement, but will get you more
    points.

Feel free to ask about any of these if you have questions, or let me know of any
ideas you come up with!
