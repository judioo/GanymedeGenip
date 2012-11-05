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
  has '_grid'   => ( is => 'rw', isa => 'HashRef[Str]', default => sub{{}});

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

  my($col,$row) = $loc =~/^([a-zA-Z]+)(\d+)$/;

  # validate
  unless((exists $self->validRows->{$row}) && (exists $self->validColumns->{uc($col)})) {
    die "$col$row invalid cell";
  }

  return (exists $self->_grid->{$row}{$col})
    ? $self->_grid->{$row}{$col}
    : 0;

}

sub populate {
  my $self    = shift;
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
