
OLDREADS="/Groups/assembly/BVAB1_PROJECT/TrimmomaticOutputHeadCrop15/"
NEWREADS="/Groups/assembly/BVAB1_PROJECT/TrimmomaticOutputHeadCrop15July24Reads/"
OUTPUTROOT="/Groups/assembly/BVAB1_PROJECT/CombinedTrimmedReads/"
SAMPLE=""

for dir in $OLDREADS*/; do
  echo "$dir"
  SAMPLE=`basename $dir`
  echo $SAMPLE
  mkdir $OUTPUTROOT$SAMPLE/
  cat $OLDREADS$SAMPLE/$SAMPLE.trimmed.paired.2.fastq $NEWREADS$SAMPLE/$SAMPLE.trimmed.paired.2.fastq > $OUTPUTROOT$SAMPLE/$SAMPLE.trimmed.paired.2.fastq
done
