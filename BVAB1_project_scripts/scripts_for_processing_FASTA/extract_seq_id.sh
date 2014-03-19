S[0]="006A_S1"
S[1]="009A_S2"
S[2]="010A_S3"
S[3]="012A_S4"
#S[4]="pooled"
SOURCESTART="/Groups/assembly/BVAB1_PROJECT/TrimmedVelvetOutput/"
SOURCEEND="contigs.fa"
OUTPUTEND="seqIDs.txt"
for samplenum in ${S[@]}
	do
		perl /Groups/assembly/BVAB1_PROJECT/outputsequenceID.pl $SOURCESTART$samplenum/$SOURCEEND $SOURCESTART$samplenum/$OUTPUTEND
	done
