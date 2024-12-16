#!/usr/bin/perl
# SPDX-FileCopyrightText: 2024 The Remph
# SPDX-License-Identifier: FSFULLRWD
# See COPYING
#
# scrapes fortunes from https://motd.ambians.com, with apologies to same
use autodie;
use strict;
use warnings;

$\ = $, = "\n%\n"; # a single concluding empty entry seems to be allowed/required
undef $/;
our $REGMARK;

# Tried to write optimised, intuitive perl. Got funny faces:
# In order: confused.com; sad Beaker; happy Beaker; two lots of happy tears
print map	s/&(amp(*:&)|lt(*:<)|gt(*:>)|quot(*:")|apos(*:'));/$REGMARK/gr,
		m[<pre>(.*?)\n?+</pre>]gs
	while <>;
