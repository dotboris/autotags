Autotags
========

[![Build Status](https://travis-ci.org/beraboris/autotags.svg?branch=master)](https://travis-ci.org/beraboris/autotags)

A little tool that watches a given directory and generates
[ctags](http://ctags.sourceforge.net/) whenever you save your code.

Why?
----

Many editors and tools make use of ctags to provide a better coding experience.
This is great. The only issue is that every time you add a class, function,
variable, method, etc. you need to run ctags again so that your editor knows
about your new code. Autotags solves that issue by keeping an eye on your files
and then running ctags for you when anything changes.

Install
-------

__TODO__

Usage
-----

Start generating ctags with:

    $ autotags watch

This will watch the current directory and generate ctags whenever you save your
files.

Optionally, you can specify a folder to watch:

    $ autotags watch path/to/directory

Once you're done, stop generating ctags with:

    $ autotags stop

This will stop watching the current directory.

Optionally, you can specify a folder to stop watching:

    $ autotags stop path/to/directory

You can get more help with:

    $ autotags help

Contributing
------------

__TODO__
