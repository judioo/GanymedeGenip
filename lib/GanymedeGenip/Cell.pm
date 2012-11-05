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

sub display {
  my $self    = shift;

  return '' if($self->value =~/^0$/);

  return ($self->value =~ /^[-+]{0,1}\d+(?:[\.]\d+){0,1}$/)
    ? (int($self->value)  == $self->value)
      ? sprintf("%.1f",$self->value)
      : $self->value
    : $self->value;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
