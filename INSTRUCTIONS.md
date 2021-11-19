Coding test for backend Perl developers

The Synopsis
============

A client has asked you to create a very, very simple ticketing system. In
fact, it's the smallest possible Web-based ticketing system you can imagine.

The only hard requirements are using Perl with an SQLite database.  You will
have complete freedom to use the tools you're comfortable with. For the
front-end, do not use Javascript.

You have one week to finish the task, but experienced developers can finish the
task in less than a day. However, it likely needs a bit of extra time for making it
"production ready". You absolutely will NOT be penalized for taking the entire
week. We'd rather see what you can do to make the code "production ready" than
see you rush to get the code back to us as soon as possible.

Note that this is a chance to shine and show us your best work.

The Details
===========

The client needs:

* To see a list of tickets
* To filter that list of tickets by ticket status
* Create a new ticket
* Edit an existing ticket
* Reply to a ticket
* See that list of replies beneath the ticket
* Assign a developer to a ticket
* Change the status of a ticket

The client doesn't need:

* Authentication or authorization (all ticket authors/replies are thus
  anonymous)
* Paging
* Deleting
* Pretty
* Searching and/or filtering (except for the ticket status mentioned above)

If you add any of the "doesn't need", you won't be penalized, but be aware
that it's not required.

The system will be completely anonymous and run from inside a corporate
network, so the client does not want authentication or authorization (this is
silly, but we're keeping the test simple for you). Replies can be posted to a
ticket, but should not be editable after that.  The original ticket should be
editable, including changing who it's assigned to and the ticket status.

The client has specifically asked that Javascript not be used.

The list of developers:

* Alice
* Bob
* Charlie

The list of ticket statuses:

* New
* In progress
* QA
* Done
* Won't Fix

Unfortunately, the client will be gone for a week and she's instructed you to
use your best judgement if you have any questions about the data, how it should
be displayed, or other issues with the task.  In other words, it’s all up to
you.

Deliverables
============

The basic task will take most developers less than a day to complete. However,
you should strive to produce code which you feel is *production ready*. This
does not mean perfect—we readily accept that no code is perfect. We have
deadlines, unclear specifications (like this one), and other time constraints.
Instead, we expect that you submit to us code that, while not perfect, is
nonetheless an example of the quality you feel is appropriate for production
code.

What to send us
---------------

On or before one week of receiving this, you should return a tarball or zip file
containing:

* The code
* This document
* An SQLite database with some data already entered
* A README text document explaining how to build and run the project
* A NOTES text document explaining any decisions about the code which you feel are relevant

What we'll send you
-------------------

After receiving the project, we'll give the code a full code review.
Regardless of how you did, we'll send you the results of that review.

The NOTES file
--------------

We will be using the NOTES file to understand how you make business and
technical decisions and how you *communicate* those decisions. You should
explain what decisions you took and why you took them.

Between the README and the NOTES and the code, we should be able to build, run
and assess your project without further clarification from you. The final code
will should run on a standard Linux system (we're actually using OS X).

What tools do you use?
----------------------

Anything! We want the code to be in Perl and the database to be SQLite, but
other than that, you're completely free to use anything you wish.  Just keep in
mind that if you use something that is hard to install or compile, that might
make it harder for us to evaluate. If we can't install or compile it, that's a
strong black mark against you (though not necessarily a fail).

In short, we want you to use any tools you feel comfortable with.  We're
checking to see if you can code, not whether or not you can use a set of tools
we have already chosen for you.

Good luck !

