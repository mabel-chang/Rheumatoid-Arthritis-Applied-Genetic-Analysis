#QUESTION 1
plink --bfile TGEN_cleaned --covar TGEN_pcs.txt --logistic no-snp --allow-no-sex --out logist1

wc -l logist1.nosex

awk '$5 < 0.01' logist1.assoc.logistic


#QUESTION 2
plink --bfile TGEN_cleaned --covar TGEN_pcs.txt --covar-name PC6,PC8 --logistic beta hide-covar --allow-no-sex --out logist2

head -n 5 logist2.assoc.logistic

awk '$9 < 0.0001 {count++} END {print count}' logist2.assoc.logistic

awk 'NR==1 || $9 < min {min=$9; row=$0} END {print row}' logist2.assoc.logistic

plink --bfile TGEN_cleaned --snps rs41377151 --recodeA --out snp_info2
head snp_info2.raw

plink --bfile TGEN_cleaned --covar TGEN_pcs.txt --covar-name PC6,PC8 --logistic hide-covar --allow-no-sex --out logist2.5


#QUESTION 3
plink --bfile TGEN_cleaned --indep-pairwise 10000kb 1 0.15
plink --bfile TGEN_cleaned --chr 1-22 --extract plink.prune.in --genome --out ibd3

wc -l ibd3.genome

plink --bfile TGEN_cleaned --chr 1-22 --extract plink.prune.in --make-rel square --out grm3
head grm3.rel.id

awk 'NR>1 && $1=="MAYO_10139"{if($10>max){max=$10;line=$0}} END {print line}' ibd3.genome


#QUESTION 4
cut -f1-5 grm3.rel |head -n 5
head -n 1 grm3.rel > grm3.MAYO10139
awk '$1=="CH18526"||$3=="CH18526"{print $0}' ibd3.genome> ibd3.MAYO10139
Rscript --vanilla GMMAT.R

awk '$11<0.0001 {count++} END {print count}' glmm4nocov
awk '$11<0.0001 {count++} END {print count}' glmm4PC6PC8cov

awk 'NR==1{min=$11}$11 < min{min=$11;row=$0} END {print row}' glmm4nocov
awk 'NR==1 {if ($11!="") min=$11} $11 != "" && $11<min {min=$11; row=$0} END {if(row!="") print row}' glmm4PC6PC8cov

awk 'NR > 1 && ($7 > max || NR == 2) {max = $7; row = $0} END {print row}' logist2.assoc.logistic
awk '$2 == "rs7079348" {print}' logist2.5.assoc.logistic
awk 'NR > 1 && ($9 > max || NR == 2) {max = $9; row = $0} END {print row}' glmm4nocov
awk 'NR > 1 && ($9 > max || NR == 2) {max = $9; row = $0} END {print row}' glmm4PC6PC8cov


#QUESTION 5
awk 'NR==1{$4="BP";$11="P"};{print $0}' glmm4nocov>glmm4nocov.txt
awk 'NR==1{$4="BP";$11="P"};{print $0}' glmm4PC6PC8cov>glmm4PC6PC8cov.txt
awk 'NF==11' glmm4PC6PC8cov.txt > glmm5PC6PC8cov.txt

Rscript --vanilla qqplot.R logist2.5.assoc.logistic PC68adj ADD
Rscript --vanilla qqplot.R glmm5PC6PC8cov.txt "glmm PC6PC8 covariates"
Rscript --vanilla qqplot.R glmm4nocov.txt "glmm nocovariates"


#Question 6
Rscript --vanilla gwaplot.R logist2.5.assoc.logistic "logistic PC adj analysis" pc6pc8_manhattan

