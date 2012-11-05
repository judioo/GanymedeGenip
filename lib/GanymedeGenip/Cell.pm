package GanymedeGenip::Cell;

use Moose;
  has value => (is => 'rw', isa => 'Str', default => sub{0});

no Moose;
__PACKAGE__->meta->make_immutable;

1;
