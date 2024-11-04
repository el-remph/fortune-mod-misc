#!/bin/sed -Ef
# Scrapes fortunes from https://quotes.cat-v.org markdown
# This is not, strictly speaking, how you parse markdown. Works anyway

# Open sliding window
N

# title (only works if the title is on a single line)
/^.*\n(=|-){3,}$/ {
	# eat all empty lines after title
	:ite_me
	z
	N
	/[^[:space:]]/!bite_me
	# delete superfluous leading newline; recycle as if nothing happened
	D
}

# pedantically strip out trailing horizontal whitespace. Mysteriously, this
# fixed a bug that I'm certain was unrelated, where a <hr> was left in.
s/[[:blank:]]+($|\n)/\1/g

# separator
/^\n[- ]{70,}$/ {
	N
	s/\n[- ]{70,}\n?/%/
	b
}

$a\
%

# else slide window forward, start new cycle
P
D
