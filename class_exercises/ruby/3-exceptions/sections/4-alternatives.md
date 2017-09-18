Exception Alternatives
----------------------

### Purpose

Explore some error handling ideas that are not as similar to Java/C++.

### Preparation

Read the following links:

1.  <https://davidnix.io/post/error-handling-in-go/>
2.  <http://www.golangpatterns.info/error-handling>
3.  <https://blog.golang.org/defer-panic-and-recover>
4.  <https://www.reddit.com/r/golang/comments/3sfjho/gos_error_handling_is_elegant/>

### Explore

With a partner or small group, discuss and write up brief answers to:

1.  Describe the `Error` type and how it's typically checked in Go (article 1).
2.  Why do you think the author in article 2 does not like the patterns shown
    under **Bad Usage of Errors**?
3.  Compare/contrast `defer`, `panic`, and `recover` in Go to exception handling
    in Java, including the `finally` clause (article 3).
4.  Skim article 4. Several posters mention error handling in languages like
    Haskell. We'll study this later. (Nothing to write down for this one.)
5.  Debate among yourselves (and write down a summary of your thoughts): Do you
    like the way Go handles errors? Why or why not?
