#!/usr/bin/perl
use strict;
use warnings;
use open qw/:std :locale/;
use HTML::Entities;

$\ = $, = "\n%\n"; # a single concluding empty entry seems to be allowed/required
undef $/;
our $REGMARK;

while (<>) {
	s{^.*<article>\s*<h1>programming quotes</h1>\s*|</article>.*$} {}gis; # strip header/footer
	print map {
		s/<.*?>//gs; # crudely strip out HTML, *before entity decoding*
		s/(&nbsp;){8}/\t/g;
		HTML::Entities::decode_entities($_);
	} split /\n*<hr ?\/?>\n*/;
}
