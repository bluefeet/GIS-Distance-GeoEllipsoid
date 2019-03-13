package GIS::Distance::GeoEllipsoid;
use 5.008001;
use strictures 2;
our $VERSION = '0.11';

use Geo::Ellipsoid;
use namespace::clean;

my $cache = {};

my $ellipsoid_args = {
    units          => 'degrees' ,
    distance_units => 'kilometer',
    longitude      => 0,
    bearing        => 0,
};

sub distance {
    my $ellipsoid = (@_ == 5) ? shift() : undef;

    $ellipsoid ||= 'WGS84';

    my $instance = $cache->{$ellipsoid} ||= Geo::Ellipsoid->new(
        %$ellipsoid_args,
        ellipsoid => $ellipsoid,
    );

    return $instance->range( @_ );
}

1;
__END__

=encoding utf8

=head1 NAME

GIS::Distance::GeoEllipsoid - Geo::Ellipsoid distance calculations.

=head1 SYNOPSIS

    # Use the default WGS84 ellipsoid:
    my $gis = GIS::Distance->new( 'GeoEllipsoid' );
    
    # Set to a custom ellipsoid:
    my $gis = GIS::Distance->new( 'GeoEllipsoid', 'NAD27' );

=head1 DESCRIPTION

This module is a wrapper around L<Geo::Ellipsoid> for L<GIS::Distance>.

Normally this module is not used directly.  Instead L<GIS::Distance>
is used which in turn interfaces with the various formula modules.

=head1 ARGUMENTS

An optional argument may be passed which, if set, must be an ellipsoid
name as defined at L<Geo::Ellipsoid/DEFINED ELLIPSOIDS>.  See the
L</SYNOPSIS> for an example of setting this argument.

Otherwise the default ellipsoid, C<WGS84>, will be used.

=head1 SUPPORT

Please submit bugs and feature requests to the
GIS-Distance-GeoEllipsoid GitHub issue tracker:

L<https://github.com/bluefeet/GIS-Distance-GeoEllipsoid/issues>

=head1 AUTHORS

    Aran Clary Deltac <bluefeet@cpan.org>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

