
S[0]="006A_S1"
S[1]="009A_S2"
S[2]="010A_S3"
S[3]="012A_S4"

OUTPUTFOLDER="/Groups/assembly/BVAB1_PROJECT/TrimmomaticOutput/"
SOURCEFOLDER="/Groups/assembly/BVAB1_PROJECT/BVABreads/"
SOURCEMID="_L001_R"
ONE="1"
TWO="2"
SOURCEEND="_001.fastq"
for i in ${S[@]}
	do
		echo $i
		echo $OUTPUTFOLDER$i/
		echo $OUTPUTFOLDER$i/$i.trimmomatic.trimlog
		echo $SOURCEFOLDER$i$SOURCEMID$ONE$SOURCEEND 
		echo $OUTPUTFOLDER$i/$i.trimmed.paired.1.fastq
		echo $OUTPUTFOLDER$i/$i.trimmed.unpaired.1.fastq
		mkdir $OUTPUTFOLDER$i/
		java -jar /Groups/assembly/bin/Trimmomatic-0.30/trimmomatic-0.30.jar PE -threads 4 -phred33 -trimlog $OUTPUTFOLDER$i/$i.trimmomatic.trimlog $SOURCEFOLDER$i$SOURCEMID$ONE$SOURCEEND $SOURCEFOLDER$i$SOURCEMID$TWO$SOURCEEND $OUTPUTFOLDER$i/$i.trimmed.paired.1.fastq $OUTPUTFOLDER$i/$i.trimmed.unpaired.1.fastq $OUTPUTFOLDER$i/$i.trimmed.paired.2.fastq $OUTPUTFOLDER$i/$i.trimmed.unpaired.2.fastq LEADING:30 TRAILING:30 MINLEN:90
	done