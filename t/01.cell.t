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

  # create empty cell
  $cell     = $CLASS->new;
  cmp_ok($cell->value, 'eq', '0',"cell is empty (has value of 0)");

  # populate
  $cell->value(20);
  is($cell->value, 20,"cell populated");

  # emptying
  $cell->value("");
  cmp_ok($cell->value, 'eq', '0',"populated cell emptied (has value of 0)");
  
  # re-populate
  $cell->value(30);
  cmp_ok($cell->value, 'eq', '30',"re-populated cell");
}

done_testing();
