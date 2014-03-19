#!/usr/bin/env perl
# while (<>) is same as -n option
# -e option means execute in command line
# so your end product will prob be:
# perl -ne [STUFF] ./VelvetOutput/lane whatever/contig.fa

use strict;
use warnings;

#get MetaGene output line
#find header in .fasta file
#read whole sequence
#get substring
#rep until MetaGene output line is for a different contig

open (FASTA, "<$ARGV[0]") or die "$!";
open (ORFFILE, "<$ARGV[1]") or die "$!";
open (NUCLEOTIDEFILE, ">$ARGV[2]") or die "$!";
my $foundcontig = 0;
my $sequence = "";
my $outputseq = "";
my $header = "";
my $len=0;
my $nextline = <ORFFILE>;
$nextline = <ORFFILE>;
chomp $nextline;
#split orffile to get headers and things
my @orfheader = split(/\t/,$nextline);
while (<FASTA>) {
	if ($_ =~ /^>/) {
		if ($foundcontig) {
			while ($orfheader[1] eq $header) {
			#write fasta, each line should have fewer than 80 characters
				my $startindex = $orfheader[2]-1;
				$len = $orfheader[3]-$orfheader[2]+1;
				$outputseq = substr($sequence,$startindex,$len);
				print NUCLEOTIDEFILE ">$orfheader[0]\n";
				while (my $chunk = substr($outputseq, 0, 80, "")) {
					print NUCLEOTIDEFILE "$chunk\n";
				}
				$nextline = <ORFFILE>;
				if (eof(ORFFILE)) {
					last;
				}
				chomp $nextline;
				@orfheader = split(/\t/,$nextline);
			}
		}
		s/>//;
		chomp($header = $_);
		$sequence = "";
		if ($orfheader[1] eq $header) {
			$foundcontig=1;
		}
		else {
			$foundcontig=0;
		}
	}
	elsif ($foundcontig) {
		chomp $_;
		$sequence .= $_;
	}
}
if ($foundcontig) {
	while ($orfheader[1] eq $header) {
		if (eof(ORFFILE)) {
			last;
		}
		#write fasta, each line should have fewer than 80 characters
		print NUCLEOTIDEFILE ">$orfheader[0]\n";
		$outputseq = substr($sequence,$orfheader[2]-1,$orfheader[3]-$orfheader[2]+1);
		while (my $chunk = substr($outputseq, 0, $len, "")) {
			print NUCLEOTIDEFILE "$chunk\n";
		}
		$nextline = <ORFFILE>;
		chomp $nextline;
		@orfheader = split(/\t/,$nextline);

	}
}
close (FASTA);
close (ORFFILE);














# open (FASTA, "<$ARGV[0]") or die "$!";
# open (OUTPUTFILE, ">$ARGV[1]") or die "$!";

# # boolean for whehter or not contig was found
# my $foundcontig = 0;
# my @id;
# while (<FASTA>) {
	# chomp;
	# #print "$_\n";
	# #if fasta id (starts with >)
	# if ($_ =~ /^>/) {
		# # print "$_\n";
		# #split, length is index 2
		# @id = split(/\t/,$_);
		# $foundcontig = 0;
		# #COVERAGE IS $id[5]
		# if ($id[3] > 500 and $id[5] > 2) {
			# $foundcontig = 1;
			# print OUTPUTFILE "$_\n";
			# # print "$_\n";
		# }
	# }
	# # else if part of contig that we want
	# elsif ($foundcontig) {
		# print OUTPUTFILE "$_\n";
	# }
# }

# close (OUTPUTFILE);
# close (FASTA);
