Homework: Ruby Email Log Exercise
=================================

Purpose
-------

Use regular expressions to solve a realistic problem.

Preparation
-----------

-   Download the [log file](./mail.log)

This exercise may be done with a partner.

Email Log Analyzer
------------------

Your friend Bob has come to you in a panic. He's in charge of a software
engineering project that includes sending emails, but there was a glitch in the
system. He needs to know what messages were sent over a 2-day period of time.
The only info he has is a system log (available under
[Preparation](#preparation)). He doesn't really understand the format of the
log, but he's hoping you can give him a report that includes for each message:

-   The message id
-   The date/time
-   The message size
-   The 'from' address
-   The 'to' address(es). He knows that some messages were sent to multiple
    recipients.

He also wants to know the total number of messages.

You, of course, know that this is a job for Ruby and some regular expressions.
You also, following good software engineering processes, know that you should
write unit tests that ensure you are extracting all fields correctly, and also
test that you are recognizing the correct number of messages (you need to figure
out how many there are... no fair asking on Piazza).

Rubric
------

This exercise is worth 50 points.

 Points  | Metric
:------: | :-----
   4     | Correct number of messages extracted. (Show the total so it's easy to grade.)
   4     | Correctly handle messages with multiple 'to' addresses
  20     | Listing of messages includes id, date/time, size, from, and to.
  12     | Unit tests for extracting fields and checking for correct number of messages.
  10     | Reasonable code structure with plenty of comments. We should be able to look at your code and quickly see how it's structured. Putting everything in one long method will *not* earn all style points. Decision of the grader is final... to protect yourself, submit clean code with comments!

Submit
------

For ease of grading, please:

-   Name the test file `email_log_tester.rb`
-   Name your main file `email_log_main.rb`
-   Ensure the grader can execute your tests by running
    `ruby email_log_tester.rb` (this should not display the messages) and can
    see the list of messages by running `ruby email_log_main.rb`.

Zip all files, including the `mail.log` file, and submit on Canvas. If you
worked with a partner, submit just one copy and include your partner's name in
the comments.
