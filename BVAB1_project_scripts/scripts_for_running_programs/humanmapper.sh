#/Groups/twntyfr/bin/bowtie2-2.1.0/bowtie2 --sensitive -x /Groups/twntyfr/index/hg19 -U 001A_ATCACG_L001_R1_001.fastq -S test.sam --un unaligned.out -p 2 & 



SAMPLE="/Groups/assembly/Bowtie2MiSeqOutput/GloorPool2013-06-23_S1_L001_001"

MATE1="/Groups/assembly/MiSeq/GloorPool2013-06-23_S1_L001_R1_001.fastq"
MATE2="/Groups/assembly/MiSeq/GloorPool2013-06-23_S1_L001_R2_001.fastq"

nohup /Groups/twntyfr/bin/bowtie2-2.1.0/bowtie2 --very-sensitive -x /Groups/twntyfr/index/hg19 -1 $MATE1 -2 $MATE2 -S $SAMPLE.human.sam --un $SAMPLE.nonhuman.fastq -p 8 2> $SAMPLE.human.summary.txt & 




