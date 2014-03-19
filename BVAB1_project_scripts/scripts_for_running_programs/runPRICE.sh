
# MAY HAVE TO OPTIMIZE AMPLICON SIZE UNTIL GREG GETS BACK TO YOU, START AT 500

INPUTFOLDER="/Groups/assembly/reads/"

SAMPLESTART="lane8_RP1_GCCAAT_L008_R"
ONE="1_"
TWO="2_"
SAMPLE[0]=001
SAMPLE[1]=002
SAMPLE[2]=003
SAMPLE[3]=004
SAMPLE[4]=005
SAMPLE[5]=021
SAMPLEEND=".fastq"

OUTPUTFOLDER="/Groups/assembly/PRICEoutput/"

SEEDSTART="/Groups/assembly/VelvetOutput/lane8_RP1_GCCAAT_L008_R_"
SEEDEND="/toptencontigsforPRICE.fasta"

for i in $SAMPLE
	do
		/Groups/assembly/bin/PriceSource130506/PriceTI -fpp $INPUTFOLDER$SAMPLESTART$ONE$i$SAMPLEEND $INPUTFOLDER$SAMPLESTART$TWO$i$SAMPLEEND 500 95 -icf $SEEDSTART$i$SEEDEND 1 1 5 -nc 30 -dbmax 72 -mol 30 -tol 20 -mpi 80 -target 90 2 1 1 -o /Groups/assembly/PRICEoutput/$i.fasta
	done

# /Groups/assembly/bin/PriceSource130506/PriceTI -fpp /Groups/assembly/reads/lane8_RP1_GCCAAT_L008_R1_001.fastq /Groups/assembly/reads/lane8_RP1_GCCAAT_L008_R2_001.fastq 500 95 -icf sangerReads.fasta 1 1 5 -nc 30 -dbmax 72 -mol 30 -tol 20 -mpi 80 -target 90 2 1 1 -o practice.


# nohup ./PriceTI -fpp /Groups/assembly/reads/lane8_RP1_GCCAAT_L008_R1_001.fastq /Groups/assembly/reads/lane8_RP1_GCCAAT_L008_R2_001.fastq 300 95 -icf sangerReads.fasta 1 1 5 -nc 30 -dbmax 72 -mol 30 -tol 20 -mpi 80 -target 90 2 1 1 -o practice. 2> "PRICEOutputSummary.txt" &