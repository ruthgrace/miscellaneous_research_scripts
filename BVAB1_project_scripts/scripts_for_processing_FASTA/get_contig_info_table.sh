
#FOLDER="VelvetBVABOutput/"
#FOLDER="TrimmedVelvetOutputMinLen100HeadCrop15/"
#FOLDER="TrimmedVelvetOutputMinLen100/"
#FOLDER="TrimmedVelvetOutput/"
#FOLDER="TrimmedPooledVelvetBVABOutput/"
FOLDER="TrimmedCombinedVelvetOutput/"

INPUTROOT="/Groups/assembly/BVAB1_PROJECT/"
OUTPUTROOT="/Groups/assembly/BVAB1_PROJECT/comparetrim/"
CONTIGFILE="contigs.fa"
SAMPLE=""

for dir in $INPUTROOT$FOLDER*/; do
  echo "$dir$CONTIGFILE"
  SAMPLE=`basename $dir`
  echo $SAMPLE
  # echo -n "" > $OUTPUTROOT$FOLDER$SAMPLE/contig_info.tsv
  mkdir $OUTPUTROOT$FOLDER$SAMPLE/
  grep "^>" $dir$CONTIGFILE | tr -d ">" | tr "_" "\t" > $OUTPUTROOT$FOLDER$SAMPLE/contig_info.tsv  
done
