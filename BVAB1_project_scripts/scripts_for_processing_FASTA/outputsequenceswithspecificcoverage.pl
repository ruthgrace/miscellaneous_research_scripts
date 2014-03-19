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
	#print "$_\n";
	#if fasta id (starts with >)
	if ($_ =~ /^>/) {
		# print "$_\n";
		#split, length is index 2
		@id = split(/_/,$_);
		$foundcontig = 0;
		#COVERAGE IS $id[5]
		substr($id[5], -3) = "";
		if ($id[5] >= 5 and $id[5] <= 12 and $id[3] > 1000) {
			$foundcontig = 1;
			print OUTPUTFILE "$_\n";
			# print "$_\n";
		}
	}
	# else if part of contig that we want
	elsif ($foundcontig) {
		print OUTPUTFILE "$_\n";
	}
}

close (OUTPUTFILE);
close (FASTA);
