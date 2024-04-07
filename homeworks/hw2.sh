#Use the TGEN Alzheimer data located in  /projectnb/bs859/data/tgen
export DATADIR=/projectnb/bs859/data/tgen
#The files are:TGEN.bim, TGEN.fam, TGEN.bed.

#Use plink version 1.9.0b6.27
module load plink/1.90b6.27

##QUESTION 1
#How many individuals are in the TGEN dataset?
wc -l $DATADIR/TGEN.fam

#How many variants?
wc -l $DATADIR/TGEN.bim

##QUESTION 2
#Create a summary file of allele frequencies for all variants
plink --bfile $DATADIR/TGEN --freq --out freq1

#How many variants have no minor (A1) allele homozygotes?
plink --bfile $DATADIR/TGEN --freqx --out freqx
#Count how many rows in the A1-homo column is equal to 0
awk -F'\t' '$5 == 0 {count++} END {print count}' freqx.frqx

##QUESTION 3
#first filtered dataset
plink --bfile $DATADIR/TGEN --maf 0.01 --mind 0.05 --hwe 0.000001 --geno 0.05 --make-bed --out tgen1

##QUESTION 4
#second filtered dataset
plink --bfile $DATADIR/TGEN --maf 0.01 --mind 0.05 --hwe 0.000001 --make-bed --out tgen2a
plink --bfile tgen2a --geno 0.05 --make-bed --out tgen2

#difference between question 3 and question 4 dataset
diff <(sort tgen1.irem) <(sort tgen2a.irem) | grep "^>" | cut -c 3-

##QUESTION 6
#differential missingness by case status
plink --bfile tgen1 --test-missing --out cctest
###DOES NOT WORK :(

##QUESTION 7
#pruning
plink --bfile tgen1 --indep-pairwise 10000 kb 1 0.2 --out try1
#number of variants remaining
wc -l try1.prune.in

##QUESTION 8
#pariwise IBD
plink --bfile tgen1 --chr 1-22 --extract try1.prune.in --genome --out ibd
#pairs more than 25%
awk '$10>0.25 {count++} END {print count}' ibd.genome > ibd.more25.genome
#individuals more than 25%
awk '$10 > 0.25 {individuals[$1]; individuals[$3]} END {print length(individuals)}' ibd.genome
#genetic duplicates
awk '$10 > 0.95 {count++} END {print count}' ibd.genome
#summarize non genetic duplicates
awk '$10 < 0.95 && $10 > 0.25' ibd.genome > ibd.nongendup.genome

##QUESTION 9
#median F over individuals
plink --bfile tgen1 -chr 1-22 -extract try1.prune.in \--het --out Fstat
#In R file
#Individuals F < -0.2
awk '$6 < -0.20' Fstat.het > Fstat.less0.2.het
#individuals F > 0.1
awk '$6 > 0.10' Fstat.het > Fstat.more0.1.het
