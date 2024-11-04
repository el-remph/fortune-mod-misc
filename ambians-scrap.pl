#!/usr/bin/perl
# scrapes fortunes from https://motd.ambians.com, with apologies to same
use strict;
use warnings;

$\ = $, = "\n%\n"; # a single concluding empty entry seems to be allowed/required
undef $/;
our $REGMARK;

# Tried to write optimised, intuitive perl. Got funny faces:
print map	s/&(amp(*:&)|lt(*:<)|gt(*:>)|quot(*:")|apos(*:'));/$REGMARK/gr,
		m[<pre>(.*?)\n?+</pre>]gs
	while <>;
