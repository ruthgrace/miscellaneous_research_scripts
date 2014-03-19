samples <- c("006A_S1","009A_S2","010A_S3","012A_S4")

seqids <- list()
folder="TrimmedVelvetOutput"
lengths <- list()
n50 <- c()
for (i in 1:length(samples)) {
	seqids[[i]] <- read.table(paste("./",folder,"/",samples[i],"/","seqIDs.txt",sep=""),sep="\t",quote="",stringsAsFactors=FALSE,header=FALSE)
	lengths[[i]] <- apply(seqids[[i]],1,function(x) as.numeric(strsplit(x[1],"_")[[1]][4]))
	lengths[[i]] <- lengths[[i]]+30 #lengths is in kmers, correcting to bp
	totalsum <- sum(lengths[[i]])
	currentsum <- 0
	for (j in 1:length(lengths[[i]])) {
		currentsum <- currentsum + lengths[[i]][j]
		if (currentsum <= (totalsum/2)) {
			j <- length(lengths[[i]])
			n50[i] <- lengths[[i]][j]
		}
	}
	write.table(n50[i],file=paste("./",folder,"/",samples[i],"/","n50.txt",sep=""),row.names=FALSE,col.names=FALSE,quote=FALSE,sep="\t")
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