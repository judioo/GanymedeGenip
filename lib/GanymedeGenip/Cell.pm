package GanymedeGenip::Cell;

use Moose;
  has value => (is => 'rw', isa => 'Str', default => sub{0});
  
  around 'value' => sub {
    my $orig    = shift;
    my $self    = shift;
    
    return $self->$orig unless defined $_[0];
    # replace empty string with 0
    # equivalent of sayin cell->value(0)
    return $self->$orig(0) if($_[0] eq '');
    $self->$orig(@_);
  };


no Moose;
__PACKAGE__->meta->make_immutable;

1;
