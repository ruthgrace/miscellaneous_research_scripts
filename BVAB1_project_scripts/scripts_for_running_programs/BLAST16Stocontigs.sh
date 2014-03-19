
INPUT="/Groups/assembly/BVAB1_PROJECT/BVAB116S/16SseqeuencesBVAB1.fasta"
OUTPUTFOLDER="/Groups/assembly/BVAB1_PROJECT/BLASToutput/16StoCombinedContigs/"
DB="/Groups/assembly/BVAB1_PROJECT/BLASTinput/contigslengthover300coverageover5/combined_trimmed_filtered_velvet_contigs"
SAMPLEEND="_velvet_contigs_filtered.fa"
OUTPUTEND="BLASTto16Soutput.tsv"
NOHUPEND="blast.nohup.out"
nohup blastn -db $DB -query $INPUT -out $OUTPUTFOLDER$OUTPUTEND -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore slen" -evalue 1e-2 -num_alignments 25 -num_threads 1 > $OUTPUTFOLDER$NOHUPEND 2>&1&

#be careful of duplicate seq id's, since you've concatenated separate velvet run contigs into one file for the database