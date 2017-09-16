Ruby
====

*Similar concepts, different syntax...*

-   Exceptions are *raised* using the `raise` method of the `Kernel` class
-   The `rescue` clause is used the handle exceptions
-   Exceptions are instances of the `Exception` class (or subclasses thereof)
    -   Subclasses *do not* add methods or behavior. They *do* allow exceptions
        to be categorized.
-   Most exceptions extend `StandardError`
    -   Other exceptions are low-level, typically not handled by programs

Exception Methods
-----------------

Methods that can be used to get information about an particular exception:

-   `message`
    -   Returns a `String` 
    -   More suitable for programmers than end users
-   `backtrace`
    -   Returns the call stack as an array of `String`s
    -   Lines of the form: `<filename>:<line_number>:in <method_name>

Raising an Exception
--------------------

`fail` is a synonym of `raise` -- it's meant to be used if you expected the
program to end as a result of the exception.

There are several ways to invoke `raise`:

-   No arguments
    -   If inside `rescue`, re-raises same exception
    -   Otherwise, raises `RuntimeError`
-   With single `Exception` object argument
    -   Uncommon
-   With single `String` argument
    -   Creates `RuntimeError` with the string arg as the message
    -   *Very* common
-   With `Exception` object, `String` (for `message()`), and an array of strings
    (for `backtrace`)

Example + Exercise
------------------

```{.ruby}
def factorial(n)
    raise "Bad argument" if n < 1
    # raise ArgumentError if n < 1
    # raise ArgumentError, "Exception argument >= 1, got #{n}" if n < 1

    return 1 if n == 1
    n * factorial(n-1)
end
```

You can also provide a custom stack trace:

```{.ruby}
def factorial4(n)
    if n < 1
        raise ArgumentError, "Exception argument >= 1, got #{n}", caller
    end

    return 1 if n == 1
    n * factorial(n-1)
end
```

The above code blocks correspond to the code in `exceptions-1.rb` in the
provided source files. Uncomment the various factorial methods to see different
functionality.

Catching an Exception
---------------------

`rescue` is a language keyword (not a `Kernel` method). You can attach a
`rescue` clause to any statement in Ruby -- typically, it's attached to `begin`:

```{.ruby}
begin
    # statements, possible exceptions
rescue
    # code to handle exceptions
end
# if no exception, code continues here -- code in rescue is not executed
```

Handling Exceptions
-------------------

`rescue` handles any `StandardError`. The global variable `$!` refers to the
current raised exception, though it is better to specify a variable for the
exception in the `rescue` statement:

```{.ruby}
begin
    x = factorial(0)
    rescue => err
    puts "#{err.class}: #{err.message}"
end
```

Handling Multiple Types of Exceptions
-------------------------------------

```{.ruby}
def factorial5(n)
    raise TypeError, "Need integer" if not n.is_a? Integer
    raise ArgumentError, "Need argument >= 1, got #{n}" if n < 1

    return 1 if n == 1
    n * factorial(n-1)
end

begin
    x = factorial5("a")
rescue ArgumentError => ex
    puts "Try again with argument > 1"
rescue TypeError => ex
    puts "Try again with an integer"
end
```

**Question**: Does the order of the `rescue` statements matter?

**Exercise**: In `exceptions-1.rb`, uncomment and run the various `begin`/`end`
blocks that handle exceptions.

Propagating Exceptions
----------------------

The following code gives a relatively complex system of exception handling --
**as a quick exercise, try tracing this code through each of the paths it could
take**.

```{.ruby}
def explode
    raise "bam!" if rand(10) == 0
end

def risky
    begin
        10.times do
            # raises error ~10% of time
            explode
        end
    rescue TypeError # won't catch RuntimeError
        puts $!
    end # RuntimeError not handled, will propagate
    "hello" # if no exception
end

def defuse
    begin
        puts risky
    rescue RuntimeError => e # handle propagated error
        puts e.message
    end
end

defuse
```

**Exercise**: After you try to trace the code, try running `exceptions-2.rb` and
check your understanding.

Other Options
-------------

-   `retry`
    -   When used inside a `rescue`, `retry` reruns the block of code that
        raised the exception.
    -   Useful for transient failures, e.g. overloaded server
    -   Number of retries should be limited
-   `ensure`
    -   Same idea as Java's `finally`

Note on `throw`/`catch`
-----------------------

Ruby has the keywords `throw`/`catch`, but they're not used for handling
exceptions. If you're curious, check out [this blog
post](http://rubylearning.com/blog/2011/07/12/throw-catch-raise-rescue--im-so-confused/),
which is written by this guy:

![Avdi Grimm](img/avdi_grimm.jpg)

Tell me he doesn't look like a guy you can trust, I dare you.
