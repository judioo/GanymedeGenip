package GanymedeGenip::Spreadsheet;

use Moose;
use GanymedeGenip::Cell;

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
  my $cell    = $self->_getCell($loc);

  return ($cell) ? $cell->value : 0;
}

sub populate {
  my $self        = shift;
  my %args        = @_;
  my($col, $row)  = $self->_getRowColFromCellName($args{cell});

  if(exists $self->_grid->{$row} && exists $self->_grid->{$row}{$col}) {
    # cell already exist
    $self->_grid->{$row}{$col}->value($args{value});
  }
  else {
    $self->_grid->{$row}{$col} = GanymedeGenip::Cell->new(value => $args{value});
  }

}

sub displayCell {
  my $self    = shift;
  my $loc     = shift;
  my $cell    = $self->_getCell($loc);

  return ($cell) ? $cell->display : "";
}

sub _getCell {
  my $self    = shift;
  my $cell    = shift;

  my($col, $row)  = $self->_getRowColFromCellName($cell);

  return (exists $self->_grid->{$row}{$col})
    ? $self->_grid->{$row}{$col}
    : undef;
}

sub _getRowColFromCellName {
  my $self    = shift;
  my $cell    = shift;

  my($col,$row) = $cell =~/^([a-zA-Z]+)(\d+)$/;

  # validate
  if((exists $self->validRows->{$row}) && (exists $self->validColumns->{uc($col)})) {
    return(uc($col), $row);
  }
  die "$col$row invalid cell";
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
