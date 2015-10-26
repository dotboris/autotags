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

### Debian & Ubuntu family

__TODO__

### Fedora & Redhat family

__TODO__

### Arch Linux

Autotags is available in AUR (https://aur.archlinux.org/packages/autotags/). You
can install it using your favorite AUR helper.

    $ aurhelper -S autotags

### Other Linux distributions

1. Install `ctags`
1. Install `inotify-tools`
1. Download [`autotags`](https://github.com/beraboris/autotags/releases/download/v0.2.0/autotags)
  somewhere in your `$PATH`

### Mac or Windows

You're out of luck. Autotags depends on inotify which is a Linux specific
protocol.

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

### A note on source control

Autotags creates files in the directory it's watching. If you're running
autotags in a directory that is managed by source control you're going to want
to ignore those files.

You can do this by adding the following lines in your source control's ignore
file:

    .tags
    .autotags.pid

Contributing
------------

If you have a question, found a bug or would like to discuss anything, open a
[pull request](https://github.com/beraboris/autotags/compare).

If you'd like to contribute code:

1. [Fork](https://github.com/beraboris/autotags#fork-destination-box) this
  repository
1. Clone your fork
1. Make, commit & push your changes
1. Open a [pull request](https://github.com/beraboris/autotags/compare)

Check out [CONTRIBUTING.md](CONTRIBUTING.md) for more details on how to
contribute.
