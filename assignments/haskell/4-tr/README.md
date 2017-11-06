Haskell: `tr` Implementation
============================

Overview
--------

In this assignment, you'll write a simple Haskell version of the Unix program
`tr`. Your version will support two modes: translate and delete.

```
tr <string1> <string2> # translate mode
tr -d <string1> # delete mode
```

From the OpenBSD man page:

> In the first synopsis form, the characters in `<string1>` are translated
> into the characters in `<string2>` where the first character in `<string1>`
> is translated into the first character in `<string2>` and so on. If
> `<string1>` is longer than `<string2>`, the last character found in
> `<string2>` is duplicated until `<string1>` is exhausted.
>
> In the second synopsis form, the characters in `<string1>` are deleted from
> the input.

When you run the `tr` command, it will just wait for string input via `STDIN`,
which is the string that it will translate based on the arguments you provided
to `tr`. Try running the command yourself to see how it works (if you're on a
Windows computer, you should do this via Git Bash).

Example interactions:

```
tr abc def
abc
def
def
def
azz
dzz
bzz
ezz
```

```
tr -d abc
ace
e
aaaabbbbyyyy
yyyy
```

Corner Cases
------------

**First**, if `<string1>` is longer than `<string2>`, you should repeat the
final character of `<string2>` until it's the same length as string `<string1>`.
That is, this:

```
tr abc x
```

should be treated as equivalent to:

```
tr abc xxx
```

**Second**, if `<string1>` is shorter than `<string2>`, you should truncate
`<string2>` to be the same length as `<string1>`. So this:

```
tr abc defg
```

should be treated as:

```
tr abc def
```

**Third**, we will *not* test the case where `<string1>` has repeated
characters. Example:

```
tr aa bc
```

This is considered undefined (by POSIX), so you don't need to worry
about it.

Interface
---------

You're provided with a module file called `Tr.hs`, which is where you'll
implement all of your code. **Do not change the interface of this file.** By
that, I mean that you shouldn't change the functions/types that this file
exports, nor should you change the type signatures of the functions it exports.

The `tr` function looks like:

```haskell
type CharSet = String

tr :: CharSet -> Maybe CharSet -> String String
```

The type `CharSet` is simply mean to give a more descriptive name to the
arguments of `tr`.

The first argument to the `tr` function is the set of characters to map from,
and the second argument is the set of characters to map to. The third argument
corresponds to `STDIN` (the string to be translated) and the return value
corresponds to `STDOUT` (the translated string).

The type of the second argument is `Maybe CharSet` to differentiate between
between translate and delete mode. In translate mode it will be
`Just <charset>`, and in delete mode it will be `Nothing`. E.g.:

```haskell
-- translate mode
tr "eo" (Just "oe") "hello" -- equals "holle"
-- delete mode
tr "e" Nothing "hello" -- equals "hllo"
```

You're also provided the signature to a function called `parseArgs`:

```haskell
parseArgs :: [String] -> Maybe (CharSet, Maybe CharSet)
```

This function is used to convert the input provided by the caller of the program
into the exact arguments expected by the `tr` function. The code includes more
detail on how to implement this function.

Stack
-----

You'll have to get [Stack](https://docs.haskellstack.org/en/stable/README/)
running to run this assignment. In order to get this running on the computers in
Alamode (BB 136), you should:

1.  Open your `~/.bash_profile` and add the following line to it:

        export PATH="$PATH:$HOME/.local/bin"

2.  Download [this script](../install-stack.sh) and run it with
    `sh install-stack.hs`. This is a slightly modified version of the Stack
    install script that should work on the computers in Alamode.

You're required to get your code to work on the Alamode computers -- you can
work on the Windows computers if you want, but I haven't tested any of this
in Git Bash.

Once you have stack installed, you should download and unzip [this
file](./tr-0.1.0.0.tar.gz) which is the skeleton code and also includes the
files to run this as a Stack project.

```
tar -xvf tr-0.1.0.0.tar.gz
cd tr-0.1.0.0
```

Once you're in the project directory, you have to set up the `stack` project
environment by running:

```
stack setup
```

This might take awhile if it has to install GHC for you, possibly around 10
mins. You should be able to run `stack build` successfully once `stack setup`
finishes.

Here are a few important `stack` commands that you'll want to use:

```
# build project
stack build
# execute project (the `--` is important when testing delete mode)
stack exec tr-exe -- "abc" "def"
stack exec tr-exe -- -d "def"
# run tests
stack test
```

Provided Files
--------------

The files provided to get you started are:

-   `tr.cabal`, `stack.yaml` -- used by `stack`, specify the build system
-   `src/Tr.hs` -- this is the only file you should modify (aside from adding
    tests). Contains the functions to implement your `tr` functionality. **You
    should add as many helper functions as you want** -- your functions should
    tend to be roughly around 1-6 lines, Haskell functions are usually very
    short.
-   `app/Main.hs` -- handles the command line interface to the pure
    functionality that you'll write in `src/Tr.hs`. You should not edit this
    file, but you should look at it to get a rough idea of how it works (though
    it involves concepts that we haven't discussed yet).
-   `test/Spec.hs` -- the test harness. You need to edit this and add your own
    tests! We provide a few simple tests to get you started.

**Do not change the interface of the `Tr.hs` module and do not add any extra
source files.**

Testing
-------

Some skeleton code for testing your `tr` implementation is provided in
`test/Spec.hs`. You'll need to edit this file and add your own tests to ensure
that your program is complete. The test code uses a Haskell package called
[hspec](http://hspec.github.io/) -- please refer to the documentation if you're
unsure how to use it based on the provided examples.

Grading
-------

**This assignment is worth 100 points.**

You will be graded on the completeness of your code, based on tests that we'll
run on your implementation. Note that we will use tests that are not provided to
you, which is why you need to add your own tests to check your code as
thoroughly as you can.

Submitting
----------

From your project directory, run the command:

```
stack sdist
```

This will generate file called `tr-0.1.0.0.tar.gz` that contains only the files
necessary for testing. The output of the above command tells you where the `tar`
file is located -- this is the file you should upload to Canvas for your
submission.
