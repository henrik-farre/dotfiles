#!/usr/bin/perl
# http://www.ueber.net/who/mjl/projects/bomstrip/

my $buf;
if (read STDIN, $buf, 3) {
	print $buf if $buf ne "\xef\xbb\xbf";
	undef $/;
	print <STDIN>;
}
