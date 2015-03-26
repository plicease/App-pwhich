# pwhich

Perl-only \`which'

# SYNOPSIS

    $ pwhich perl
    $ pwhich -a perl          # print all matches
    $ pwhich perl perldoc ... # look for multiple programs
    $ pwhich -a perl perldoc ...

# DESCRIPTION

\`pwhich' is a command-line utility program for finding paths to other
programs based on the user's `PATH`. It is similar to the usually Unix
tool \`which', and tries to emulate its functionality, but is written
purely in Perl (uses the module `File::Which`), so is portable.

## Calling syntax

    $ pwhich [-a] [-v] programname [programname ...]

## Options

- -a

    The option _-a_ will make `pwhich` print all matches found in the
    `PATH` variable instead of just the first one. Each match is printed
    on a separate line.

- -v

    Prints version (of `File::Which`) and copyright notice and exits.

# SUPPORT

Bugs should be reported via the GitHub issue tracker
[https://github.com/plicease/App-pwhich/issues](https://github.com/plicease/App-pwhich/issues)
For other issues, contact the maintainer.

# SEE ALSO

- [File::Which](https://metacpan.org/pod/File::Which)

    Perl API for [pwhich](https://metacpan.org/pod/pwhich)

- [App::pwhich](https://metacpan.org/pod/App::pwhich)

    Guts of this script.

- [Devel::CheckBin](https://metacpan.org/pod/Devel::CheckBin)

    This module purports to "check that a command is available", but does not

    provide any documentation on how you might use it.

# AUTHOR

Original author: Per Einar Ellefsen <pereinar@cpan.org>

Current maintainer: Graham Ollis <plicease@cpan.org>

Contributors:

Adam Kennedy <adamk@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2002 by Per Einar Ellefsen <pereinar@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
