#!/usr/bin/env perl
# while (<>) is same as -n option
# -e option means execute in command line
# so your end product will prob be:
# perl -ne [STUFF] ./VelvetOutput/lane whatever/contig.fa

use strict;
use warnings;


open (FASTA, "<$ARGV[0]") or die "$!";
open (OUTPUTFILE, ">$ARGV[1]") or die "$!";
# boolean for whehter or not contig was found
my $foundcontig = 0;
my @id;
while (<FASTA>) {
	chomp;
	if ($_ =~ /^>/) {
		s/>//;
		print OUTPUTFILE "$_\n";
	}
}

close (OUTPUTFILE);
close (FASTA);
