DIR="/Groups/assembly/VelvetOutput/"
FNAME="toptencontiglengths.txt"
FASTA="contigs.fa"
OUTPUTFILE="toptencontigsforPRICE.txt"
SEP="/"
for f in $( ls $DIR ); do
	./gettoptenseq.pl $DIR$f$SEP$FNAME $DIR$f$SEP$FASTA $DIR$f$SEP$OUTPUTFILE
done