package Thingiverse::Tag;
use strict;
use warnings;
use Moose;
use Moose::Util::TypeConstraints;
use Data::Dumper;
use Carp;
use Thingiverse;
use Thingiverse::Types;

# ABSTRACT: Thingiverse Tag Object

=head1 SYNOPSIS

  ...

=head1 SEE ALSO

=for :list
* L<Thingiverse>
* L<Thingiverse::User>
* L<Thingiverse::User::List>
* L<Thingiverse::Cache>
* L<Thingiverse::Thing>
* L<Thingiverse::Thing::List>
* L<Thingiverse::Tag::List>
* L<Thingiverse::Category>
* L<Thingiverse::Collection>
* L<Thingiverse::Collection::List>
* L<Thingiverse::Comment>
* L<Thingiverse::File>
* L<Thingiverse::File::List>
* L<Thingiverse::Image>
* L<Thingiverse::SizedImage>
* L<Thingiverse::Copy>
* L<Thingiverse::Pagination>
* L<Thingiverse::Cache>
* L<Thingiverse::Group>
=cut

has name => (
  isa        => 'Str',
  is         => 'ro',
  required   => 1,
);

has thingiverse => (
  isa        => 'Thingiverse',
  is         => 'ro',
  required   => 1,
  default    => sub { return Thingiverse->new() },
  handles    => [ qw(rest_client) ],
);

has count => (
  isa        => 'ThingiCount',
  is         => 'ro',
  lazy_build => 1,
);

has [qw/url things_url original_json/] => (
  isa        => 'Str',
  is         => 'ro',
  lazy_build => 1,
);

has things => (
  isa        => 'Thingiverse::Thing::List',
  is         => 'ro',
  required   => 0,
  builder    => '_get_things_tagged_with_tag',
  lazy       => 1
);

has content => (
  isa        => 'HashRef',
  is         => 'ro',
  lazy_build => 1,
);

# Attribute builders, called by users via Moose, referencing content

sub _build_count { 
  my $self = shift;
  return $self->content->{count};
}

sub _build_url {
  my $self = shift;
  return $self->content->{url};
}

sub _build_things_url {
  my $self = shift;
  return $self->content->{things_url};
}

# Content generator, called by attribute builders, referencing orginal_json

sub _build_content {
  my $self = shift;
  return JSON::decode_json($self->original_json);
}

# original_json retrieval from REST API, called by content generator, referencing rest_client

sub _build_original_json {
  my $self        = shift;
  my $request     = $self->api_base() . $self->name();
  return $self->rest_client->GET($request)->responseContent;
}

sub _get_things_tagged_with_tag {
  my $self = shift;
  return Thingiverse::Thing::List->new(
    { api => 'search', term => $self->name });
}

sub api_base {
  return '/tags/';
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
__END__
special methods

list
