#!/usr/bin/perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'HTML::WikiConverter::Textile' ) || print "Bail out!\n";
}

diag( "Testing HTML::WikiConverter::Textile $HTML::WikiConverter::Textile::VERSION, Perl $], $^X" );
