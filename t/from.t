#!/usr/bin/perl6

use v6;

# "casts" a generator to lazy array

use Test;
use Coro::Simple;

plan 3;

my &iter = coro -> $xs {
    for @$xs -> $x {
        say "Yay! You get $x."; # just a action to check the "eval by need"...
        yield $x;
    }
}

my $next = iter [ 3 ... -2 ];

my @array := (from $next).map: * + 1; # bind the lazy array returned

ok say @array[ 0 ];
ok say @array[ 1 ];
ok say @array[ 2 ];

# end of test