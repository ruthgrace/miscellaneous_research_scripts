d <- read.table("/Groups/LRGC/atherosclerosis/analysis_A/td_OTU_tag_mapped_lineage.txt", header=T, sep="\t")

#gut samples have all the numbers 2 digits, saliva samples don't (Ruth's mistake, sorry!). Making saliva sample numbers all 2 digits just in case. The rest of the script should work fine without this.

colnames(d) <- gsub('(X)([123456789][ABC]_)','\\10\\2',colnames(d))

#colnames(d) <- sub('^X','',colnames(d))
#write.table(d,"/Groups/LRGC/atherosclerosis/analysis_A/td_OTU_tag_mapped_lineage_FIXED_SAMPLE_NUMBERS.txt",append=FALSE,quote=FALSE,sep="\t")

d.agg <- aggregate(d[,1:ncol(d) -1], by=list(Category=d$X), FUN=sum)
d.agg <- d.agg[,order(colnames(d.agg))]

#sample names in progressive and regressive groups
progressive <- c("12", "33", "01", "06", "11", "30", "27", "07", "02", "31", "35", "08", "03", "28", "29", "17", "10", "09", "23", "32")
regressive <- c("05", "37", "36", "04", "16", "14", "20", "25", "40", "38", "21", "26", "39", "42", "19", "43", "24", "44", "41", "34")
allsamples <- c(progressive,regressive)

#returns a list with [aldex.in, condition]
formataldexinput <- function(data,group1,group2,pattern,pattern2=pattern,group1name,group2name) {
	group1indices <- unlist(lapply(group1,function(x) grep(paste(x,pattern,sep=""),colnames(data))))
	group2indices <- unlist(lapply(group2,function(x) grep(paste(x,pattern2,sep=""),colnames(data))))
	aldex.in <- data.frame(data[,c(group1indices,group2indices)])
condition <- c(rep(group1name,length(group1indices)),rep(group2name,length(group2indices)))
return(list(aldex.in,condition))
}

makealdexpdfplot <- function(name,aldexoutput) {
	pdf(name)
	plot.aldex(aldexoutput, type = "MW")
	plot.aldex(aldexoutput, type = "MA")
	dev.off()
}


library(ALDEx)

#gutA
print("starting gut analysis for A replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=progressive, group2=regressive, pattern="A_gut", group1name="P", group2name="R")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
gutax <- aldex(aldex.in,condition)
gutay <- summary.aldex(gutax)
write.table(gutay, file="Gut_Replicate_A_Progressive_vs_Regressive_ALDEx_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Gut_Replicate_A_Progressive_vs_Regressive_ALDEx_results.pdf",gutax)
print("done gut analysis for A replicates")

#gutB
print("starting gut analysis for B replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=progressive, group2=regressive, pattern="B_gut", group1name="P", group2name="R")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
gutbx <- aldex(aldex.in,condition)
gutby <- summary.aldex(gutbx)
write.table(gutby, file="Gut_Replicate_B_Progressive_vs_Regressive_ALDEx_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Gut_Replicate_B_Progressive_vs_Regressive_ALDEx_results.pdf",gutbx)
print("done gut analysis for B replicates")

#gutC
print("starting gut analysis for C replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=progressive, group2=regressive, pattern="C_gut", group1name="P", group2name="R")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
gutcx <- aldex(aldex.in,condition)
gutcy <- summary.aldex(gutcx)
write.table(gutcy, file="Gut_Replicate_C_Progressive_vs_Regressive_ALDEx_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Gut_Replicate_C_Progressive_vs_Regressive_ALDEx_results.pdf",gutcx)
print("done gut analysis for C replicates")

#salivaA
print("starting saliva analysis for A replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=progressive, group2=regressive, pattern="A_saliva", group1name="P", group2name="R")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
salax <- aldex(aldex.in,condition)
salay <- summary.aldex(salax)
write.table(salay, file="Saliva_Replicate_A_Progressive_vs_Regressive_ALDEx_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Saliva_Replicate_A_Progressive_vs_Regressive_ALDEx_results.pdf",salax)
print("done saliva analysis for A replicates")

#salivaB
print("starting saliva analysis for B replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=progressive, group2=regressive, pattern="B_saliva", group1name="P", group2name="R")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
salbx <- aldex(aldex.in,condition)
salby <- summary.aldex(salbx)
write.table(salby, file="Saliva_Replicate_B_Progressive_vs_Regressive_ALDEx_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Saliva_Replicate_B_Progressive_vs_Regressive_ALDEx_results.pdf",salbx)
print("done saliva analysis for B replicates")

#salivaC
print("starting saliva analysis for C replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=progressive, group2=regressive, pattern="C_saliva", group1name="P", group2name="R")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
salcx <- aldex(aldex.in,condition)
salcy <- summary.aldex(salcx)
write.table(salcy, file="Saliva_Replicate_C_Progressive_vs_Regressive_ALDEx_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Saliva_Replicate_C_Progressive_vs_Regressive_ALDEx_results.pdf",salcx)
print("done saliva analysis for C replicates")

#AB
print("starting analysis for A vs B replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=allsamples, group2=allsamples, pattern="A_",pattern2="B_", group1name="A", group2name="B")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
abx <- aldex(aldex.in,condition)
aby <- summary.aldex(abx)
write.table(aby, file="Replicate_A_vs_Replicate_B_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Replicate_A_vs_Replicate_B_ALDEx_results.pdf",abx)
print("done analysis for A vs B replicates")
#AC
print("starting analysis for A vs C replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=allsamples, group2=allsamples, pattern="A_",pattern2="C_", group1name="A", group2name="C")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
acx <- aldex(aldex.in,condition)
acy <- summary.aldex(acx)
write.table(acy, file="Replicate_A_vs_Replicate_C_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Replicate_A_vs_Replicate_C_ALDEx_results.pdf",acx)
print("done analysis for A vs C replicates")
#BC
print("starting analysis for B vs C replicates...")
aldexinputs <- formataldexinput(data=d.agg, group1=allsamples, group2=allsamples, pattern="B_",pattern2="C_", group1name="B", group2name="C")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
bcx <- aldex(aldex.in,condition)
bcy <- summary.aldex(bcx)
write.table(bcy, file="Replicate_B_vs_Replicate_C_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Replicate_B_vs_Replicate_C_ALDEx_results.pdf",bcx)
print("done analysis for B vs C replicates")

#gut vs saliva
print("starting analysis for gut vs saliva ...")
aldexinputs <- formataldexinput(data=d.agg, group1=allsamples, group2=allsamples, pattern="[ABC]_gut",pattern2="[ABC]_saliva", group1name="G", group2name="S")
aldex.in <- aldexinputs[[1]]
condition <- aldexinputs[[2]]
gsx <- aldex(aldex.in,condition)
gsy <- summary.aldex(gsx)
write.table(gsy, file="Gut_vs_Saliva_results.txt", append=FALSE, quote=FALSE, sep="\t")
makealdexpdfplot("Gut_vs_Saliva_ALDEx_results.pdf",gsx)
print("done analysis for gut vs saliva")


print("done")
