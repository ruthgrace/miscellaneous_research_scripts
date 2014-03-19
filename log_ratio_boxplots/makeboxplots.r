gutab <- read.table("gut_A_vs_B_t_test.txt", header=T, row.names=1, quote="", sep="\t", check.names=F)
gutbc <- read.table("gut_B_vs_C_t_test.txt", header=T, row.names=1, quote="", sep="\t", check.names=F)
gutac <- read.table("gut_A_vs_C_t_test.txt", header=T, row.names=1, quote="", sep="\t", check.names=F)

salab <- read.table("sal_A_vs_B_t_test.txt", header=T, row.names=1, quote="", sep="\t", check.names=F)
salbc <- read.table("sal_B_vs_C_t_test.txt", header=T, row.names=1, quote="", sep="\t", check.names=F)
salac <- read.table("sal_A_vs_C_t_test.txt", header=T, row.names=1, quote="", sep="\t", check.names=F)

prgut <- read.table("gut_prog_vs_reg_t_test.txt", header=T, row.names=1, quote="", sep="\t", check.names=F)
prsal <- read.table("sal_prog_vs_reg_t_test.txt", header=T, row.names=1, quote="", sep="\t", check.names=F)


#Plotting proportions of progressive/regressive

#READ IN YOUR NOTES WHICH PLOTS GREG WANTED

# try different residual cutoffs
# try ones with more reads only

#name the outliers
#mothur

pdf("atherosclerosis_logratiotransform_boxplots.pdf")

#gut A B C all
boxplot(gutab$meanB-gutab$meanN,gutbc$meanB-gutbc$meanN,gutac$meanB-gutac$meanN,names=c("Replicate B-A","Replicate C-B","Replicate C-A"),main = "Proportion of OTU abundance between replicate gut samples")
#saliva A B C all
boxplot(salab$meanB-salab$meanN,salbc$meanB-salbc$meanN,salac$meanB-salac$meanN,names=c("Replicate B-A","Replicate C-B","Replicate C-A"),main = "Proportion of OTU abundance between replicate saliva samples")


#Plotting proportions of regressive/progressive

#gut A B C all
boxplot(prgut$meanB-prgut$meanN,prsal$meanB-prsal$meanN,names=c("Gut","Saliva"),main = "Proportion of OTU abundance for progressive/regressive conditions")

dev.off()
