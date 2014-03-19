#!/usr/bin/env perl
# while (<>) is same as -n option
# -e option means execute in command line
# so your end product will prob be:
# perl -ne [STUFF] ./VelvetOutput/lane whatever/contig.fa

use strict;
use warnings;


open (FASTA, "<$ARGV[0]") or die "$!";
my $outdir = $ARGV[1];
my $fastastring = ".fasta";
my $openfile = 0;
while (<FASTA>) {
	chomp;
	#print "$_\n";
	#if fasta id (starts with >)
	if ($_ =~ /^>/) {
		if ($openfile) {
			close (OUTPUTFILE);
		}
		else {
			$openfile = 1;
		}
		(my $filename = $_) =~ s/>//;
		print ">$outdir$filename$fastastring\n";
		open (OUTPUTFILE, ">$outdir$filename$fastastring") or die "$!";
		print OUTPUTFILE "$_\n";
	}
	# else if part of contig that we want
	else {
		print OUTPUTFILE "$_\n";
	}
}

close (OUTPUTFILE);
close (FASTA);
