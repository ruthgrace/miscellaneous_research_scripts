#the first [sampledigits] digits are the sample number, in the rownames and the colnames
sampledigits = 2;
#the datasets must be differentiated in the sample names, as in 20B_gut versus 20B_saliva
datasets = c("gut","saliva")
labels = c("Gut","Oral")
#specifying which sample numbers belong to which condition
condition <- list()
condition [[1]] = c("12", "33", "01", "06", "11", "30", "27", "07", "02", "31", "35", "03", "28", "29", "17", "10", "09", "23", "32", "08")
condition [[2]] = c("05", "37", "36", "04", "16", "14", "20", "25", "40", "38", "21", "26", "39", "42", "19", "43", "24", "44", "41", "34")
names(condition) <- c("Progressive", "Regressive")
#output file for plots
pdf("unifrac_distance_plots.pdf")


#read in data
d <- read.table("weighted_unifrac_dm.txt",sep="\t",check.names=FALSE,row.names=1,header=TRUE,quote="")
#make sure that the rows and columns are in the same order
sorted <- d[order(colnames(d)),order(rownames(d))]
#get rid of duplicate distances (X to Y is the same as Y to X) and self-comparisons
sorted[lower.tri(sorted,diag=TRUE)]<-NA


#REPLICATES - boxplot all distances between the same sample (different replicates)
repdata <- list()
for (i in 1:length(datasets)) {
	#subset by condition
	repdata[[i]] <- sorted[grep(datasets[i],colnames(sorted)),grep(datasets[i],rownames(sorted))]
	#get rid of distances between different samples, leaving distances between same samples
	for (colname in colnames(repdata[[i]])) {
		repdata[[i]][colname,-grep(substring(colname,1,sampledigits), rownames(repdata[[i]]))] <- NA
	}
	repdata[[i]] <- unlist(as.vector(repdata[[i]]))
}
names(repdata) <- labels
boxplot(repdata,main = "Weighted Unifrac Distance Within Samples, Between Replicates",xlab = "Origin of sample",ylab = "Unifrac distance within samples")


#SAMPLES
sampdata <- list()
for (i in 1:length(datasets)) {
	#subset by condition
	sampdata[[i]] <- sorted[grep(datasets[i],colnames(sorted)),grep(datasets[i],rownames(sorted))]
	#get rid of distances between the same samples, leaving distances between different samples
	for (colname in colnames(sampdata[[i]])) {
		sampdata[[i]][colname,grep(substring(colname,1,sampledigits), rownames(sampdata[[i]]))] <- NA
	}
	sampdata[[i]] <- unlist(as.vector(sampdata[[i]]))
}
names(sampdata) <- labels
boxplot(sampdata,main = "Weighted Unifrac Distance Between Samples",xlab = "Origin of sample",ylab = "Unifrac distance between samples")


#CONDITIONS
conddata <- list()
for (i in 1:length(datasets)) {
	#subset by location
	conddata[[i]] <- sorted[grep(datasets[i],colnames(sorted)),grep(datasets[i],rownames(sorted))]
	#get rid of distances between the same condition, leaving distances between different conditions
	conddata[[i]][which(substring(colnames(conddata[[i]]),1,sampledigits) %in% condition[[1]]), which(substring(rownames(conddata[[i]]),1,sampledigits) %in% condition[[1]])] <- NA
	conddata[[i]][which(substring(colnames(conddata[[i]]),1,sampledigits) %in% condition[[2]]), which(substring(rownames(conddata[[i]]),1,sampledigits) %in% condition[[2]])] <- NA
	conddata[[i]] <- unlist(as.vector(conddata[[i]]));
}
names(conddata) <- labels
boxplot(conddata,main = "Weighted Unifrac Distance Between\nPatients with Unexplained Progressive Atherosclerosis Versus\nPatients with Unexplained Regressive Atherosclerosis",xlab = "Origin of sample",ylab = "Unifrac distance between samples")

#LOCATION
locdata <- sorted
locdata[grep(datasets[1],colnames(sorted)),grep(datasets[1],rownames(sorted))] <- NA
locdata[grep(datasets[2],colnames(sorted)),grep(datasets[2],rownames(sorted))] <- NA
locdata <- unlist(as.vector(locdata))
boxplot(locdata,main = "Weighted Unifrac Distance Between\nSamples Taken From The Gut Versus\nSamples Taken From The Mouth",ylab = "Unifrac distance between samples")

dev.off()

