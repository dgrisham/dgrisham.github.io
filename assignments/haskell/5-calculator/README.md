Final Project, Part 1 -- Haskell Calculator
===========================================

**This assignment is due Friday, December 1 by 11:59:59. You may work with a
partner on this project**

In this assignment, you will be filling in the missing pieces of a calculator
implementation written in Haskell. Example run (input lines are prefixed with
`> `, output lines just show a numeric result):

```
> 1 + 1
2.0
> -1 / 9
-0.11111111
> x := 3
> x * 2.1
6.2999997
> y := 4; z := 5
> (x + y * z) / 2
11.5
> 2 * pi - x
3.2831855
```

You'll be starting with [this skeleton project](./calculator-0.1.0.0.tar.gz).

The steps to get started are the same as in the previous project.

```
$ tar -xvf calculator-0.1.0.0.tar.gz
$ cd calculator-0.1.0.0
$ stack setup
```

Then you can use `stack build` to build the program.

*Note: You'll get a couple of warnings when you first build the program. These
should go away once you've implemented the relevant code.*

Architecture
------------

The program uses a REPL to imitate the behavior of a calculator. A REPL is a
**R**ead, **E**valuate, **P**rint **L**oop -- this is what most interpretors
(`ghci`, `irb`, `python`, etc.) do, and the steps generally are:

1.  **R**ead the user's input and parse it into some internal representation
    (like an expression or a statement).
2.  **E**valuate the parsed result, possibly based on some persistent
    environment (e.g. a map containing variable assignments that the user
    specifies, e.g. `x = 3`).
3.  **P**rint the result of the evaluation.
4.  **L**oop back to step 1 until the program is terminated.

In this part of the assignment, you will be implementing the Evaluate step of
the REPL for this calculator. The Read, Print, and Loop steps are already done
for you.

The following diagram illustrates the flow of data through the calculator for a
single command:

```
             <user command>
                   |
                   |
                   v
            +--------------+
            |    parser    |
            +--------------+
                   |
                   |
                   v
          Successfully parsed?
           |                |
           No              Yes
           |                |
           v                |
      (Print error)         |
                            |
                            v
              +---Expression or Statement?---+
              |                              |
              v                              v
          Expression                     Statement
              |          Empty Env           |
              |       (initialization)       |
              v              |               v
        +-----------+        v          +----------+  
   +--->| evaluator |<-------+--------->| executor |<---+
   |    +-----------+                   +----------+    |
   |          |                              |          |
   |          |                              |          |
   |          v                              v          |
   |        value                           env'        |
   |          |                              |          |
   |          v                              |          |
   |    (Print value)                        |          |
   |                                         |          |
   |                                         v          |
   +<----------------------------------------+--------->+
                       
```

Notice the `Env` in the diagram, which represents the environment. The
environment stores all variable bindings that the user specifies (more on this
below). When the program first starts, the environment will be empty (shown by
`Empty Env` in the diagram), then the user can update the environment by passing
in statements (as indicated by the output of the executor `env'`, which denotes
an updated environment). The evaluator, on the other hand, simply reads the
environment (along with the user's input expression) to produce a single value
that is then printed to the screen.

### Parser

The `parser` implements the Read step of the REPL, while the `evaluator` and
`executor` implement the Execute step. The evaluator is ran whenever the user
inputs an *expression*, while the executor is run whenever the user inputs a
*statement*.

The parser has already been written for you. You'll be extending this on the
next part of the assignment, but for now you can leave it alone. The parser is
in `src/Parser.hs`.

The parser accepts a basic set of forms for inputting expressions that should be
somewhat familiar to you. For example, the following input is acceptable as an
expression:

```
1 * (2 + 3) - 10 / -3.5
```

This parser has its limitations though -- for example, you can only negate
literal numbers. E.g. `-1 * 8` is valid, but `-pi` and `-(1 + 9)` are not. You
would have to modify the latter expressions to `-1 * pi` and `-1 * (1 + 9)` for
them to parse correctly.

Regarding variables names in statements, the parser only accepts strings of
lowercase letters as valid. So the following inputs are valid:

```
x := 3
counter := 0
```

But these are not:

```
x1 := 1
snowCrash := 2
```

### Expressions

An *expression* is some arbitrarily complex combination of inputs and operations
that evaluates down to a single *value*.

Example expression input by the user: `1 + 2`, which evaluates to the value `3`.

In the code, the evaluator is a function called `eval`, which has the type
signature:

```haskell
eval :: Expr -> Env -> Val
```

So the evaluator accepts an input expression, the current environment, and
returns the final value that the expression evaluates to. See the next section
for more on the environment.

### Statements

A *statement* alters the environment in some way. This is indicated by the type
signature of `exec`, which is the executor for statements in our calculator:

```haskell
exec :: Stmt -> Env -> Env
```

`exec` accepts a statement and an environment, and updates the environment based
on the statement. The environment holds variable declarations -- specifically,
it is a mapping from variable names to corresponding values.

Example statement input by the user: `x := 3`, which updates the environment
with a map from the variable name `"x"` to the value that represents `3`.

Types
-----

The types are defined in `src/Common.hs`.

### Val

`Val` is used to represent a value. The data declaration is:

```haskell
data Val = NumVal Float
         | ExnVal String
```

A `Val` is the result of evaluating an `Expr` in the current `Env`. You can
think of this calculator as a very simple programming language where expressions
can only evaluate into floating point numbers (we could also have strings,
integers, lists, ... but we won't).

The successful evaluation of an expression produces a `NumVal Float`, where the
`Float` is the calculated value. An unsuccessful expression evaluation results
in an `ExnVal String` (`ExnVal` is short for *exception value*), where the
`String` is an error message indicating the source of the error.

### Expr

`Expr` is used to represent an expression. The data declaration is:

```haskell
data Expr = NumExpr      Float
          | ConstExpr    String
          | VarExpr      String
          | AddExpr      Expr Expr
          | SubtractExpr Expr Expr
          | MultiplyExpr Expr Expr
          | DivideExpr   Expr Expr
```

#### NumExpr Float

A `NumExpr` represents an `Expr` that contains a single number.

Example: User input `3` parses to `NumExpr 3.0` and evaluates to `NumVal 3.0`.

#### ConstExpr String

`ConstExpr` is for common mathematical constants, like pi or e. The constructor
just contains the name of the constant -- the `eval` function will convert it to
an actual number.

Example: User input `pi` parses to `ConstExpr "pi"` and evaluates to
`NumVal 3.1415927`.

The list of supported constant names and corresponding values is stored in the
`consts` map in `src/Common.hs`. You should use this map to look up constants
when implementing `eval` for `ConstExpr`.

#### VarExpr String

A `VarExpr` holds the name of a variable that the user wishes to access. Of
course, the user must have declared the value of the variable in a statement
prior to calling it in an expression.

Example: User input `x` parses to `VarExpr "x"` and evaluates to
`NumVal <xVal>`, where `<xVal>` is the value `x` was previously set to by the
user in a statement (see the description of the `Stmt` type below).

#### AddExpr Expr Expr

`AddExpr` is one of four operator expressions, which take two sub-expressions
and combine them in some way. When evaluated, `AddExpr` adds the values that
each of its `Expr` arguments evaluate to.

Example: User input `x + 2` parses to `AddExpr (VarExpr "x") (NumExpr 2.0)` and,
assuming the value of `x` was previousy set to `3`, evaluates to `NumVal 5.0`.

#### SubtractExpr Expr Expr

The second of the four operator expressions. When evaluated, `SubtractExpr`
subtracts the result of evaluating the second `Expr` from the result of
evaluating the first `Expr`.

Example: User input `1 - y` parses to
`SubtractExpr (NumExpr 1.0) (VarExpr "y")`.

#### MultiplyExpr Expr Expr

The second of the four operator expressions. When evaluated, `MultiplyExpr`
multiplies the values that each of its `Expr` arguments evaluate to.

Example: User input `-1 * 8` parses to
`MultiplyExpr (NumExpr (-1.0)) (NumExpr 8.0)` and evaluates to `NumVal (-8.0)`.

#### DivideExpr Expr Expr

The second of the four operator expressions. When evaluated, `DivideExpr`
divides the value that the first `Expr` evaluates to by the value that the
second `Expr` evaluates to.

Example: User input `8 / pi` parses to
`DivideExpr (NumExpr 8.0) (ConstExpr "pi")` and evaluates to `NumVal 2.546479`.

### Stmt

`Stmt` is used to represent a statement. The data declaration is:

```haskell
data Stmt = SetStmt  String Expr
          | SeqStmt  [Stmt]
```

#### SetStmt String Expr

A `SetStmt` represents a variable declaration. The `String` field represents the
name of the variable and the `Expr` is the expression that wil be evaluated into
a `Val` -- this `Val` is then stored as the value associated with that variable
name.

Example: User input `x := 3` is parsed to `SetStmt "x" (NumExpr 3.0)`.

#### SeqStmt [Stmt]

A `SeqStmt` is a sequence of statements. This allows the user to pass in a
semicolon-separated list of statements (represented by the `[Stmt]` field) that
are executed in sequence.

Example: User input `x := 1; z := 2` is parsed to
`SeqStmt [SetStmt "x" (NumExpr 1.0),SetStmt "z" (NumExpr 2.0)]`.

Running the Program
-------------------

There are a few ways you can run the program for testing purposes. Note that
whenever you run the executable, you'll know that it's ready when you see the
following line:

```
> 
```

Before you've implemented anything, you can play with the parser a bit to get a
better idea of how a parsed expression looks. You can do this by running the
program with the `-p` option:

```
stack exec calculator-exe -- -p
```

*Don't forget the `--` whenever you're passing an option in!*

Try inputting the following lines to see what the result of the parser gives
you:

```
> 1 * 9
```

```
> x := 3
```

Once you've started to implement the `eval` and `exec` functions, you can get
more detailed output for testing by running the program in debug mode with `-d`:

```
stack exec calculator-exe -- -d
```

This will print the same parser result for each input as `-p` gives, but will
also show you the result of running the input. When you input an expression,
it'll show the value that it evaluates to; when you input a statement, it'll
show the updated environment after executing the statement.

Note that you can test partially-implemented `eval` and `exec` functions, as
long as your input matches the cases you've already implemented. For example, if
you've implemented `eval` for `AddExpr` but not `SubtractExpr`, you'll be able
to test inputs like `1 + 2` but not `1 - 2`.

Finally, you can run the calculator in normal mode simply by running the program
with no arguments:

```
stack exec calculator-exe
```

This is meant to be the actual program that a user would interact with -- it
prints the result of evaluating an expression, but does not print anything when
executing a statement.

Specific Requirements
---------------------

You'll primarily be editing the code in `src/Lib.hs`, which is where the
evaluator and executor functions are. You'll also add a bit of code to
`src/Common.hs`. The command-line interface (CLI) to the functionality you'll
write is in `app/Main.hs` -- you should take a look at this code to get a sense
of what's happening, even though it uses syntax we haven't discussed. There are
functions in `src/Lib.hs` that help bridge between the code you'll write, the
parser, and the CLI -- these functions are `run`, `runInput`, and `runLine`. The
first two have been implemented for you, and you'll implement `runLine` as
described below.

You must fully define all of the currently `undefined` functions in
`src/Lib.hs`. Each function is listed below, along with a description of how
it should work.

### runLine

```haskell
runLine :: Line -> Env -> (Env, Maybe Val)
```

The `runLine` function accepts a `Line`, which contains either a `Stmt` or an
`Expr`:

```haskell
data Line = Stmt Stmt | Expr Expr
```

*This constructor looks weird, but remember that in a data constructor the first
word is the name of the constructor, which is followed by a list of the types of
the arguments. So, in this case, the constructors have the same name as their
argument types.*

The second argument of `runLine`, which has type `Env`, is the input
environment. The return tuple contains the environment after the line is ran.
When determining how to write this function, remember the following:

-   Executing a statement returns an updated environment and no value.
-   Evaluating an expression returns a value and does not change the
    environment.

### eval

```haskell
eval :: Expr -> Env -> Val
```

Implements the previously discussed expression evaluator.

### exec

```haskell
exec :: Stmt -> Env -> Env
```

Implements the previously discussed statement executor.

When calling `exec` with a `SeqStmt` as the first argument, e.g. if the user
inputs:

```
x := 3; x := 1
```

the environment should be updated from left-to-right -- therefore, after the
above line is executed, the value of `x` should be `1`, not `3`.

### liftNumOp

```haskell
liftNumOp :: (Float -> Float -> Float) -> Val -> Val -> Val
```

This function is meant to be used when you define the `eval` function for the
operator expressions (`AddExpr`, `SubtractExpr`, `MultiplyExpr`, and
`DivideExpr`). The first input is a function over `Float`s -- you should use
Haskell's built-in `(+)`, `(-)`, `(*)`, and `(/)` functions here. The next two
inputs are two `Val`s that you want to combine together to produce the output
`Val` (using whichever mathematical operator was input as the first argument).

So why's it called `liftNumOp`? 'Lifting' is a common design pattern in
functional programming. In this case, one way to look at the purpose of
`liftNumOp` is that it's transforming a function over `Float`s into a function
over `Val`s:

```haskell
liftNumOp :: (Float -> Float -> Float) -> (Val -> Val -> Val)
```

If first input argument is `(+)`, we might say that `liftNumOp` is *lifting* the
`(+)` operator from working on `Float`s to working on `Val`s.

More concretely, the `liftNumOp` function is simply handling the
wrapping/unwrapping of its input/output `Val` arguments for us. If you didn't
use this function to implement `eval` for the operator expressions, you would
have to put values in/out of the `NumVal` constructor manually many more times.
`liftNumOp` is simply handling that boilerplate pattern code for us.

Error Handling
--------------

As mentioned above, errors in expression evaluation are expressed with `ExnVal`.
For your code to pass all of the tests, you'll have to match the exact error
messages that I have.

### Undefined constant or variable

When the `eval` tries to evaluate a `ConstExpr <c>` where `<c>` is not in the
`consts` map, `eval` should return an `ExnVal` of the form:

```haskell
ExnVal "Constant <c> is not defined."
```

For example, the expression

```haskell
eval (ConstExpr "G") env
```

should evaluate to

```haskell
ExnVal "Constant G is not defined."
```

A similar rule applies to `VarExpr <v>`, where `<v>` is not in the environment.
The result should be of the form:

```haskell
ExnVal "Variable name <v> is not defined."
```

### Division by zero

When `eval` is called on a `DivideExpr` where the denominator evaluates to
`NumVal 0.0`, `eval` should return:

```haskell
ExnVal "Division by zero."
```

### liftNumOp

`liftNumOp` should fail when either or both of its arguments are `ExnVal`. The
returned value should be:

```haskell
ExnVal "Cannot lift."
```

### Show Val

As mentioned above, running the program without any arguments will print the
result of any expressions that the user inputs. You'll notice that the output
looks something like `NumVal <number>`, e.g.

```
> 1 + 1
NumVal 2.0
```

We wouldn't want users to see the output in this format, so we should modify the
`Show` instance for `Val`s.

Go to `src/Common.hs`. Notice that the data declaration for `Val` has `Show` in
its list of derived typeclass instances. Remove the `Show` from this list and
implement a custom `Show` instance that prints out values in a more readable
manner.

Your result should change the previous example output to be:

```
> 1 + 1
2.0
```

As far as printing `ExnVal`s, you should just prepend `"Error: "` to the string
that the `ExnVal` contains:

```
> 1 / 0
Error: Divison by zero.c
```

See Chapter 8 of the textbook for examples of how to do this.

### Testing

You're not required to write additional tests for this assignment. The provided
tests should give sufficient coverage to ensure that you've met all of the
requirements for functionality.

Logistics
---------

### Scoring

**This assignment is worth 175 points.**

*150 points* are allocated to passing all of the required tests, and *25 points*
are allocated to code quality/readability/comments.

Do your best to capitalize on the features of Haskell and functional programming
in general -- e.g. use pattern matching, `case` expressions, higher-level
functions (one of the fold functions is particularly useful at one point in this
assignment), etc. As a point of potential interest: I used quite a few `case`
expressions in my code, and I did not use a single `guard` expression. If you're
using `guard` expressions frequently, there's probably a better way.

*Please post on Piazza or come talk to me if you want to improve your Haskell
code in these kinds of ways but are just uncomfortable/uncertain how to. It
will make your code more bearable to deal with in the long run.*

### Submission

As before, run `stack sdist` and submit the resulting
`calculator-0.1.0.0.tar.gz` file to Canvas. Remember to put your partner's name
in the submission comments if you have one.

Other Details
-------------

### Imports and Interface

You may add additional imports to `src/Lib.hs` -- however, note that I left all
of the imports I used for my implementation.

Do *not* change the interfaces of the provided files or functions -- i.e., do
not change the list of functions/types exported from any of the files, or the
type signatures of any of the functions that have been provided.

### Precedence for Operator Expressions

The parser handles all precedence ordering for you when it comes to expressions.
For example, the input

```
1 + 2 * 3
```

parses to

```haskell
AddExpr (NumExpr 1.0) (MultiplyExpr (NumExpr 2.0) (NumExpr 3.0))
```

And the input

```
2 * 3 + 1
```

parses to

```haskell
AddExpr (MultiplyExpr (NumExpr 2.0) (NumExpr 3.0)) (NumExpr 1.0)
```

Note the nesting of the expressions in both cases -- the multiplication happens
first, and the addition happens second. This makes the `eval` function more
straightforward to write for these expressions.

### HashMap

The `Env` is implemented using a hash map from the [`unordered-containers`
package](https://hackage.haskell.org/package/unordered-containers-0.2.8.0/docs/Data-HashMap-Strict.html).
See the documentation for information on how to use it. Note that I left the
imports I used from that package at the top of `src/Lib.hs` -- you shouldn't
need anything other than the functions that I imported, but you can change the
imports if you want.

Extra Credit
------------

You may add any additional features to the program for extra credit points.
Ideas for this:

-   Make the expression evaluation lazy, rather than strict. For example, when
    the user inputs `x := 2 * 3`, you would update the environment with `x`
    pointing to the expression `MultiplyExpr (NumExpr 2.0) (NumExpr 3.0)`,
    rather than the value `NumVal 6.0`. You would only evaluate expressions when
    you actually needed them, e.g. when you have to print the result to the
    console for the user. Feel free to ask questions about this if you're
    interested.
-   Add more data types, like `Bool` (rather than just `Float`). This would
    require updating the data types, expression parser (see [`Megaparsec`'s
    expression parser
    docs](https://hackage.haskell.org/package/megaparsec-5.3.1/docs/Text-Megaparsec-Expr.html)),
    and of course the evaluator.
-   Making the command input more robust, e.g. by using
    [`haskeline`](https://hackage.haskell.org/package/haskeline). This can give
    nice features like command history scrolling (with the up arrow), screen
    clearing (with ctrl-L), and fix a lot of the annoyances of our current input
    setup (e.g. notice that the user can't use the arrow keys to move around and
    edit their input -- pretty annoying).

If you have any other ideas for potential extra credit, please discuss your idea
with me before you implement it.
