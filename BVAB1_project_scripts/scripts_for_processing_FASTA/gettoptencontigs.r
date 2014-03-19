samples <- c("006A_S1","009A_S2","010A_S3","012A_S4")

seqids <- list()
folder="SubtractiveEnrichmentVelvetOutput"
lengths <- list()
n50 <- c()
for (i in 1:length(samples)) {
	print(paste("starting",samples[[i]]))
	seqids[[i]] <- read.table(paste("./",folder,"/",samples[i],"/","seqIDs.txt",sep=""),sep="\t",quote="",stringsAsFactors=FALSE,header=FALSE)
	lengths[[i]] <- apply(seqids[[i]],1,function(x) as.numeric(strsplit(x[1],"_")[[1]][4]))
	lengths[[i]] <- lengths[[i]]+30 #lengths is in kmers, correcting to bp
	lengths[[i]] <- lengths[[i]][rev(order(lengths[[i]]))]
	write.table(lengths[[i]][1:10],file=paste("./",folder,"/",samples[i],"/","largest10contigs.txt",sep=""),row.names=FALSE,col.names=FALSE,quote=FALSE,sep="\t",append=FALSE)
	print(paste("finishing",samples[[i]]))
}

#* * * * * * * * * * * * * * * * * * * * * * * * *#
#TrimmedPooledVelvetBVABOutput
#* * * * * * * * * * * * * * * * * * * * * * * * *#
# folder <- "TrimmedPooledVelvetBVABOutput"
# seqids <- read.table(paste("./",folder,"/seqIDs.txt",sep=""),sep="\t",quote="",stringsAsFactors=FALSE,header=FALSE)
# lengths <- apply(seqids,1,function(x) as.numeric(strsplit(x[1],"_")[[1]][4]))
# lengths <- lengths+30
# totalsum <- sum(lengths)
# currentsum <- 0
# for (j in 1:length(lengths)) {
	# currentsum <- currentsum + lengths[j]
	# if (currentsum <= (totalsum/2)) {
		# j <- length(lengths)
		# n50 <- lengths[j]
	# }
# }
# write.table(n50,file=paste("./",folder,"/n50.txt",sep=""),row.names=FALSE,col.names=FALSE,quote=FALSE,sep="\t")