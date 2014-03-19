# Ruth Wong
# November 23 2013

# this finds the sum of OTU abundance in selected samples, divides by number of samples if weighted, and then subtracts the mean abundance per OTU.
getOTUsums <- function(data,samples,pattern,weighted) {
	indices <- unlist(lapply(samples,function(x) grep(paste(x,pattern,sep=""),colnames(data))))
	if (weighted) {
		summeddata <- apply(data[indices],1,function(x) sum(x)/length(indices))
		return(summeddata - mean(summeddata))
	}
	summeddata <- apply(data[indices],1,function(x) sum(x))
	return(summeddata - mean(summeddata))
}


d <- read.table("/Groups/LRGC/atherosclerosis/analysis_A/td_OTU_tag_mapped_lineage.txt", header=T, sep="\t")

#gut samples have all the numbers 2 digits, saliva samples don't (Ruth's mistake, sorry!). Making saliva sample numbers all 2 digits just in case. The rest of the script should work fine without this.

colnames(d) <- gsub('(X)([123456789][ABC]_)','\\10\\2',colnames(d))

#colnames(d) <- sub('^X','',colnames(d))
#write.table(d,"/Groups/LRGC/atherosclerosis/analysis_A/td_OTU_tag_mapped_lineage_FIXED_SAMPLE_NUMBERS.txt",append=FALSE,quote=FALSE,sep="\t")

d.agg <- aggregate(d[,1:ncol(d) -1], by=list(Category=d$X), FUN=sum)
d.agg <- d.agg[,order(colnames(d.agg))]

###########################################
#boxplots with proportions, data shifted so that average is at 0 for each OTU
# * assuming that negative residuals represent unexplained progressive atherosclerosis *

progressive <- c("12", "33", "01", "06", "11", "30", "27", "07", "02", "31", "35", "08", "03", "28", "29", "17", "10", "09", "23", "32")
regressive <- c("05", "37", "36", "04", "16", "14", "20", "25", "40", "38", "21", "26", "39", "42", "19", "43", "24", "44", "41", "34")
allsamples <- c(progressive,regressive)

#Progressive vs Regressive all gut
pgut <- getOTUsums(d.agg,progressive,"[ABC]_gut",FALSE)
rgut <- getOTUsums(d.agg,regressive,"[ABC]_gut",FALSE)
prgut <- pgut/rgut
rpgut <- rgut/pgut

#Progressive vs Regressive all saliva
psal <- getOTUsums(d.agg,progressive,"[ABC]_saliva",FALSE)
rsal <- getOTUsums(d.agg,regressive,"[ABC]_saliva",FALSE)
prsal <- psal/rsal
rpsal <- rsal/psal


#Progressive vs Regressive all gut A
pguta <- getOTUsums(d.agg,progressive,"A_gut",FALSE)
rguta <- getOTUsums(d.agg,regressive,"A_gut",FALSE)
prguta <- pguta/rguta
rpguta <- rguta/pguta

#Progressive vs Regressive all saliva A
psala <- getOTUsums(d.agg,progressive,"A_saliva",FALSE)
rsala <- getOTUsums(d.agg,regressive,"A_saliva",FALSE)
prsala <- psala/rsala
rpsala <- rsala/psala


#Progressive vs Regressive all gut B
pgutb <- getOTUsums(d.agg,progressive,"B_gut",FALSE)
rgutb <- getOTUsums(d.agg,regressive,"B_gut",FALSE)
prgutb <- pgutb/rgutb
rpgutb <- rgutb/pgutb

#Progressive vs Regressive all saliva B
psalb <- getOTUsums(d.agg,progressive,"B_saliva",FALSE)
rsalb <- getOTUsums(d.agg,regressive,"B_saliva",FALSE)
prsalb <- psalb/rsalb
rpsalb <- rsalb/psalb


#Progressive vs Regressive all gut C
pgutc <- getOTUsums(d.agg,progressive,"C_gut",FALSE)
rgutc <- getOTUsums(d.agg,regressive,"C_gut",FALSE)
prgutc <- pgutc/rgutc
rpgutc <- rgutc/pgutc

#Progressive vs Regressive all saliva C
psalc <- getOTUsums(d.agg,progressive,"C_saliva",FALSE)
rsalc <- getOTUsums(d.agg,regressive,"C_saliva",FALSE)
prsalc <- psalc/rsalc
rpsalc <- rsalc/psalc


#all gut vs all saliva
allg <- getOTUsums(d.agg,allsamples,"[ABC]_gut",FALSE)
alls <- getOTUsums(d.agg,allsamples,"[ABC]_saliva",FALSE)
allgs <- allg/alls
allsg <- alls/allg


#A vs B vs C
a <- getOTUsums(d.agg,allsamples,"A_",FALSE)
b <- getOTUsums(d.agg,allsamples,"B_",FALSE)
c <- getOTUsums(d.agg,allsamples,"C_",FALSE)
ab <- a/b
ba <- b/a
ac <- a/c
ca <- c/a
bc <- b/c
cb <- c/b

pdf("boxplots_straight_proportions_with_average_at_zero.pdf")

#Plotting proportions of progressive/regressive

#gut A B C all
boxplot(prguta,prgutb,prgutc,prgut,names=c("Replicate A","Replicate B","Replicate C","All Replicates"),main = "Proportion of OTU abundance between progressive/regressive gut samples, with outliers")
#gut A B C all
boxplot(prguta,prgutb,prgutc,prgut,names=c("Replicate A","Replicate B","Replicate C","All Replicates"),main = "Proportion of OTU abundance between progressive/regressive gut samples, without outliers",outline=FALSE)

#saliva A B C all
boxplot(prsala,prsalb,prsalc,prsal,names=c("Replicate A","Replicate B","Replicate C","All Replicates"),main = "Proportion of OTU abundance between progressive/regressive saliva samples, with outliers")
#saliva A B C all
boxplot(prsala,prsalb,prsalc,prsal,names=c("Replicate A","Replicate B","Replicate C","All Replicates"),main = "Proportion of OTU abundance between progressive/regressive saliva samples, without outliers",outline=FALSE)


#Plotting proportions of regressive/progressive

#gut A B C all
boxplot(rpguta,rpgutb,rpgutc,rpgut,names=c("Replicate A","Replicate B","Replicate C","All Replicates"),main = "Proportion of OTU abundance between regressive/progressive gut samples, with outliers")
boxplot(rpguta,rpgutb,rpgutc,rpgut,names=c("Replicate A","Replicate B","Replicate C","All Replicates"),main = "Proportion of OTU abundance between regressive/progressive gut samples, without outliers",outline=FALSE)

#saliva A B C all
boxplot(rpsala,rpsalb,rpsalc,rpsal,names=c("Replicate A","Replicate B","Replicate C","All Replicates"),main = "Proportion of OTU abundance between regressive/progressive saliva samples, with outliers")
boxplot(rpsala,rpsalb,rpsalc,rpsal,names=c("Replicate A","Replicate B","Replicate C","All Replicates"),main = "Proportion of OTU abundance between regressive/progressive saliva samples, without outliers",outline=FALSE)


#Plotting proportions of A vs B vs C replicates
boxplot(ab,ba,ac,ca,bc,cb,names=c("A/B","B/A","A/C","C/A","B/C","C/B"),main = "Proportion of OTU abundance between A vs B vs C replicates, with outliers")
boxplot(ab,ba,ac,ca,bc,cb,names=c("A/B","B/A","A/C","C/A","B/C","C/B"),main = "Proportion of OTU abundance between A vs B vs C replicates, without outliers",outline=FALSE)

dev.off()

