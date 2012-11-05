#!/usr/bin/perl

use strict;
use warnings;
use Test::Most;
use FindBin qw/$Bin/;

use lib "$Bin/lib";
use lib "$Bin/../lib";

our $CLASS ='GanymedeGenip::Spreadsheet';
use_ok($CLASS);

# New
# Every instance of the spreadsheet must have the number
# of rows and columns predefined.
{
  my $spreadsheet = $CLASS->new;
  isa_ok($spreadsheet,$CLASS);
}

