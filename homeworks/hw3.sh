#Question 2
awk '$2<-0.01&&($12=="Case"||$12=="Control"){print $0}' TGEN_hapmap_pruned.evec> outliers.txt

#Question 3
plink --bfile TGEN_cleaned --maf 0.02 --geno 0.02 --indep-pairwise 10000kb 1 0.2 --out TGEN_prune1 --allow-no-sex --make-bed --chr 1-22

head TGEN_prune1.bim

wc -l TGEN_prune1.bim

smartpca -p TGEN_prune1.par > TGEN_prune1.out

Rscript --vanilla hw3_plot.R TGEN_prune1.evec 1 2 10

#Question 4
plink --bfile TGEN_cleaned --maf 0.02 --geno 0.01 --indep-pairwise 10000kb 1 0.15 --out TGEN_prune2 --allow-no-sex --make-bed --chr 1-22

head TGEN_prune2.bim

wc -l TGEN_prune2.bim

smartpca -p TGEN_prune2.par > TGEN_prune2.out

Rscript --vanilla hw3_plot.R TGEN_prune2.evec 1 2 10
