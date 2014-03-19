S[0]="006A_S1"
S[1]="009A_S2"
S[2]="010A_S3"
S[3]="012A_S4"
SOURCESTART="/Groups/assembly/VelvetBVABOutput/"
SOURCEEND="/contigs.fa"
ONE="1"
TWO="2"
OUTPUTFOLDER="/Groups/assembly/BLASTinput/lengthover500coverageover2/"

for samplenum in ${S[@]}
	do
		echo $samplenum
		echo $SOURCESTART$samplenum$SOURCEEND 
		echo $OUTPUTFOLDER$samplenum.fasta
		perl /Groups/assembly/outputsequenceswithspecificlength.pl $SOURCESTART$samplenum$SOURCEEND $OUTPUTFOLDER$samplenum.fasta
	done
	
	
	
# S[0]="001"
# S[1]="002"
# S[2]="003"
# S[3]="004"
# S[4]="005"
# S[5]="021"
# SOURCESTART="/Groups/assembly/VelvetOutput/lane8_RP1_GCCAAT_L008_R_"
# SOURCEEND="/contigs.fa"
# ONE="1"
# TWO="2"
# OUTPUTFOLDER="/Groups/assembly/PRICEseeds/30pluscoverage33gut/"

# for samplenum in ${S[@]}
	# do
		# echo $SOURCESTART$samplenum$SOURCEMID$ONE$SOURCEEND 
		# echo $OUTPUTFOLDER$samplenum$SOURCEMID$ONE.fasta
		# perl /Groups/assembly/outputsequenceswithspecificcoverage.pl $SOURCESTART$samplenum$SOURCEEND $OUTPUTFOLDER$samplenum.fasta
	# done
		# echo $samplenum