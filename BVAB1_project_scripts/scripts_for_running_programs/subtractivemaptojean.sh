
	
# BVAB
S[0]="006A_S1"
S[1]="009A_S2"
S[2]="010A_S3"
S[3]="012A_S4"
INPUTFOLDER="/Groups/assembly/BVAB1_PROJECT/CombinedTrimmedReads/"
OUTPUTFOLDER="/Groups/assembly/BVAB1_PROJECT/Bowtie2MappedReadsToJeansDB2/"
SAMPLEMID=".trimmed.paired."
ONE="1"
TWO="2"
SAMPLEEND=".fastq"
for i in ${S[@]}
	do
		SAMPLE=${i/.fasta/}
		echo $SAMPLE
		echo $i
		echo $INPUTFOLDER$SAMPLE$SAMPLEMID$ONE$SAMPLEEND
		echo $INPUTFOLDER$SAMPLE$SAMPLEMID$TWO$SAMPLEEND
		echo $SEEDFOLDER$i
		echo $OUTPUTFOLDER$SAMPLE/
		echo $OUTPUTFOLDER$SAMPLE/$SAMPLE/nonhuman/
		mkdir $OUTPUTFOLDER$SAMPLE/
		# -N number of mismatches
		/Groups/twntyfr/bin/bowtie2-2.1.0/bowtie2 --very-sensitive -N 1 -x /Groups/twntyfr/map_bac/all_bac_ncRNArm_medianorder_id90 -1 $INPUTFOLDER$SAMPLE/$SAMPLE$SAMPLEMID$ONE$SAMPLEEND -2 $INPUTFOLDER$SAMPLE/$SAMPLE$SAMPLEMID$TWO$SAMPLEEND -S $OUTPUTFOLDER$SAMPLE/$SAMPLE.mapresults.sam --un-conc $OUTPUTFOLDER$SAMPLE/$SAMPLE.unmapped.fastq --threads 8
	done
	
	
	
	