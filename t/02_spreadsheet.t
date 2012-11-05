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

  is($spreadsheet->rows,
    GanymedeGenip::Spreadsheet::DEFAULT_ROWS_SIZE(), "default rows");
  is($spreadsheet->columns,
    GanymedeGenip::Spreadsheet::DEFAULT_ROWS_SIZE(), "default columns");

  # New with attributes
  $spreadsheet  = $CLASS->new(rows => 20, columns => 28);
  is($spreadsheet->rows, 20, "rows 20");
  is($spreadsheet->columns, 28, "columns 28");

  # illegal 0 values for rows and column
  eval {$spreadsheet    = $CLASS->new(rows => 0, columns => 1)};
  like($@,qr/invalid/i,"invalid rows value of 0");

  eval {$spreadsheet    = $CLASS->new(rows => 1, columns => 0)};
  like($@,qr/invalid/i,"invalid cols value of 0");

  eval {$spreadsheet    = $CLASS->new(rows => -1, columns => 1)};
  like($@,qr/invalid/i,"invalid rows value of -1");

  eval {$spreadsheet    = $CLASS->new(rows => 1, columns => -1)};
  like($@,qr/invalid/i,"invalid cols value of -1");
}

# populate
# populate cells in spreadsheet
{
  my $spreadsheet = $CLASS->new; # default 10 10 grid

  # as getCellValue is a product of our 'populate' test we need to test it 1st
  # this is one of those TDD breakers...
  cmp_ok($spreadsheet->getCellValue('A1'), '==', 0, "cell empty");

  $spreadsheet->populate( cell => 'A1', value => 20);
  # as the real test we want to prove is this
  cmp_ok($spreadsheet->getCellValue('A1'), 'eq', '20', "cell populated");

  # clear cell
  $spreadsheet->populate( cell => 'A1', value => "");
  is($spreadsheet->getCellValue('A1'), 0, "cell cleared");
}

done_testing();
