#!/usr/bin/perl

use strict;
use warnings;
use Test::Most;
use FindBin qw/$Bin/;

use lib "$Bin/lib";
use lib "$Bin/../lib";

use_ok("GanymedeGenip::Cell");

our $CLASS  = 'GanymedeGenip::Cell';

# Create
{
  my $cell  = $CLASS->new;
  isa_ok($cell,$CLASS);
}

done_testing();
