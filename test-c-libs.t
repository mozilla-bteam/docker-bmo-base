#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use autodie;

open my $libs, '<', $ENV{TEST_C_LIBS_FILE};
while (my $line = <$libs>) {
    chomp $line;
    my ($file) = split(/\s+/, $line);
    ok(-f $file, "$file exists");
}
close $libs;

done_testing;
