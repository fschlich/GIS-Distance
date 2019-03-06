#!/usr/bin/end perl
use 5.008001;
use strictures 2;
use Test2::V0;

use GIS::Distance;

my $gis = GIS::Distance->new();
my @coords = ( -84.302183, 58.886719, -81.24166, -154.951172 );

$gis->formula( 'GIS::Distance::Formula::Vincenty' );
my $v_length = $gis->distance( @coords );

$gis->formula( 'GIS::Distance::Formula::Polar' );
my $p_length = $gis->distance( @coords );

todo 'Polar formula is broken' => sub{
    is_close( $v_length->km(), $p_length->km(), 'Vincenty versus Polar' );
};

sub is_close {
    my ($num1, $num2, $description) = @_;
    my $lossy = $num2 * 0.01;
    if (($num1 > $num2 + $lossy) or ($num1 < $num2 - $lossy)) {
        fail( "$description - $num1 != $num2" );
    }
    else {
        pass( "$description - $num1 =~ $num2" );
    }
}

done_testing;
