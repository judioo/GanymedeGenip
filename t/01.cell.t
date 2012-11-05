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

# assign value to cell
# lets allow one to allocate a value to the cell
# on creation and also via calling cell->value(..)
{
  my $cell  = $CLASS->new(value =>10);
  is($cell->value,10,"cell value is 10");
}

done_testing();
