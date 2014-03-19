#ADD MATCH LENGTH ONTO BLAST REFSEQ ID

trim.leading <- function (x)  sub("^\\s+", "", x)

samples <- c("006A_S1","009A_S2","010A_S3","012A_S4")

for (i in 1:length(samples)) {
	blastout <- read.table(paste("./",samples[i],"/",samples[i],"_BLASTXoutput.tsv",sep=""),sep="\t",quote="",stringsAsFactors=TRUE,check.names=FALSE)
	newblastout <- blastout
	newblastout[, 1] <- apply(blastout,1,function(x) paste(c(strsplit(x[1],"_")[[1]][1:2],"MATCHLEN",trim.leading(x[4]),strsplit(x[1],"_")[[1]][3:length(strsplit(x[1],"_")[[1]])]),collapse="_"))
	write.table(newblastout,file=paste("./",samples[i],"/",samples[i],"_BLASTXoutput_with_matchlen.tsv",sep=""),row.names=FALSE,col.names=FALSE,quote=FALSE)
}