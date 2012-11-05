package GanymedeGenip::Spreadsheet;

use Moose;

use constant DEFAULT_ROWS_SIZE  => 10;
use constant DEFAULT_COLS_SIZE  => 10;

  has 'rows'    => (is => 'ro', isa => 'Int', default => DEFAULT_ROWS_SIZE());
  has 'columns' => (is => 'ro', isa => 'Int', default => DEFAULT_COLS_SIZE()); 

no Moose;
__PACKAGE__->meta->make_immutable;
1;
