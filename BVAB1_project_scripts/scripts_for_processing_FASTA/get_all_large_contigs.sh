S[0]="006A_S1"
S[1]="009A_S2"
S[2]="010A_S3"
S[3]="012A_S4"
SOURCESTART="/Groups/assembly/BVAB1_PROJECT/TrimmedCombinedVelvetOutput/"
SOURCEEND="/contigs.fa"
OUTPUTFOLDER="/Groups/assembly/BVAB1_PROJECT/BLASTinput/lengthover50000/TrimmedCombinedVelvetOutput/"
mkdir $OUTPUTFOLDER
for samplenum in ${S[@]}
	do
		echo $samplenum
		echo $SOURCESTART$samplenum$SOURCEEND 
		echo $OUTPUTFOLDER$samplenum.fasta
		perl /Groups/assembly/BVAB1_PROJECT/getlargecontigs.pl $SOURCESTART$samplenum$SOURCEEND $OUTPUTFOLDER$samplenum.largecontigs.fasta
	done
	
