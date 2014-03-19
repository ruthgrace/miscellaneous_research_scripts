#!/usr/bin/env perl
# while (<>) is same as -n option
# -e option means execute in command line
# so your end product will prob be:
# perl -ne [STUFF] ./VelvetOutput/lane whatever/contig.fa

use strict;
use warnings;


open (LENGTHS, "<$ARGV[0]") or die "$!";
my @contigs = <LENGTHS>;
open (FASTA, "<$ARGV[1]") or die "$!";
open (OUTPUTFILE, ">$ARGV[2]") or die "$!";
# boolean for whehter or not contig was found
my $foundcontig = 0;
my @id;
chomp(@contigs);
while (<FASTA>) {
	chomp;
	#print "$_\n";
	#if fasta id (starts with >)
	if ($_ =~ /^>/) {
		# print "$_\n";
		#split, length is index 2
		@id = split(/_/,$_);
		$foundcontig = 0;
		LOOPY: {
			foreach (@contigs) {
				if ($_ eq $id[3]) {
					$foundcontig = 1;
					last LOOPY;
				}
			}
		}
		if ($foundcontig) {
			print OUTPUTFILE "$_\n";
			print "$_\n";
		}
	}
	# else if part of contig that we want
	elsif ($foundcontig) {
		print OUTPUTFILE "$_\n";
	}
}

close (OUTPUTFILE);
close (FASTA);
close (LENGTHS);

# in the fasta file you want from the line after >NODE_[ID]_length to just before the next >NODE
# >NODE_4_length_555_cov_15.643243
# open (MYFILE, '>>data.txt'); 
#  print MYFILE "Bob\n"; 
