package GanymedeGenip::Spreadsheet;

use Moose;

use constant DEFAULT_ROWS_SIZE  => 10;
use constant DEFAULT_COLS_SIZE  => 10;

  has 'rows'    => (is => 'ro', isa => 'Int', default => DEFAULT_ROWS_SIZE());
  has 'columns' => (is => 'ro', isa => 'Int', default => DEFAULT_COLS_SIZE()); 

  has 'validColumns'  
                => ( is => 'rw', isa => 'HashRef[Str]', default => sub{{}});
  has 'validRows'  
                => ( is => 'rw', isa => 'HashRef[Str]', default => sub{{}});

sub BUILD {
  my $self  = shift;
  
  for my $method (qw/rows columns/) {
    die "Invalid $method not greater than 0"
      unless($self->$method > 0);
  }

  # build grid validation indexes
  $self->_create_indexes;
}

sub getCellValue {
  my $self    = shift;
  my $loc     = shift;

}


sub _create_indexes {
  my $self    = shift;

  my $char    = 'A';
  $self->validColumns ( {map{ $char++ => 1 } (1..$self->columns)} );
  $self->validRows    ( {map{ $_ => 1 } (1..$self->rows)} );
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
